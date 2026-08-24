import 'package:flutter/foundation.dart' show Uint8List;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/compliance_incident_model.dart';
import '../service/compliance_service.dart';
import '../utils/app_color.dart';

/// Compliance Incident — read-only DETAILS screen (design only).
///
/// Sections 1-3 are sourced from the Safety Remark Form record (incident +
/// medical assessment + safety officer remark + image). Sections 4-5 come from
/// the Submit Investigation Form. No backend wiring — data is passed in.
class ComplianceIncidentDetailPage extends StatelessWidget {
  final ComplianceIncident incident;
  final VoidCallback onBack;

  /// When true, renders ONLY the read-only information sections (1-6) without
  /// the header, the compliance-submit section, or the scroll wrapper. Used by
  /// the HOD review page to show the full incident context inline.
  final bool sectionsOnly;

  /// When false, the CAPA Actions section is omitted. The HOD review page hides
  /// it here because CAPA details are shown per-employee in its own
  /// "Employee Compliance" cards instead.
  final bool showCapa;

  const ComplianceIncidentDetailPage({
    super.key,
    required this.incident,
    required this.onBack,
    this.sectionsOnly = false,
    this.showCapa = true,
  });

  @override
  Widget build(BuildContext context) {
    // Embedded use (HOD review): just the info sections, caller supplies the
    // scroll view + surrounding chrome.
    if (sectionsOnly) return _sections(context);

    return Container(
      color: kcDashboardBg1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _embeddedHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _sections(context),
                      const SizedBox(height: 16),

                      // Compliance submission — the assigned user attaches
                      // their compliance image + remark, then submits.
                      _ComplianceSubmitSection(
                          incident: incident, onSubmitted: onBack),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The six read-only information sections, shared by the detail page and the
  /// HOD review page.
  Widget _sections(BuildContext context) {
    final s = incident.safety;
    final inv = incident.investigation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Incident Details
        _SectionCard(
          title: 'Incident Details',
          icon: Icons.assignment_outlined,
          accent: kcStatBlue,
          child: _incidentBody(context, s),
        ),
        const SizedBox(height: 16),

        // 2. Medical Assessment
        _SectionCard(
          title: 'Medical Assessment',
          icon: Icons.medical_services_outlined,
          accent: kcInfoFir,
          child: _medicalBody(s),
        ),
        const SizedBox(height: 16),

        // 3. Safety Remarks
        _SectionCard(
          title: "Safety Officer's Remark",
          icon: Icons.rate_review_outlined,
          accent: kcobservationgreen,
          child: _safetyBody(s),
        ),
        const SizedBox(height: 16),

        // 4. Investigation Details
        _SectionCard(
          title: 'Investigation Details',
          icon: Icons.fact_check_outlined,
          accent: kcvoilet,
          child: _investigationBody(),
        ),
        const SizedBox(height: 16),

        // 5. CAPA Actions
        if (showCapa) ...[
          _SectionCard(
            title: 'CAPA Actions',
            icon: Icons.task_alt_outlined,
            accent: kcmegenta,
            child: _capaBody(),
          ),
          const SizedBox(height: 16),
        ],

        // 6. Associated Risk Image — the image uploaded while submitting the
        //    Investigation Form. Header name matches the Investigation Form.
        _SectionCard(
          title: 'Associated Risk Identified & Evaluated — '
              'Aspect / Hazard Register Photo',
          icon: Icons.image_outlined,
          accent: kcInfoResponsibility,
          child: _investigationAttachmentBody(context, inv),
        ),
      ],
    );
  }

