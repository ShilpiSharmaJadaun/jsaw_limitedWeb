import 'package:flutter/material.dart';

import '../model/completeMedicalResponse_model.dart';
import '../utils/app_color.dart';
import '../utils/progressive_image.dart';

/// Medical Officer — read-only "Check Details" view (tracker point 3).
///
/// Opened inline from the **Complete** tab of the Medical Officer Response
/// page so the Medical Officer can verify what they submitted. Shows the
/// incident information followed by the Medical Assessment they entered.
/// No editing — the incident has already moved on to the Safety team.
class MedicalResponseDetailPage extends StatelessWidget {
  final CompleteMedicalResponseModel response;
  final VoidCallback onBack;

  const MedicalResponseDetailPage({
    super.key,
    required this.response,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kcDashboardBg1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SectionCard(
                        title: 'Incident Details',
                        icon: Icons.assignment_outlined,
                        accent: kcStatBlue,
                        child: _incidentBody(),
                      ),
                      const SizedBox(height: 16),
                      _SectionCard(
                        title: 'Medical Assessment (submitted by you)',
                        icon: Icons.medical_services_outlined,
                        accent: kcInfoFir,
                        child: _medicalBody(),
                      ),
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

  // ----------------------------------------------------------------- header
  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      // App signature header gradient (matches the other inline pages).
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
            'Check Details — Medical Response',
            style: TextStyle(
              color: kcWhite,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.22),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.6)),
            ),
            child: Text(
              response.incidentUniqueId,
              style: const TextStyle(
                  color: kcWhite, fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------- bodies
  Widget _incidentBody() {
    final r = response;
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
          _KV('Incident Unique ID', r.incidentUniqueId),
          _KV('Incident Type', r.incidentType),
          _KV('Incident Date / Time', r.incidentDateTime),
          _KV('FIR Received', r.firDateTime),
          _KV('Shift', r.shift),
          _KV('Work Injury', r.workInjury),
          _KV('Employee', '${r.employeeName} (${r.employeeCode})'),
          _KV('Age', r.age == 0 ? '' : r.age.toString()),
          _KV('Contractor', r.contractorName),
          _KV('Contractor Code', r.contCode),
          _KV('Plant', r.plant),
          _KV('Department', r.deptName),
          _KV('Location', r.location),
          _KV('Responsible Engineer', r.responsibleShiftEngg),
          _KV('Responsible HOD', r.responsibleHod),
          _KV('Contact Number', r.contactNumber),
        ]),
        const SizedBox(height: 4),
        _longText('Description of Incident', r.descpOfIncident),
      ],
    );
  }

  Widget _medicalBody() {
    final r = response;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kvGrid([
          _KV('Type of Injury', r.typeOfInjury),
          _KV('Body Part', r.bodyPart),
          _KV('Nature of Injury', r.natureOfInjury),
          _KV('Rest Upto (days)', r.restUpto),
          _KV('Fit For Duty From', r.fitForDutyFrom),
          _KV('Submitted On', r.raisedDate),
          _KV(
            'Medical Officer',
            r.medicalOfficerCode.isEmpty
                ? r.medicalOfficerName
                : '${r.medicalOfficerName} (${r.medicalOfficerCode})',
          ),
        ]),
        _longText('Medical Officer Remarks', r.medicalOfficerRemarks),
      ],
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
}

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
