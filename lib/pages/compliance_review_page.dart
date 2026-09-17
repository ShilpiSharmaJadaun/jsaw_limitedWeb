import 'package:flutter/material.dart';
import '../utils/page_header.dart';

import '../model/compliance_api_models.dart';
import '../model/compliance_incident_model.dart';
import '../service/compliance_service.dart';
import '../utils/app_color.dart';
import 'compliance_incident_detail_page.dart'
    show
        complianceStatusColor,
        complianceStageColor,
        complianceStageLabel,
        ComplianceIncidentDetailPage;

/// HOD review screen for one incident's compliance.
///
/// Shows every assigned employee's compliance (status / remark / image). The
/// HOD can REOPEN any submitted employee (with a reason); CLOSE is enabled only
/// when every assignee is COMPLETE (the backend enforces this too).
class ComplianceReviewPage extends StatefulWidget {
  final String incidentUniqueId;

  /// When provided, the page renders INLINE inside the app shell (no own
  /// Scaffold/AppBar) and this callback returns to the previous screen. When
  /// null, it falls back to a stand-alone Scaffold (legacy pushed-route usage).
  final VoidCallback? onBack;

  /// false = HOD "Compliance Review" — VIEW ONLY since 01-Sep-2026 (the HOD
  ///         monitors status; the raiser and the HSE team hold the actions).
  /// true  = Safety/HSE "Compliance Closure" (reopen individuals, final Close).
  final bool closureMode;

  /// true = the INCIDENT RAISER's review level (first step, Sep-2026):
  /// reached from All Incident → Raised; reopen individuals or close the
  /// review, which forwards the incident to the HSE team (RAISER_REVIEWED).
  final bool raiserMode;

  const ComplianceReviewPage({
    super.key,
    required this.incidentUniqueId,
    this.onBack,
    this.closureMode = false,
    this.raiserMode = false,
  });

  @override
  State<ComplianceReviewPage> createState() => _ComplianceReviewPageState();
}

class _ComplianceReviewPageState extends State<ComplianceReviewPage> {
  final ComplianceService _service = ComplianceService();