  // ----------------------------------------------------------------- header
  Widget _embeddedHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      // App signature header gradient (matches PageHeader / SubPageHeader).
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
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, color: kcWhite),
          ),
          const SizedBox(width: 4),
          const Text(
            'Compliance Action',
            style: TextStyle(
              color: kcWhite,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          _statusPill(incident.status, onDark: true),
        ],
      ),
    );
  }

  // --------------------------------------------------------------- bodies
  Widget _incidentBody(BuildContext context, SafetyRemarkBundle s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _imageTile(
          context,
          label: 'Incident Image',
          url: s.imageUrl,
          fileName: (s.imageUrl == null || s.imageUrl!.isEmpty)
              ? 'incident.jpg'
              : s.imageUrl!,
          show: true,
        ),
        const SizedBox(height: 14),
        _kvGrid([
          _KV('Incident Unique ID', s.incidentUniqueId),
          _KV('Incident Type', s.incidentType),
          _KV('Incident Date / Time', s.incidentDateTime),
          _KV('FIR Received', s.firDateTime),
          _KV('Shift', s.shift),
          _KV('Work Injury', s.workInjury),
          _KV('Employee', '${s.employeeName} (${s.employeeCode})'),
          _KV('Age', s.age),
          _KV('Contractor', s.contractorName),
          _KV('Contractor Code', s.contractorCode),
          _KV('Plant', s.plant),
          _KV('Department', s.department),
          _KV('Location', s.location),
          _KV('Responsible Engineer', s.responsibleEngineer),
          _KV('Responsible HOD', s.responsibleHod),
          _KV('Contact Number', s.contactNumber),
        ]),
        const SizedBox(height: 4),
        _longText('Description of Incident', s.descriptionOfIncident),
      ],
    );
  }

  Widget _medicalBody(SafetyRemarkBundle s) {
    return Column(
      children: [
        _kvGrid([
          _KV('Medical Officer Name', s.medicalOfficerName),
          _KV('Type of Injury', s.typeOfInjury),
          _KV('Body Part', s.bodyPart),
          _KV('Nature of Injury', s.natureOfInjury),
          _KV('Rest Upto', s.restUpto),
          _KV('Fit For Duty From', s.fitForDutyFrom),
        ]),
        _longText('Medical Officer Remarks', s.medicalOfficerRemarks),
      ],
    );
  }

  Widget _safetyBody(SafetyRemarkBundle s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kvGrid([
          _KV('Safety Officer Name', s.safetyOfficerName),
          _KV('Raised Date', s.raisedDate),
        ]),
        _longText("Safety Officer's Remark", s.safetyRemarks),
      ],
    );
  }

  Widget _investigationBody() {
    final inv = incident.investigation;
    if (inv.isEmpty) {
      return _emptyHint('Investigation not yet submitted for this incident.');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kvGrid([
          _KV('Incident ID', inv.incidentId),
          _KV('Report Date', inv.reportDate),
        ]),
        const SizedBox(height: 6),
        _subLabel('Investigation Team'),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: inv.team.map(_personChip).toList(),
        ),
        const SizedBox(height: 14),
        _subLabel('Facts Leading to the Incident or Dangerous Occurrence'),
        _longText(
            'If caused by machinery — machine/equipment and parts involved',
            inv.machineryDetails),
        _longText(
            'What the injured person was doing just before and at the time of the occurrence',
            inv.activityBeforeIncident),
        const SizedBox(height: 14),
        _subLabel('Root Cause Analysis'),
        const SizedBox(height: 6),
        ..._numbered(inv.rootCauses),
        const SizedBox(height: 14),
        _subLabel('Root Cause – Inquired With'),
        const SizedBox(height: 6),
        if (inv.inquiredWith.isEmpty)
          const Text('—', style: TextStyle(color: kcLabelGrey))
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: inv.inquiredWith.map(_inquiredChip).toList(),
          ),
      ],
    );
  }

  Widget _capaBody() {
    final actions = incident.investigation.correctiveActions;
    if (actions.isEmpty) {
      return _emptyHint('No CAPA assigned to you for this incident.');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subLabel('Corrective Action'),
        const SizedBox(height: 8),
        for (int i = 0; i < actions.length; i++) _capaRow(i + 1, actions[i]),
      ],
    );
  }

  /// A single corrective-action row — shows only the action text and its
  /// target date, per the compliance view requirement.
  Widget _capaRow(int index, CapaAction a) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: kcDashboardBg1,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border(left: BorderSide(color: kcmegenta, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kcmegenta.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('$index',
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: kcmegenta)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(a.action,
                  style: const TextStyle(
                      fontSize: 13.5, color: kcValueDark, height: 1.35)),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: kcWhite,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.event_outlined, size: 13, color: kcLabelGrey),
                const SizedBox(width: 5),
                Text('Target: ${a.targetDate}',
                    style: const TextStyle(
                        fontSize: 11,
                        color: kcValueDark,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _investigationAttachmentBody(
      BuildContext context, InvestigationDetail inv) {
    if (inv.attachmentName.isEmpty && inv.attachmentImageUrl == null) {
      return _emptyHint('No image was uploaded in the Investigation Details form.');
    }
    return _imageTile(
      context,
      label: 'Uploaded while submitting the Investigation Details form',
      url: inv.attachmentImageUrl,
      fileName:
          inv.attachmentName.isEmpty ? 'investigation.jpg' : inv.attachmentName,
      show: true,
    );
  }

  Widget _imageTile(
    BuildContext context, {
    required String label,
    required String? url,
    required String fileName,
    required bool show,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subLabel(label),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => _openPreview(context, url),
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              color: kcDashboardBg2,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Positioned.fill(child: _AttachmentImage(url: url)),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.zoom_in, size: 14, color: kcWhite),
                        SizedBox(width: 4),
                        Text('Tap to preview',
                            style: TextStyle(
                                color: kcWhite,
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openPreview(BuildContext context, String? url) {
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            InteractiveViewer(
              minScale: 0.5,
              maxScale: 4,
              child: Center(child: _AttachmentImage(url: url)),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.black54,
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------- helpers
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

  Widget _kvRow(_KV kv) {
    return Padding(
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
  }

  Widget _longText(String label, String value) {
    return Padding(
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
  }

  Widget _subLabel(String text) => Text(
        text,
        style: const TextStyle(
            fontSize: 12.5,
            color: kcLabelGrey,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3),
      );

  List<Widget> _numbered(List<String> items) {
    return [
      for (int i = 0; i < items.length; i++)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kcvoilet.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('${i + 1}',
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: kcvoilet)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(items[i],
                    style: const TextStyle(
                        fontSize: 13.5, color: kcValueDark, height: 1.4)),
              ),
            ],
          ),
        ),
    ];
  }

  /// Chip for a "Root Cause – Inquired With" employee: code — name on the
  /// first line, station · grade · designation beneath.
  Widget _inquiredChip(InquiredWithRef p) {
    final details = [
      if (p.statName.trim().isNotEmpty) p.statName,
      if (p.gradeName.trim().isNotEmpty) p.gradeName,
      if (p.desgName.trim().isNotEmpty) p.desgName,
    ].join(' · ');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: kcDashboardBg2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${p.empCode} — ${p.empName}',
            style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: kcValueDark),
          ),
          if (details.isNotEmpty)
            Text(details,
                style: const TextStyle(fontSize: 11.5, color: kcLabelGrey)),
        ],
      ),
    );
  }

  Widget _personChip(PersonRef p) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: kcDashboardBg2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: kcvoilet.withOpacity(0.15),
            child: Text(
              p.empName.isNotEmpty ? p.empName.characters.first : '?',
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w800, color: kcvoilet),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(p.empName,
                  style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: kcValueDark)),
              Text(
                p.department.isEmpty
                    ? p.empCode
                    : '${p.empCode} · ${p.department}',
                style: const TextStyle(fontSize: 10.5, color: kcLabelGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _emptyHint(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline, size: 16, color: kcLabelGrey),
          const SizedBox(width: 8),
          Text(text,
              style: const TextStyle(
                  fontSize: 13, color: kcLabelGrey, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget _statusPill(String status, {bool onDark = false}) {
    final c = complianceStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: onDark ? Colors.white.withOpacity(0.18) : c.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: onDark ? Colors.white.withOpacity(0.4) : c.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
                color: onDark ? kcWhite : c, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(status,
              style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: onDark ? kcWhite : c)),
        ],
      ),
    );
  }
}

