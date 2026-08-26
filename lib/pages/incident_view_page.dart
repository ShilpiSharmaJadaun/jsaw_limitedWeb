import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:web/web.dart' as html;

import '../bloc/downloadPdf_bloc.dart';
import '../model/allIncident_model.dart';
import '../model/compliance_api_models.dart';
import '../model/compliance_incident_model.dart';
import '../service/compliance_service.dart';
import '../service/incident_service.dart';
import '../state/downloadPdf_state.dart';
import '../utils/app_color.dart';
import '../utils/progressive_image.dart';
import 'compliance_incident_detail_page.dart';
import 'widgets/incident_filter.dart';
import '../utils/pdf_download.dart';
import '../error/api_error.dart';

/// All Incident page — read-only **View** of one incident (Phase-2 point 4).
///
/// Opened inline (app shell, back arrow) from the Received / Raised / All
/// tabs. Shows the whole chain for the record:
///   1. Incident Details          ┐ from the list row (always available, even
///   2. Medical Assessment        │ for incidents that have not reached the
///   3. Safety Observation        ┘ Safety team yet)
///   4. Investigation Details / CAPA / Risk photo — the existing compliance
///      detail sections, loaded on open (skipped when no investigation yet)
///   5. Compliance status — per-CAPA-owner submissions + overall stage
/// plus a workflow strip (current stage) and a Download FIR PDF button.
/// Strictly read-only: nothing here edits data.
class IncidentViewPage extends StatefulWidget {
  const IncidentViewPage({
    super.key,
    required this.incident,
    required this.onBack,
    this.showChain = true,
    this.title = 'Incident — View',
  });

  final AllIncidentModel incident;
  final VoidCallback onBack;

  /// When false (Safety Observation "Check Details"), only the Incident /
  /// Medical / Safety sections are shown — no workflow strip, no
  /// investigation / CAPA / compliance sections, and the two compliance
  /// bundle calls are skipped.
  final bool showChain;
  final String title;

  @override
  State<IncidentViewPage> createState() => _IncidentViewPageState();
}

class _IncidentViewPageState extends State<IncidentViewPage> {
  final ComplianceService _compliance = ComplianceService();
  late final DownloadPdfBloc _pdfBloc;

  /// Investigation bundle; `null` when the call fails or nothing exists yet.
  late final Future<ComplianceIncident?> _detail;

  /// Compliance review state; `null` when unavailable.
  late final Future<ComplianceReview?> _review;

  /// True once the bundle shows an investigation exists (enables Report PDF).
  bool _hasInvestigation = false;
  bool _invPdfBusy = false;

