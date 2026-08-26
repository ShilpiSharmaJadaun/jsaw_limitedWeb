import 'package:flutter/material.dart';

import '../model/compliance_api_models.dart';
import '../model/compliance_incident_model.dart';
import '../service/compliance_service.dart';
import '../service/incident_service.dart';
import '../utils/pdf_download.dart';
import '../error/api_error.dart';
import '../utils/app_color.dart';
import 'compliance_incident_detail_page.dart' show complianceStatusColor;

/// Investigations Raised — READ-ONLY screen for Investigation TEAM members.
/// Lists only the investigations where the logged-in user is a team member and
/// lets them view the full details + the latest compliance updates. No edit,
/// submit, approve or reopen/close actions.
class InvestigationsRaisedPage extends StatefulWidget {
  /// When [hodView] is true the page lists investigations the logged-in HOD
  /// monitors (a subordinate is creator/team/CAPA); otherwise it lists the ones
  /// where the logged-in user is a team member.
  final bool hodView;
  final String title;
  const InvestigationsRaisedPage({
    super.key,
    this.hodView = false,
    this.title = 'Investigation Initiated',
  });

  @override
  State<InvestigationsRaisedPage> createState() =>
      _InvestigationsRaisedPageState();
}

class _InvestigationsRaisedPageState extends State<InvestigationsRaisedPage> {
  final ComplianceService _service = ComplianceService();
  final IncidentService _incidentService = IncidentService();

  /// Incident whose Investigation Report PDF is being generated.
  String? _pdfBusyId;

  Future<void> _downloadInvestigationPdf(String incidentUniqueId) async {
    if (_pdfBusyId != null) return;
    setState(() => _pdfBusyId = incidentUniqueId);
    try {
      final bytes =
          await _incidentService.downloadInvestigationPdfByUid(incidentUniqueId);
      savePdfBytes('Investigation_Report_$incidentUniqueId.pdf', bytes);
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
      if (mounted) setState(() => _pdfBusyId = null);
    }
  }
  final TextEditingController _searchController = TextEditingController();

  List<ComplianceSummary> _all = [];
  bool _loading = true;
  bool _loadingDetail = false;
  String? _error;
  String _query = '';
  String _statusFilter = 'all'; // all | pending | complete