/// Status → accent color, shared with the list page.
Color complianceStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'complete':
    case 'completed':
    case 'closed':
      return kcStatGreen;
    case 'reopen':
      return kcInfoFir;
    case 'review_completed':
    case 'review completed':
    case 'in progress':
      return kcStatPurple;
    case 'pending':
      return kcStatAmber;
    default:
      return kcLabelGrey;
  }
}

/// Human label for a compliance / investigation status code.
/// REVIEW_COMPLETED = HOD finished the Compliance Review, awaiting the
/// Safety/HSE team's final closure (customer workflow, Aug-2026).
/// Stage label for the HOD / Safety-team LISTS and review banner. The raw
/// overall status COMPLETE only means "every employee has submitted" — from
/// the reviewer's point of view that incident is still PENDING their action,
/// so it must not read as "Complete" in those screens.
String complianceStageLabel(String status, {bool closureMode = false}) {
  switch (status.trim().toUpperCase()) {
    case 'PENDING':
      return 'Pending · awaiting submissions';
    case 'COMPLETE':
      return closureMode ? 'Pending · awaiting HOD review' : 'Pending Review';
    case 'REVIEW_COMPLETED':
      return closureMode ? 'Awaiting Closure' : 'Review Completed';
    case 'CLOSED':
      return 'Closed';
    default:
      return complianceStatusLabel(status);
  }
}

/// Colour matching [complianceStageLabel] (everything not yet reviewed is
/// amber, reviewed-but-open is purple, closed is green).
Color complianceStageColor(String status) {
  switch (status.trim().toUpperCase()) {
    case 'PENDING':
    case 'COMPLETE':
      return kcStatAmber;
    case 'REVIEW_COMPLETED':
      return kcStatPurple;
    case 'CLOSED':
      return kcStatGreen;
    default:
      return complianceStatusColor(status);
  }
}