  String get _modeTitle => widget.raiserMode
      ? 'Review Compliance'
      : widget.closureMode
          ? 'Compliance Closure'
          : 'Compliance Review';
  ComplianceReview? _review;
  ComplianceIncident? _detail; // full incident context (same as detail page)
  bool _loading = true;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final r = await _service.getComplianceForReview(widget.incidentUniqueId);
      // Full incident context (incident / medical / safety / investigation /
      // CAPA / risk image) — supplementary, so a failure here doesn't block
      // the review itself.
      ComplianceIncident? detail;
      try {
        detail =
            await _service.getComplianceDetailForReview(widget.incidentUniqueId);
      } catch (_) {
        detail = null;
      }
      if (!mounted) return;
      setState(() {
        _review = r;
        _detail = detail;
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

  @override
  Widget build(BuildContext context) {
    // Embedded inside the app shell (drawer + header stay visible).
    if (widget.onBack != null) {
      return Container(
        color: kcDashboardBg1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _embeddedHeader(),
            Expanded(child: _body()),
          ],
        ),
      );
    }
    // Legacy stand-alone route (still works if pushed without onBack).
    return Scaffold(
      backgroundColor: kcDashboardBg1,
      appBar: AppBar(
        backgroundColor: kcvoilet,
        foregroundColor: kcWhite,
        title: Text('$_modeTitle · ${widget.incidentUniqueId}',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loading ? null : _load,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _body(),
    );
  }

  // Gradient back-header matching the Compliance Incident detail page so the
  // review opens inside the app rather than as a separate full-screen route.
  Widget _embeddedHeader() {
    // Inline header band, design 40-b (29-Aug-2026).
    return InlineHeaderBand(
      child: Row(
        children: [
          InlineBackButton(onPressed: widget.onBack),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              '$_modeTitle · ${widget.incidentUniqueId}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: kInlineHeaderInk,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loading ? null : _load,
            icon: const Icon(Icons.refresh, color: kcvoilet),
          ),
        ],
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

    final review = _review!;
    final assignees = review.assignees;
    final overallColor = complianceStageColor(review.overallStatus);
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _overallBanner(review, overallColor),
                        const SizedBox(height: 16),
                        // Full incident context — same sections as the
                        // "View Compliance Details" page.
                        if (_detail != null) ...[
                          ComplianceIncidentDetailPage(
                            incident: _detail!,
                            onBack: () {},
                            sectionsOnly: true,
                            showCapa: false, // shown per-employee below instead
                          ),
                          const SizedBox(height: 20),
                        ],
                        _sectionTitle(
                            Icons.groups_outlined, 'Employee Compliance'),
                        const SizedBox(height: 10),
                        if (assignees.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(24),
                            child: Center(
                              child: Text('No assigned employees found.',
                                  style: TextStyle(color: kcLabelGrey)),
                            ),
                          )
                        else
                          ...assignees.map(_assigneeCard),
                        const SizedBox(height: 90),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _closeBar(review),
        ),
        if (_busy)
          Container(
            color: Colors.black.withOpacity(0.25),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }

  Widget _sectionTitle(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: kcvoilet),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: kcValueDark)),
      ],
    );
  }

  Widget _overallBanner(ComplianceReview review, Color color) {
    final done =
        review.assignees.where((a) => _isComplete(a.status)).length;
    final total = review.assignees.length;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [kcStatBlue, kcInfoResponsibility],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.fact_check_outlined, color: kcWhite),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Status: ${complianceStageLabel(review.overallStatus, closureMode: widget.closureMode, raiserMode: widget.raiserMode)}',
                    style: const TextStyle(
                        color: kcWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text('$done of $total employees submitted',
                    style: TextStyle(
                        color: kcWhite.withOpacity(0.92), fontSize: 12.5)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.45)),
            ),
            child: Text(
              _pillText(review),
              style: const TextStyle(
                  color: kcWhite, fontSize: 11.5, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _assigneeCard(ComplianceAssigneeReview a) {
    final color = complianceStatusColor(a.status);
    final submitted = _isComplete(a.status);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: kcvoilet.withOpacity(0.15),
                  child: Text(
                    a.empName.isNotEmpty
                        ? a.empName.characters.first
                        : '?',
                    style: const TextStyle(
                        color: kcvoilet, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.empName.isEmpty ? a.empUnqId : a.empName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: kcValueDark)),
                      Text(
                        a.deptCode.isEmpty
                            ? a.empUnqId
                            : '${a.empUnqId} · ${a.deptCode}',
                        style:
                            const TextStyle(fontSize: 11.5, color: kcLabelGrey),
                      ),
                    ],
                  ),
                ),
                _statusPill(a.status, color),
              ],
            ),
          ),
          _assigneeCapa(a.empUnqId),
          if (submitted || a.remark.isNotEmpty || a.imageUrl.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (a.imageUrl.isNotEmpty) ...[
                    GestureDetector(
                      onTap: () => _previewImage(a.imageUrl),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          a.imageUrl,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (a.remark.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kcDashboardBg1,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(a.remark,
                          style: const TextStyle(
                              fontSize: 13, color: kcValueDark, height: 1.35)),
                    ),
                  if (a.submittedDate.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text('Submitted: ${a.submittedDate}',
                        style:
                            const TextStyle(fontSize: 11, color: kcLabelGrey)),
                  ],
                  if (a.status.toUpperCase() == 'REOPEN') ...[
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kcInfoFir.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: kcInfoFir.withOpacity(0.4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_reopenByLabel(a.reopenSource),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: kcInfoFir)),
                          if (a.reviewRemark.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text('Reason: ${a.reviewRemark}',
                                style: const TextStyle(
                                    fontSize: 12, color: kcInfoFir)),
                          ],
                        ],
                      ),
                    ),
                  ],
                  if (submitted && _canReopen) ...[
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton.icon(
                        onPressed: _busy ? null : () => _reopen(a),
                        icon: const Icon(Icons.replay, size: 18, color: kcRed),
                        label: const Text('Reopen',
                            style: TextStyle(color: kcRed)),
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: kcRed)),
                      ),
                    ),
                  ],
                ],
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.fromLTRB(14, 0, 14, 12),
              child: Text('Not submitted yet.',
                  style: TextStyle(
                      color: kcLabelGrey,
                      fontStyle: FontStyle.italic,
                      fontSize: 12.5)),
            ),
        ],
      ),
    );
  }

  // Corrective actions (CAPA) assigned to this employee — the "missing" detail
  // folded into their compliance card. Joined from the incident detail by
  // responsible emp code.
  Widget _assigneeCapa(String empUnqId) {
    final me = empUnqId.trim().toLowerCase();
    final actions =
        (_detail?.investigation.correctiveActions ?? const <CapaAction>[])
            .where((c) => c.respEmpCode.trim().toLowerCase() == me)
            .toList();
    if (actions.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.task_alt_outlined, size: 14, color: kcmegenta),
              SizedBox(width: 6),
              Text('Assigned CAPA',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: kcmegenta,
                      letterSpacing: 0.3)),
            ],
          ),
          const SizedBox(height: 6),
          for (int i = 0; i < actions.length; i++)
            _capaActionRow(i + 1, actions[i]),
        ],
      ),
    );
  }

  Widget _capaActionRow(int index, CapaAction a) {
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
                      fontSize: 13, color: kcValueDark, height: 1.35)),
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

  Widget _statusPill(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.45)),
      ),
      child: Text(status,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w700, color: color)),
    );
  }

  String _pillText(ComplianceReview review) {
    final s = review.overallStatus.toUpperCase();
    if (s == 'CLOSED') return 'Closed';
    if (s == 'REVIEW_COMPLETED' || s == 'RAISER_REVIEWED') {
      if (widget.raiserMode) return 'Closed by you · with HSE team';
      if (widget.closureMode) return 'Ready to close';
      return 'Awaiting HSE closure';
    }
    if (widget.raiserMode) {
      return review.canRaiserClose ? 'Ready to close' : 'Awaiting submissions';
    }
    return 'Awaiting raiser review';
  }

  /// Whether this page's mode carries any action at all (the HOD's
  /// Compliance Review is a status viewer — no close, no reopen).
  bool get _actionable => widget.raiserMode || widget.closureMode;

  /// Whether THIS mode may reopen a submitted report right now. Once the
  /// raiser closes their review the incident is with the HSE team, and only
  /// the HSE team can reopen (user rule 01-Sep-2026); a reopen puts the
  /// status back to PENDING, which re-enables the raiser's buttons.
  bool get _canReopen {
    if (!_actionable) return false;
    final s = _review?.overallStatus.trim().toUpperCase() ?? '';
    if (s == 'CLOSED') return false;
    if (widget.raiserMode) {
      return s != 'RAISER_REVIEWED' && s != 'REVIEW_COMPLETED';
    }
    return true; // HSE: any time before final closure
  }

  bool get _canAct {
    final review = _review;
    if (review == null) return false;
    if (widget.raiserMode) return review.canRaiserClose;
    if (widget.closureMode) return review.canFinalClose;
    return false; // HOD: view only
  }

  Widget _closeBar(ComplianceReview review) {
    final canClose = _canAct;
    final s = review.overallStatus.toUpperCase();
    final String hint;
    if (s == 'CLOSED') {
      hint = 'This incident is closed.';
    } else if (widget.raiserMode) {
      if (s == 'RAISER_REVIEWED' || s == 'REVIEW_COMPLETED') {
        hint = 'You closed this review — it is with the Safety/HSE team now.';
      } else {
        hint = canClose
            ? 'All employees submitted — check each report; close the review to forward it to the Safety/HSE team, or reopen an employee above.'
            : 'Close is disabled until every employee submits (and none are reopened).';
      }
    } else if (widget.closureMode) {
      hint = canClose
          ? 'The incident raiser closed the review — you can close this incident, or reopen an employee above.'
          : 'Close is disabled until the incident raiser closes the compliance review.';
    } else {
      // HOD: status viewer only.
      hint = s == 'RAISER_REVIEWED' || s == 'REVIEW_COMPLETED'
          ? 'The raiser closed the review — awaiting the Safety/HSE team\'s closure. View only.'
          : 'View only — the incident raiser reviews the compliance and the Safety/HSE team closes the incident.';
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: kcWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hint,
                  style: const TextStyle(fontSize: 12.5, color: kcLabelGrey),
                ),
              ),
              const SizedBox(width: 12),
              if (_actionable)
              ElevatedButton.icon(
                onPressed: (canClose && !_busy) ? _close : null,
                icon: Icon(
                    widget.closureMode
                        ? Icons.lock_outline
                        : Icons.task_alt_outlined,
                    size: 18),
                label: Text(widget.raiserMode
                    ? 'Close Compliance'
                    : 'Close Incident'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  foregroundColor: kcWhite,
                  disabledBackgroundColor: kcLightGrey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------ actions
  Future<void> _reopen(ComplianceAssigneeReview a) async {
    final controller = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Reopen — ${a.empName.isEmpty ? a.empUnqId : a.empName}'),
        content: TextField(
          controller: controller,
          maxLines: 4,
          minLines: 3,
          decoration: const InputDecoration(
            hintText: 'Reason for reopening (what to correct)…',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
            style: ElevatedButton.styleFrom(
                backgroundColor: kcRed, foregroundColor: kcWhite),
            child: const Text('Reopen'),
          ),
        ],
      ),
    );
    if (reason == null) return; // cancelled

    setState(() => _busy = true);
    try {
      final msg = await _service.rejectCompliance(
        incidentUniqueId: widget.incidentUniqueId,
        empUnqId: a.empUnqId,
        reviewRemark: reason,
        source: widget.raiserMode
            ? 'RAISER'
            : widget.closureMode
                ? 'SAFETY'
                : 'HOD',
      );
      if (!mounted) return;
      _snack(msg ?? 'Compliance reopened.');
      await _load();
    } catch (e) {
      if (!mounted) return;
      _snack(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _close() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(widget.raiserMode ? 'Close Compliance' : 'Close Incident'),
        content: Text(widget.raiserMode
            ? 'Close the compliance review? The incident will be forwarded to the Safety/HSE team for closure.'
            : 'Close this incident? This marks the compliance CLOSED for all employees (final).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A34A),
                foregroundColor: kcWhite),
            child: const Text('Close'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _busy = true);
    try {
      final msg = widget.raiserMode
          ? await _service.raiserCloseCompliance(widget.incidentUniqueId)
          : await _service.finalCloseCompliance(widget.incidentUniqueId);
      if (!mounted) return;
      _snack(msg ??
          (widget.raiserMode ? 'Compliance review closed.' : 'Incident closed.'));
      if (widget.onBack != null) {
        widget.onBack!();
      } else {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (!mounted) return;
      _snack(e.toString().replaceFirst('Exception: ', ''));
      setState(() => _busy = false);
    }
  }

  void _previewImage(String url) {
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
              child: Center(
                child: Image.network(url,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Padding(
                          padding: EdgeInsets.all(40),
                          child: Text('Image unavailable',
                              style: TextStyle(color: Colors.white)),
                        )),
              ),
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

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  bool _isComplete(String status) {
    final s = status.toUpperCase();
    return s == 'COMPLETE' || s == 'CLOSED';
  }

  String _reopenByLabel(String source) {
    switch (source.trim().toUpperCase()) {
      case 'SAFETY':
        return 'Reopened by HSE Team';
      case 'RAISER':
        return 'Reopened by the Incident Raiser';
      case 'HOD':
        return 'Reopened by HOD';
      default:
        return 'Reopened';
    }
  }
}