  // Open detail (fetched on demand): investigation bundle + per-assignee updates.
  ComplianceIncident? _detail;
  ComplianceReview? _review;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final list = widget.hodView
          ? await _service.getInvestigationsToMonitor()
          : await _service.getInvestigationsRaised();
      if (!mounted) return;
      setState(() {
        _all = list;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
        _loading = false;
      });
    }
  }

  Future<void> _openDetail(ComplianceSummary c) async {
    setState(() => _loadingDetail = true);
    try {
      final detail =
          await _service.getComplianceDetailForReview(c.incidentUniqueId);
      ComplianceReview? review;
      try {
        review = await _service.getComplianceForReview(c.incidentUniqueId);
      } catch (_) {
        review = null; // updates are optional; details still render
      }
      if (!mounted) return;
      setState(() {
        _detail = detail;
        _review = review;
        _loadingDetail = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loadingDetail = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Could not open details: '
              '${e.toString().replaceFirst('Exception: ', '')}')));
    }
  }

  void _closeDetail() {
    setState(() {
      _detail = null;
      _review = null;
    });
  }

  bool _matchesStatus(ComplianceSummary c) {
    final s = c.status.toLowerCase();
    switch (_statusFilter) {
      case 'pending':
        return s == 'pending' || s.isEmpty;
      case 'complete':
        return s == 'complete' || s == 'completed' || s == 'closed';
      default:
        return true;
    }
  }

  int _countBy(bool Function(ComplianceSummary) test) => _all.where(test).length;

  List<ComplianceSummary> get _filtered {
    final q = _query.trim().toLowerCase();
    return _all.where((c) {
      if (!_matchesStatus(c)) return false;
      if (q.isEmpty) return true;
      return c.incidentUniqueId.toLowerCase().contains(q) ||
          c.description.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: kcDashboardBg1,
          child: _detail != null
              ? _detailView(_detail!, _review)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [_banner(), Expanded(child: _body())],
                ),
        ),
        if (_loadingDetail)
          Container(
            color: Colors.black.withOpacity(0.25),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }

  // ------------------------------------------------------------------ list
  Widget _banner() {
    return Container(
      color: kcDashboardBg1,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: _searchField(),
        ),
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      controller: _searchController,
      onChanged: (v) => setState(() => _query = v),
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Search by Incident ID…',
        prefixIcon: const Icon(Icons.search, size: 20),
        suffixIcon: _query.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  _searchController.clear();
                  setState(() => _query = '');
                },
              ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        filled: true,
        fillColor: kcWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _body() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 44, color: kcRed),
            const SizedBox(height: 10),
            Text(_error!, style: const TextStyle(color: kcLabelGrey)),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _load,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: kcvoilet, foregroundColor: kcWhite),
            ),
          ],
        ),
      );
    }
    final items = _filtered;
    return RefreshIndicator(
      onRefresh: _load,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _statsRow(),
                const SizedBox(height: 20),
                if (items.isEmpty) _emptyState() else ...items.map(_card),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------ stats
  Widget _statsRow() {
    final total = _all.length;
    final pending = _countBy((c) {
      final s = c.status.toLowerCase();
      return s == 'pending' || s.isEmpty;
    });
    final completed = _countBy((c) {
      final s = c.status.toLowerCase();
      return s == 'complete' || s == 'completed' || s == 'closed';
    });
    return Row(
      children: [
        Expanded(
            child: _statCard(
                Icons.summarize_outlined, 'Total', total, kcStatBlue, 'all')),
        const SizedBox(width: 12),
        Expanded(
            child: _statCard(Icons.pending_actions_outlined, 'Pending',
                pending, kcStatAmber, 'pending')),
        const SizedBox(width: 12),
        Expanded(
            child: _statCard(Icons.verified_outlined, 'Complete', completed,
                kcStatGreen, 'complete')),
      ],
    );
  }

  Widget _statCard(
      IconData icon, String label, int count, Color c, String filterKey) {
    final dark = Color.lerp(c, Colors.black, 0.20)!;
    final selected = _statusFilter == filterKey;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _statusFilter = filterKey),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: selected ? 1 : 0.62,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [c, dark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              border: selected ? Border.all(color: kcWhite, width: 2.5) : null,
              boxShadow: [
                BoxShadow(
                  color: c.withOpacity(selected ? 0.45 : 0.20),
                  blurRadius: selected ? 14 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: kcWhite, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$count',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: kcWhite,
                              height: 1.1)),
                      Text(label,
                          style: TextStyle(
                              fontSize: 11.5,
                              color: Colors.white.withOpacity(0.92),
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                if (selected)
                  const Icon(Icons.check_circle, color: kcWhite, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _card(ComplianceSummary c) {
    final statusColor = complianceStatusColor(c.status);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 6, color: statusColor),
            SizedBox(
              width: 196,
              child: GestureDetector(
                onTap: () => _openImagePreview(context, c.imageUrl),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _incidentThumb(c.imageUrl),
                    Positioned(
                        left: 8, top: 8, child: _statusBadge(c.status, statusColor)),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.zoom_in, size: 14, color: kcWhite),
                            SizedBox(width: 4),
                            Text('Expand',
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.tag, size: 15, color: kcLabelGrey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(c.incidentUniqueId,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: kcLabelGrey,
                                  letterSpacing: 0.2)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Text(
                        c.description.isEmpty
                            ? '(No description)'
                            : c.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: kcValueDark,
                          height: 1.35,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 6,
                            children: [
                              _metaLine(Icons.person_outline, 'Raised by',
                                  c.raisedBy, kcvoilet),
                              _metaLine(Icons.event_outlined, 'Reporting Date',
                                  c.reportingDate, kcInfoDate),
                              _metaLine(Icons.groups_outlined, 'Assignees',
                                  '${c.assignedCount}', kcInfoResponsibility),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton.icon(
                          onPressed: _pdfBusyId != null
                              ? null
                              : () => _downloadInvestigationPdf(c.incidentUniqueId),
                          icon: _pdfBusyId == c.incidentUniqueId
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2))
                              : const Icon(Icons.download_outlined, size: 18),
                          label: Text(_pdfBusyId == c.incidentUniqueId
                              ? 'Preparing…'
                              : 'Investigation Report'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: kcPdfIconRed,
                            side: const BorderSide(color: kcPdfIconRed),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () => _openDetail(c),
                          icon: const Icon(Icons.visibility_outlined, size: 18),
                          label: const Text('View Details'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kcvoilet,
                            foregroundColor: kcWhite,
                            elevation: 2,
                            shadowColor: kcvoilet.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.circle, size: 7, color: kcWhite),
          const SizedBox(width: 6),
          Text(status,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w700, color: kcWhite)),
        ],
      ),
    );
  }

  Widget _incidentThumb(String? url) {
    final placeholder = Container(
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
            Icon(Icons.image_outlined, size: 30, color: kcLabelGrey),
            SizedBox(height: 6),
            Text('Incident image',
                style: TextStyle(fontSize: 11, color: kcLabelGrey)),
          ],
        ),
      ),
    );
    if (url == null || url.isEmpty) return placeholder;
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => placeholder,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: kcDashboardBg2,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
    );
  }

  void _openImagePreview(BuildContext context, String? url) {
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
              child: Center(child: _fullImage(url)),
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

  Widget _fullImage(String? url) {
    if (url == null || url.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(40),
        child: Text('No image uploaded for this incident.',
            style: TextStyle(color: Colors.white)),
      );
    }
    return Image.network(
      url,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const Padding(
        padding: EdgeInsets.all(40),
        child: Text('Image unavailable', style: TextStyle(color: Colors.white)),
      ),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Padding(
          padding: EdgeInsets.all(40),
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _emptyState() {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 48, color: kcLightGrey),
            const SizedBox(height: 10),
            Text(
              _query.trim().isNotEmpty
                  ? 'No investigations match "$_query".'
                  : (widget.hodView
                      ? 'No investigations to monitor yet.'
                      : 'You are not a team member on any investigation yet.'),
              style: const TextStyle(color: kcLabelGrey),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------- detail
  Widget _detailView(ComplianceIncident inc, ComplianceReview? review) {
    final safety = inc.safety;
    final investigation = inc.investigation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _embeddedHeader(safety.incidentUniqueId, inc.status),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ReadOnlyBanner(
                      message: widget.hodView
                          ? 'View-only. As an HOD you can monitor this investigation and its latest updates.'
                          : 'View-only. As an investigation team member you can monitor this investigation and its latest updates.',
                    ),
                    const SizedBox(height: 14),
                    _incidentSection(safety),
                    const SizedBox(height: 14),
                    _investigationSection(investigation),
                    const SizedBox(height: 14),
                    _capaSection(investigation, review),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // App signature header gradient (matches PageHeader / Compliance detail page).
  Widget _embeddedHeader(String incidentId, String status) {
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
            onPressed: _closeDetail,
            icon: const Icon(Icons.arrow_back, color: kcWhite),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              incidentId,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: kcWhite,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          _statusPill(status, onDark: true),
        ],
      ),
    );
  }

  Widget _incidentSection(SafetyRemarkBundle s) {
    return _sectionCard(
      Icons.report_problem_outlined,
      'Incident Details',
      kcStatBlue,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (s.imageUrl != null && s.imageUrl!.isNotEmpty) ...[
            GestureDetector(
              onTap: () => _openImagePreview(context, s.imageUrl),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  s.imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ),
            const SizedBox(height: 14),
          ],
          _kvGrid([
            _KV('Type', s.incidentType),
            _KV('Date/Time', s.incidentDateTime),
            _KV('Plant', s.plant),
            _KV('Department', s.department),
            _KV('Location', s.location),
            _KV('Raised by', s.raisedBy),
            _KV('Shift Engineer', s.responsibleEngineer),
            _KV('Responsible HOD', s.responsibleHod),
          ]),
          if (s.descriptionOfIncident.isNotEmpty)
            _longText('Description', s.descriptionOfIncident),
        ],
      ),
    );
  }

  Widget _investigationSection(InvestigationDetail inv) {
    return _sectionCard(
      Icons.fact_check_outlined,
      'Investigation',
      kcvoilet,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _kvGrid([_KV('Report Date', inv.reportDate)]),
          const SizedBox(height: 10),
          _subLabel('Investigation Team'),
          const SizedBox(height: 6),
          if (inv.team.isEmpty)
            const Text('—', style: TextStyle(color: kcLabelGrey))
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: inv.team
                  .map((p) => _chip(
                      '${p.empName}${p.empCode.isEmpty ? '' : ' (${p.empCode})'}'))
                  .toList(),
            ),
          const SizedBox(height: 14),
          _subLabel('Facts Leading to the Incident or Dangerous Occurrence'),
          const SizedBox(height: 6),
          _factsLine(
              'If caused by machinery — machine/equipment and parts involved',
              inv.machineryDetails),
          _factsLine(
              'What the injured person was doing just before and at the time of the occurrence',
              inv.activityBeforeIncident),
          const SizedBox(height: 14),
          _subLabel('Root Causes'),
          const SizedBox(height: 6),
          if (inv.rootCauses.isEmpty)
            const Text('—', style: TextStyle(color: kcLabelGrey))
          else
            ...inv.rootCauses.asMap().entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('${e.key + 1}. ${e.value}',
                      style: const TextStyle(
                          fontSize: 13.5, color: kcValueDark, height: 1.35)),
                )),
          const SizedBox(height: 14),
          _subLabel('Root Cause – Inquired With'),
          const SizedBox(height: 6),
          if (inv.inquiredWith.isEmpty)
            const Text('—', style: TextStyle(color: kcLabelGrey))
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: inv.inquiredWith.map((p) {
                final details = [
                  if (p.statName.trim().isNotEmpty) p.statName,
                  if (p.gradeName.trim().isNotEmpty) p.gradeName,
                  if (p.desgName.trim().isNotEmpty) p.desgName,
                ].join(' · ');
                return _chip(details.isEmpty
                    ? '${p.empCode} — ${p.empName}'
                    : '${p.empCode} — ${p.empName}  ($details)');
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _capaSection(InvestigationDetail inv, ComplianceReview? review) {
    // Merge each CAPA action with its assignee's latest compliance status.
    final assignees = <String, ComplianceAssigneeReview>{};
    for (final a in (review?.assignees ?? const <ComplianceAssigneeReview>[])) {
      assignees[a.empUnqId.trim().toLowerCase()] = a;
    }
    final capa = inv.correctiveActions;
    return _sectionCard(
      Icons.verified_user_outlined,
      'CAPA & Latest Updates',
      kcmegenta,
      capa.isEmpty
          ? const Text('No CAPA recorded.', style: TextStyle(color: kcLabelGrey))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: capa.map((c) {
                final a = assignees[c.respEmpCode.trim().toLowerCase()];
                final status = a?.status ?? 'PENDING';
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
                          Expanded(
                            child: Text(c.action,
                                style: const TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: kcValueDark,
                                    height: 1.3)),
                          ),
                          const SizedBox(width: 8),
                          _statusPill(status),
                        ],
                      ),
                      if (a != null && a.imageUrl.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => _openImagePreview(context, a.imageUrl),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              a.imageUrl,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      _kvGrid([
                        _KV('Responsible',
                            '${c.respEmpName}${c.respEmpCode.isEmpty ? '' : ' (${c.respEmpCode})'}'),
                        _KV('Target Date', c.targetDate),
                        if (a != null && a.submittedDate.isNotEmpty)
                          _KV('Submitted', a.submittedDate),
                      ]),
                      if (a != null && a.remark.isNotEmpty)
                        _longText('Compliance Remark', a.remark),
                      if (a != null && a.reviewRemark.isNotEmpty)
                        _longText('Reopen Reason', a.reviewRemark),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }

  // ------------------------------------------------------------- shared bits
  Widget _sectionCard(IconData icon, String title, Color accent, Widget child) {
    return _DetailSectionCard(icon: icon, title: title, accent: accent, child: child);
  }

  // Aligned label:value grid — two even columns on wide layouts, matching the
  // Compliance Incident detail page (avoids ragged Wrap-of-columns alignment).
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
            width: 150,
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
                  fontSize: 13.5, color: kcValueDark, fontWeight: FontWeight.w600),
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

  /// One labelled free-text line for the "Facts Leading to the Incident"
  /// block (points 4 & 5); shows an em dash when the value is blank.
  Widget _factsLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12, color: kcLabelGrey, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(value.trim().isEmpty ? '—' : value,
              style: const TextStyle(
                  fontSize: 13.5, color: kcValueDark, height: 1.35)),
        ],
      ),
    );
  }

  Widget _subLabel(String text) => Text(
        text,
        style: const TextStyle(
            fontSize: 12.5, fontWeight: FontWeight.w700, color: kcLabelGrey),
      );

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: kcvoilet.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kcvoilet.withOpacity(0.30)),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: kcValueDark)),
    );
  }

  Widget _statusPill(String status, {bool onDark = false}) {
    final color = complianceStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: onDark ? Colors.white.withOpacity(0.18) : color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: onDark ? Colors.white.withOpacity(0.4) : color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
                color: onDark ? kcWhite : color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(status,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: onDark ? kcWhite : color)),
        ],
      ),
    );
  }

  Widget _metaLine(IconData icon, String label, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Icon(icon, size: 13, color: color),
        ),
        const SizedBox(width: 7),
        Text('$label: ',
            style: const TextStyle(
                fontSize: 12, color: kcLabelGrey, fontWeight: FontWeight.w600)),
        Text(value.isEmpty ? '—' : value,
            style: const TextStyle(
                fontSize: 12.5, color: kcValueDark, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

/// Collapsible section card matching the Compliance Incident detail page's
/// theme (accent-tinted header band, icon chip, bold title, soft shadow card).
class _KV {
  final String label;
  final String value;
  const _KV(this.label, this.value);
}

class _DetailSectionCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color accent;
  final Widget child;
  const _DetailSectionCard({
    required this.title,
    required this.icon,
    required this.accent,
    required this.child,
  });

  @override
  State<_DetailSectionCard> createState() => _DetailSectionCardState();
}

class _DetailSectionCardState extends State<_DetailSectionCard> {
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

/// Small "read-only" hint banner shown at the top of the detail view.
class _ReadOnlyBanner extends StatelessWidget {
  final String message;
  const _ReadOnlyBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: kcvoilet.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kcvoilet.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.visibility_outlined, size: 16, color: kcvoilet),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 12, color: kcValueDark),
            ),
          ),
        ],
      ),
    );
  }
}