String complianceStatusLabel(String status) {
  switch (status.trim().toUpperCase()) {
    case 'REVIEW_COMPLETED':
      return 'Review Completed';
    case 'PENDING':
      return 'Pending';
    case 'COMPLETE':
      return 'Complete';
    case 'CLOSED':
      return 'Closed';
    case 'REOPEN':
      return 'Reopen';
    default:
      return status;
  }
}

// --------------------------------------------------------------------------
// Private widgets
// --------------------------------------------------------------------------

class _KV {
  final String label;
  final String value;
  const _KV(this.label, this.value);
}

/// Collapsible section card (defaults to expanded).
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
            color: Colors.black.withOpacity(0.04),
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
                color: widget.accent.withOpacity(0.08),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: widget.accent.withOpacity(0.15),
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

/// Renders the attachment image from a URL, with a graceful placeholder when
/// no URL is set (design-only) or the image fails to load.
class _AttachmentImage extends StatelessWidget {
  final String? url;
  const _AttachmentImage({this.url});

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) return _placeholder();
    return Image.network(
      url!,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => _placeholder(),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _placeholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kcDashboardBg2, kcDashboardBg1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image_outlined, size: 40, color: kcLabelGrey),
            SizedBox(height: 8),
            Text('Image preview',
                style: TextStyle(color: kcLabelGrey, fontSize: 12)),
            Text('(image will appear here once uploaded)',
                style: TextStyle(color: kcLightGrey, fontSize: 10.5)),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------------
// Compliance submission (design-only: simulated submit -> success -> back)
// --------------------------------------------------------------------------

/// Bottom section where the reviewing user attaches a compliance image and a
/// remark, then submits. No backend yet — submission is simulated with a short
/// delay, then a success dialog, then [onSubmitted] returns to the list.
class _ComplianceSubmitSection extends StatefulWidget {
  final ComplianceIncident incident;
  final VoidCallback onSubmitted;
  const _ComplianceSubmitSection(
      {required this.incident, required this.onSubmitted});

  @override
  State<_ComplianceSubmitSection> createState() =>
      _ComplianceSubmitSectionState();
}

class _ComplianceSubmitSectionState extends State<_ComplianceSubmitSection> {
  final ComplianceService _service = ComplianceService();
  final TextEditingController _remarkController = TextEditingController();
  Uint8List? _imageBytes;
  bool _saving = false;

  static const Color _accent = kcobservationgreen;
  static const Color _green = Color(0xFF16A34A);

  bool get _isReopen => widget.incident.myStatus.toUpperCase() == 'REOPEN';
  bool get _isComplete => widget.incident.myStatus.toUpperCase() == 'COMPLETE';
  bool get _isClosed =>
      widget.incident.myStatus.toUpperCase() == 'CLOSED' ||
      widget.incident.status.toUpperCase() == 'CLOSED';