  Future<void> _downloadInvestigationPdf() async {
    if (_invPdfBusy) return;
    setState(() => _invPdfBusy = true);
    try {
      final incidentService =
          Provider.of<IncidentService>(context, listen: false);
      final bytes =
          await incidentService.downloadInvestigationPdfByUid(r.uniqueId);
      savePdfBytes('Investigation_Report_${r.uniqueId}.pdf', bytes);
    } on ApiError catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', ''))));
      }
    } finally {
      if (mounted) setState(() => _invPdfBusy = false);
    }
  }

  @override
  void initState() {
    super.initState();
    final incidentService =
        Provider.of<IncidentService>(context, listen: false);
    _pdfBloc = DownloadPdfBloc(incidentService);
    final id = widget.incident.uniqueId;
    if (widget.showChain) {
      _detail = _compliance
          .getComplianceDetailForReview(id)
          .then<ComplianceIncident?>((d) => d)
          .catchError((_) => null);
      _detail.then((d) {
        if (mounted && d != null && !d.investigation.isEmpty) {
          setState(() => _hasInvestigation = true);
        }
      });
      _review = _compliance
          .getComplianceForReview(id)
          .then<ComplianceReview?>((r) => r)
          .catchError((_) => null);
    } else {
      _detail = Future.value(null);
      _review = Future.value(null);
    }
  }

  @override
  void dispose() {
    _pdfBloc.close();
    super.dispose();
  }

  AllIncidentModel get r => widget.incident;

  bool get _hasMedical => r.medicalOfficerResponseDate.trim().isNotEmpty;
  bool get _hasSafety => r.safetyResponseDate.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DownloadPdfBloc, DownloadPdfState>(
      bloc: _pdfBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (uniqueId, bytes) {
            final safeName =
                uniqueId.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
            final blob = html.Blob(
              [bytes.toJS].toJS,
              html.BlobPropertyBag(type: 'application/pdf'),
            );
            final url = html.URL.createObjectURL(blob);
            html.HTMLAnchorElement()
              ..href = url
              ..setAttribute('download', '$safeName.pdf')
              ..click();
            html.URL.revokeObjectURL(url);
          },
          failed: (_, message) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message))),
          orElse: () {},
        );
      },
      child: Container(
        color: kcDashboardBg1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _header(),
            Expanded(
              child: FutureBuilder<List<Object?>>(
                future: Future.wait([_detail, _review]),
                builder: (context, snap) {
                  final loaded = snap.connectionState == ConnectionState.done;
                  final ComplianceIncident? detail =
                      loaded ? (snap.data?[0] as ComplianceIncident?) : null;
                  final ComplianceReview? review =
                      loaded ? (snap.data?[1] as ComplianceReview?) : null;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (widget.showChain) ...[
                              _WorkflowStrip(
                                stages: _stages(detail, review, loaded),
                              ),
                              const SizedBox(height: 16),
                            ],
                            _SectionCard(
                              title: 'Incident Details',
                              icon: Icons.assignment_outlined,
                              accent: kcStatBlue,
                              child: _incidentBody(),
                            ),
                            const SizedBox(height: 16),
                            _SectionCard(
                              title: 'Medical Assessment',
                              icon: Icons.medical_services_outlined,
                              accent: kcInfoFir,
                              child: _hasMedical
                                  ? _medicalBody()
                                  : _emptyHint(
                                      'Medical assessment not yet submitted for this incident.'),
                            ),
                            const SizedBox(height: 16),
                            _SectionCard(
                              title: 'Safety Observation',
                              icon: Icons.rate_review_outlined,
                              accent: kcobservationgreen,
                              child: _hasSafety
                                  ? _safetyBody()
                                  : _emptyHint(
                                      'Safety observation not yet submitted for this incident.'),
                            ),
                            const SizedBox(height: 16),
                            if (!widget.showChain)
                              const SizedBox.shrink()
                            else if (!loaded)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                child: Center(
                                    child: CircularProgressIndicator()),
                              )
                            else if (detail == null ||
                                detail.investigation.isEmpty)
                              _SectionCard(
                                title: 'Investigation Details',
                                icon: Icons.fact_check_outlined,
                                accent: kcvoilet,
                                child: _emptyHint(
                                    'Investigation not yet submitted for this incident.'),
                              )
                            else
                              // Investigation / CAPA / Risk photo — the same
                              // read-only sections the compliance pages use.
                              ComplianceIncidentDetailPage(
                                incident: detail,
                                onBack: () {},
                                sectionsOnly: true,
                                showCapa: true,
                                showIncidentSections: false,
                              ),
                            const SizedBox(height: 16),
                            if (widget.showChain && loaded)
                              _SectionCard(
                                title: 'Compliance Status',
                                icon: Icons.verified_outlined,
                                accent: kcmegenta,
                                child: _complianceBody(review, detail),
                              ),
                            const SizedBox(height: 28),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────── header
  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF7B2C), Color(0xFFEF4A8B), Color(0xFF8B5CF6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back to list',
            onPressed: widget.onBack,
            icon: const Icon(Icons.arrow_back, color: kcWhite),
          ),
          const SizedBox(width: 4),
          Text(
            widget.title,
            style: const TextStyle(
                color: kcWhite, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
            ),
            child: Text(
              r.uniqueId,
              style: const TextStyle(
                  color: kcWhite, fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
            decoration: BoxDecoration(
              color: kcWhite,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IncidentStagePill(
              status: r.status,
              investigationStatus: r.investigationStatus,
            ),
          ),
          const Spacer(),
          if (widget.showChain && _hasInvestigation) ...[
            ElevatedButton.icon(
              onPressed: _invPdfBusy ? null : _downloadInvestigationPdf,
              style: ElevatedButton.styleFrom(
                backgroundColor: kcWhite,
                foregroundColor: kcPdfIconRed,
                disabledBackgroundColor: Colors.white70,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
              icon: _invPdfBusy
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.download_outlined, size: 18),
              label: Text(_invPdfBusy ? 'Preparing…' : 'Investigation Report',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 8),
          ],
          BlocBuilder<DownloadPdfBloc, DownloadPdfState>(
            bloc: _pdfBloc,
            builder: (_, state) {
              final busy = state.maybeWhen(
                  loading: (id) => id == r.uniqueId, orElse: () => false);
              return ElevatedButton.icon(
                onPressed: busy ? null : () => _pdfBloc.downloadByUid(r.uniqueId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcWhite,
                  foregroundColor: kcvoilet,
                  disabledBackgroundColor: Colors.white70,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                ),
                icon: busy
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.picture_as_pdf_outlined, size: 18),
                label: Text(busy ? 'Preparing…' : 'Download FIR PDF',
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────── workflow strip
  /// Customer workflow (Phase-2 point 7 order). `done` = stage completed,
  /// the first not-done stage is the current one.
  List<_Stage> _stages(
      ComplianceIncident? detail, ComplianceReview? review, bool loaded) {
    final hasInvestigation = detail != null && !detail.investigation.isEmpty;
    final overall = (review?.overallStatus ?? '').trim().toUpperCase();
    final reviewDone = overall == 'REVIEW_COMPLETED' || overall == 'CLOSED';
    final closed = overall == 'CLOSED';
    return [
      const _Stage('Incident Reporting', true),
      _Stage('Medical Officer', _hasMedical),
      _Stage('Safety Observation', _hasSafety),
      _Stage('Investigation Details', hasInvestigation, pending: !loaded),
      _Stage('Investigation Initiated', hasInvestigation, pending: !loaded),
      _Stage('Compliance Review', reviewDone, pending: !loaded),
      _Stage('Compliance Closure', closed, pending: !loaded),
    ];
  }

  // ──────────────────────────────────────────────────────────────── bodies
  Widget _incidentBody() {
    final raisedBy = r.raisedByEmpCode.isEmpty
        ? r.raisedByEmpName
        : (r.raisedByEmpName.isEmpty
            ? r.raisedByEmpCode
            : '${r.raisedByEmpName} (${r.raisedByEmpCode})');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subLabel('Incident Image'),
        const SizedBox(height: 6),
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: kcDashboardBg2,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          clipBehavior: Clip.antiAlias,
          child: ProgressiveImage(
            highUrl: r.imageUrl,
            lowUrl: r.lowQualityImageUrl,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 14),
        _kvGrid([
          _KV('Incident Unique ID', r.uniqueId),
          _KV('Incident Type', r.incidentType),
          _KV('Incident Date / Time', r.incidentDateTime),
          _KV('FIR Received', r.firDateTime),
          _KV('Shift', r.shift),
          _KV('Work Injury', r.workInjury),
          _KV('Employee', '${r.employeeName} (${r.employeeCode})'),
          _KV('Age', r.age == 0 ? '' : r.age.toString()),
          _KV('Contractor', r.contractorName),
          _KV('Contractor Code', r.contCode),
          _KV('Plant', r.plant.trim()),
          _KV('Department', r.deptName.trim()),
          _KV('Location', r.location),
          _KV('Responsible Engineer', r.responsibleShiftEngg),
          _KV('Responsible HOD', r.responsibleHod),
          _KV('Contact Number', r.contactNumber),
          _KV('Status', incidentStatusLabel(r.status)),
          _KV('Raised By', raisedBy),
          _KV('Raised Date', r.raisedDate),
        ]),
        const SizedBox(height: 4),
        _longText('Description of Incident', r.descpOfIncident),
      ],
    );
  }

  Widget _medicalBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _kvGrid([
            _KV('Type of Injury', r.medicalOfficerTypeOfInjury),
            _KV('Body Part', r.bodyPart),
            _KV('Nature of Injury', r.natureOfInjury),
            _KV('Rest Upto (days)', r.restUpto),
            _KV('Fit For Duty From', r.fitForDutyFrom),
            _KV('Submitted On', r.medicalOfficerResponseDate),
          ]),
          _longText('Medical Officer Remarks', r.medicalOfficerRemarks),
        ],
      );

  Widget _safetyBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _kvGrid([
            _KV('Type of Injury (Safety)', r.safetyTypeOfInjury),
            _KV('Submitted On', r.safetyResponseDate),
          ]),
          _longText("Safety Officer's Remark", r.safetyRemarks),
        ],
      );

  Widget _complianceBody(ComplianceReview? review, ComplianceIncident? detail) {
    final hasInvestigation = detail != null && !detail.investigation.isEmpty;
    if (!hasInvestigation) {
      return _emptyHint(
          'Compliance actions start once the investigation is submitted.');
    }
    if (review == null) {
      return _emptyHint('Compliance status is not available for this incident.');
    }
    final overall = review.overallStatus;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _subLabel('Overall'),
            const SizedBox(width: 10),
            _pill(complianceStageLabel(overall, closureMode: true),
                complianceStageColor(overall)),
          ],
        ),
        const SizedBox(height: 12),
        if (review.assignees.isEmpty)
          _emptyHint('No compliance submissions yet.')
        else
          ...review.assignees.map(_assigneeTile),
      ],
    );
  }

  Widget _assigneeTile(ComplianceAssigneeReview a) {
    final color = complianceStatusColor(a.status);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kcDashboardBg1,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person_outline, size: 18, color: kcLabelGrey),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${a.empName} (${a.empUnqId})'
                  '${a.deptCode.isEmpty ? '' : ' · ${a.deptCode}'}',
                  style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: kcValueDark),
                ),
              ),
              _pill(complianceStatusLabel(a.status), color),
            ],
          ),
          if (a.submittedDate.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text('Submitted on ${a.submittedDate}',
                style: const TextStyle(fontSize: 12, color: kcLabelGrey)),
          ],
          if (a.remark.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(a.remark,
                style: const TextStyle(
                    fontSize: 13, color: kcValueDark, height: 1.35)),
          ],
          if (a.reviewRemark.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text('Review remark: ${a.reviewRemark}',
                style: const TextStyle(
                    fontSize: 12.5,
                    color: kcLabelGrey,
                    fontStyle: FontStyle.italic)),
          ],
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────── helpers
  Widget _pill(String text, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w700, color: color)),
      );

  Widget _emptyHint(String text) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kcDashboardBg1,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline, size: 16, color: kcLabelGrey),
            const SizedBox(width: 8),
            Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 13, color: kcLabelGrey, height: 1.35)),
            ),
          ],
        ),
      );

  Widget _kvGrid(List<_KV> items) {
    return LayoutBuilder(
      builder: (context, c) {
        final twoCol = c.maxWidth > 560;
        final colWidth = twoCol ? (c.maxWidth - 16) / 2 : c.maxWidth;
        return Wrap(
          spacing: 16,
          runSpacing: 4,
          children: items
              .map((kv) => SizedBox(width: colWidth, child: _kvRow(kv)))
              .toList(),
        );
      },
    );
  }

  Widget _kvRow(_KV kv) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 160,
              child: Text(kv.label,
                  style: const TextStyle(
                      fontSize: 12.5,
                      color: kcLabelGrey,
                      fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: Text(
                kv.value.trim().isEmpty ? '—' : kv.value,
                style: const TextStyle(
                    fontSize: 13.5,
                    color: kcValueDark,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );

  Widget _longText(String label, String value) => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _subLabel(label),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kcDashboardBg1,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                value.trim().isEmpty ? '—' : value,
                style: const TextStyle(
                    fontSize: 13.5, color: kcValueDark, height: 1.4),
              ),
            ),
          ],
        ),
      );

  Widget _subLabel(String text) => Text(
        text,
        style: const TextStyle(
            fontSize: 12.5,
            color: kcLabelGrey,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3),
      );
}

