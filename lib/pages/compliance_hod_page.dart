import 'package:flutter/material.dart';

import '../model/compliance_api_models.dart';
import '../service/compliance_service.dart';
import '../utils/app_color.dart';
import 'compliance_incident_detail_page.dart'
    show complianceStageColor, complianceStageLabel;
import 'compliance_review_page.dart';

/// HOD Review — lists ALL compliance incidents; tap one to open its review
/// (assignee statuses, reopen, close). Drawer-accessible.
///
/// Uses the same rich-card layout as the Compliance Incident list so the HOD
/// sees the full incident context (image, raised by, reporting date, overall
/// status, how many employees are assigned) before opening a review.
class ComplianceHodPage extends StatefulWidget {
  /// false = "Compliance Review" (HOD: reopen individuals / Complete Review).
  /// true  = "Compliance Closure" (Safety/HSE team: reopen individuals / Close).
  final bool closureMode;
  const ComplianceHodPage({super.key, this.closureMode = false});

  @override
  State<ComplianceHodPage> createState() => _ComplianceHodPageState();
}

class _ComplianceHodPageState extends State<ComplianceHodPage> {
  final ComplianceService _service = ComplianceService();
  final TextEditingController _searchController = TextEditingController();

  List<ComplianceSummary> _all = [];
  bool _loading = true;
  String? _error;
  String _query = '';
  String _statusFilter = 'all'; // all | pending | review | closed

  // When set, the review screen is shown INLINE inside the app shell instead
  // of as a separate pushed route.
  String? _reviewIncidentId;

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
      final list = widget.closureMode
          ? await _service.getAllForClosure()
          : await _service.getAllComplianceIncidents();
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

  // HOD list filters on the OVERALL incident status. An incident stays
  // "Pending" until the HOD closes it — even after all assignees have submitted
  // (overall COMPLETE) — and only moves to "Closed" once the HOD closes it.
  bool _matchesStatus(ComplianceSummary c) {
    final s = c.status.toLowerCase();
    switch (_statusFilter) {
      case 'pending':
        // pending + submitted-but-not-yet-reviewed (HOD still has to act)
        return s != 'closed' && s != 'review_completed';
      case 'review':
        return s == 'review_completed'; // HOD done, awaiting Safety closure
      case 'closed':
        return s == 'closed';
      default:
        return true;
    }
  }

  List<ComplianceSummary> get _filtered {
    final q = _query.trim().toLowerCase();
    return _all.where((c) {
      if (!_matchesStatus(c)) return false;
      if (q.isEmpty) return true;
      return c.incidentUniqueId.toLowerCase().contains(q) ||
          c.description.toLowerCase().contains(q);
    }).toList();
  }

  int _countBy(bool Function(ComplianceSummary) test) => _all.where(test).length;

  void _openReview(ComplianceSummary c) {
    setState(() => _reviewIncidentId = c.incidentUniqueId);
  }

  void _closeReview() {
    setState(() => _reviewIncidentId = null);
    _load(); // statuses may have changed (reopen/close)
  }

  @override
  Widget build(BuildContext context) {
    // Show the review inline (keeps the app drawer + header visible).
    if (_reviewIncidentId != null) {
      return ComplianceReviewPage(
        incidentUniqueId: _reviewIncidentId!,
        onBack: _closeReview,
        closureMode: widget.closureMode,
      );
    }
    return Container(
      color: kcDashboardBg1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _banner(),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------- banner
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
    // Pending = everything not yet closed by the HOD (includes incidents whose
    // assignees have all submitted — they wait here until the HOD closes them).
    final pending = _countBy((c) {
      final s = c.status.toLowerCase();
      return s != 'closed' && s != 'review_completed';
    });
    final reviewed =
        _countBy((c) => c.status.toLowerCase() == 'review_completed');
    final closed = _countBy((c) => c.status.toLowerCase() == 'closed');
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
            child: _statCard(
                Icons.fact_check_outlined,
                widget.closureMode ? 'Awaiting Closure' : 'Review Completed',
                reviewed,
                kcStatPurple,
                'review')),
        const SizedBox(width: 12),
        Expanded(
            child: _statCard(
                Icons.lock_outline, 'Closed', closed, kcvoilet, 'closed')),
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

  // -------------------------------------------------------------------- card
  Widget _card(ComplianceSummary c) {
    final statusColor = complianceStageColor(c.status); // reviewer's stage
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
                        left: 8,
                        top: 8,
                        child: _statusBadge(
                            complianceStageLabel(c.status,
                                closureMode: widget.closureMode),
                            statusColor)),
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
                        Text(c.incidentUniqueId,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: kcLabelGrey,
                                letterSpacing: 0.2)),
                        const Spacer(),
                        _assignedChip(c.assignedCount),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Text(
                        c.description,
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
                              _metaLine(Icons.event_outlined,
                                  'Reporting Date', c.reportingDate, kcInfoDate),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () => _openReview(c),
                          icon: const Icon(Icons.rate_review_outlined, size: 18),
                          label: const Text('Review'),
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

  // Top-right chip = how many employees are assigned to this incident.
  Widget _assignedChip(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: kcvoilet.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kcvoilet.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.groups_outlined, size: 13, color: kcvoilet),
          const SizedBox(width: 5),
          Text('$count assigned',
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w700, color: kcvoilet)),
        ],
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
                fontSize: 12.5,
                color: kcValueDark,
                fontWeight: FontWeight.w700)),
      ],
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
                  ? 'No compliance incidents match "$_query".'
                  : 'No compliance incidents found.',
              style: const TextStyle(color: kcLabelGrey),
            ),
          ],
        ),
      ),
    );
  }
}