  @override
  void initState() {
    super.initState();
    final sub = widget.incident.mySubmission;
    if (_isReopen && sub != null) {
      _remarkController.text = sub.remark; // prefill so they can edit + resubmit
    }
  }

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final picked =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (picked == null) return;
      final bytes = await picked.readAsBytes();
      if (!mounted) return;
      setState(() => _imageBytes = bytes);
    } catch (e) {
      if (!mounted) return;
      _snack('Could not pick image: $e');
    }
  }

  void _removeImage() => setState(() => _imageBytes = null);

  Future<void> _submit() async {
    final remark = _remarkController.text.trim();
    if (remark.isEmpty) {
      _snack('Please enter your compliance remark.');
      return;
    }

    setState(() => _saving = true);

    // Blocking progress dialog.
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _SubmitProgressDialog(),
    );

    try {
      final msg = await _service.submitCompliance(
        incidentUniqueId: widget.incident.incidentId,
        remark: remark,
        imageBytes: _imageBytes,
      );
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // close progress
      await _showSuccessDialog(msg ?? 'Compliance submitted successfully.');
      if (!mounted) return;
      setState(() => _saving = false);
      widget.onSubmitted(); // back to the list (which refreshes)
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // close progress
      setState(() => _saving = false);
      _snack(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> _showSuccessDialog(String message) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        icon: const Icon(Icons.check_circle, color: _green, size: 48),
        title: const Text('Submitted',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: Text(message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: kcValueDark)),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              foregroundColor: kcWhite,
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('OK',
                style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _headerBar(),
          Padding(padding: const EdgeInsets.all(14), child: _content()),
        ],
      ),
    );
  }

  Widget _headerBar() {
    final title = _isClosed
        ? 'Compliance Closed'
        : _isComplete
            ? 'Your Compliance (Submitted)'
            : _isReopen
                ? 'Resubmit Your Compliance'
                : 'Submit Your Compliance';
    final color = _isClosed ? _green : (_isReopen ? kcInfoFir : _accent);
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.assignment_turned_in_outlined,
                size: 18, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: kcValueDark)),
          ),
          _statusChip(widget.incident.myStatus),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    final c = complianceStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: c.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.withOpacity(0.4)),
      ),
      child: Text(status,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: c)),
    );
  }

  Widget _content() {
    if (_isClosed) {
      return _infoState(
        icon: Icons.lock_outline,
        color: _green,
        message:
            'This compliance has been closed by the HOD. No further action needed.',
      );
    }
    if (_isComplete) {
      return _infoState(
        icon: Icons.hourglass_bottom,
        color: _accent,
        message: 'You have submitted your compliance. Awaiting HOD review.',
      );
    }
    // PENDING or REOPEN -> editable form
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isReopen) _reopenBanner(),
        _label('Compliance Image'),
        const SizedBox(height: 6),
        _imagePicker(),
        const SizedBox(height: 16),
        _label('Compliance Remark'),
        const SizedBox(height: 6),
        TextField(
          controller: _remarkController,
          maxLines: 5,
          minLines: 4,
          enabled: !_saving,
          decoration: _inputDecoration(
              'Enter your compliance remark / action taken…'),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: _saving ? null : _submit,
            icon: _saving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: kcWhite))
                : const Icon(Icons.check_circle_outline),
            label: Text(_isReopen ? 'Resubmit Compliance' : 'Submit Compliance',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              foregroundColor: kcWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _reopenBanner() {
    final reason = widget.incident.mySubmission?.reviewRemark ?? '';
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kcInfoFir.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kcInfoFir.withOpacity(0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.report_problem_outlined, color: kcInfoFir, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    (widget.incident.mySubmission?.reopenSource ?? '')
                                .toUpperCase() ==
                            'SAFETY'
                        ? 'Reopened by Safety Team'
                        : 'Reopened by HOD',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: kcInfoFir,
                        fontSize: 13)),
                const SizedBox(height: 2),
                Text(reason.isEmpty ? 'Please review and resubmit.' : reason,
                    style: const TextStyle(
                        color: kcValueDark, fontSize: 12.5, height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoState({
    required IconData icon,
    required Color color,
    required String message,
  }) {
    final sub = widget.incident.mySubmission;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withOpacity(0.4)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(message,
                    style: const TextStyle(
                        color: kcValueDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        if (sub != null) ...[
          const SizedBox(height: 14),
          if (sub.imageUrl.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                sub.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: 10),
          ],
          _label('Your Remark'),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kcDashboardBg1,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(sub.remark.isEmpty ? '—' : sub.remark,
                style: const TextStyle(
                    fontSize: 13.5, color: kcValueDark, height: 1.4)),
          ),
          if (sub.submittedDate.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text('Submitted: ${sub.submittedDate}',
                style: const TextStyle(fontSize: 11.5, color: kcLabelGrey)),
          ],
        ],
      ],
    );
  }

  Widget _imagePicker() {
    if (_imageBytes != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(_imageBytes!,
                height: 200, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: _saving ? null : _pickImage,
                icon: const Icon(Icons.swap_horiz, size: 18),
                label: const Text('Replace'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: _saving ? null : _removeImage,
                icon: const Icon(Icons.delete_outline, size: 18, color: kcRed),
                label: const Text('Remove', style: TextStyle(color: kcRed)),
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: kcRed)),
              ),
            ],
          ),
        ],
      );
    }
    return InkWell(
      onTap: _saving ? null : _pickImage,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kcDashboardBg1,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_photo_alternate_outlined,
                  size: 34, color: kcLabelGrey),
              SizedBox(height: 8),
              Text('Tap to upload compliance image',
                  style: TextStyle(color: kcLabelGrey, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(text,
      style: const TextStyle(
          fontSize: 12.5,
          color: kcLabelGrey,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3));

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: kcDashboardBg1,
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kcvoilet, width: 1.5),
      ),
    );
  }
}

/// Blocking progress dialog shown while the compliance submission is in flight.
class _SubmitProgressDialog extends StatelessWidget {
  const _SubmitProgressDialog();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF16A34A)),
                ),
              ),
              SizedBox(height: 16),
              Text('Submitting compliance…',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: kcValueDark)),
              SizedBox(height: 4),
              Text('Please wait',
                  style: TextStyle(fontSize: 12, color: kcLabelGrey)),
            ],
          ),
        ),
      ),
    );
  }
}