class _KV {
  final String label;
  final String value;
  const _KV(this.label, this.value);
}

class _Stage {
  final String label;
  final bool done;

  /// True while the data deciding this stage is still loading.
  final bool pending;
  const _Stage(this.label, this.done, {this.pending = false});
}

/// Horizontal workflow strip: done ✓ (green) → current (violet) → upcoming
/// (grey). Wraps on narrow screens.
class _WorkflowStrip extends StatelessWidget {
  const _WorkflowStrip({required this.stages});
  final List<_Stage> stages;

  @override
  Widget build(BuildContext context) {
    final currentIdx = stages.indexWhere((s) => !s.done);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Workflow',
              style: TextStyle(
                  fontSize: 12.5,
                  color: kcLabelGrey,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (int i = 0; i < stages.length; i++) ...[
                _chip(stages[i], i == currentIdx, i + 1),
                if (i < stages.length - 1)
                  Icon(Icons.chevron_right,
                      size: 18, color: Colors.grey.shade400),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(_Stage s, bool current, int n) {
    final Color color = s.pending
        ? kcLabelGrey
        : s.done
            ? kcStatGreen
            : current
                ? kcvoilet
                : kcLabelGrey;
    final bool filled = s.done || current;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: filled ? color.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: filled ? color.withValues(alpha: 0.6) : Colors.grey.shade300,
            width: current ? 1.6 : 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (s.done && !s.pending)
            Icon(Icons.check_circle, size: 14, color: color)
          else
            Container(
              width: 16,
              height: 16,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: current ? color : Colors.grey.shade300,
              ),
              child: Text('$n',
                  style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      color: current ? kcWhite : kcLabelGrey)),
            ),
          const SizedBox(width: 6),
          Text(s.label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: current ? FontWeight.w800 : FontWeight.w600,
                  color: filled ? color : kcLabelGrey)),
        ],
      ),
    );
  }
}

/// Collapsible section card (defaults to expanded) — same look as the other
/// inline detail pages.
class _SectionCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color accent;
  final Widget child;
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.accent,
    required this.child,
  });

  @override
  State<_SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<_SectionCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
              decoration: BoxDecoration(
                color: widget.accent.withValues(alpha: 0.08),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: widget.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(widget.icon, size: 18, color: widget.accent),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(widget.title,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: kcValueDark)),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 180),
                    child:
                        Icon(Icons.keyboard_arrow_down, color: widget.accent),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.all(14),
              child: widget.child,
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 180),
          ),
        ],
      ),
    );
  }
}
