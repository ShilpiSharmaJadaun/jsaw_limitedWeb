import 'package:flutter/material.dart';
import 'package:jsaw_limited/bloc/saveSafetyRemarkResponse_bloc.dart';
import 'package:jsaw_limited/model/safetyRemarkList_model.dart';
import 'package:jsaw_limited/state/saveSafetyRemarkResponse_state.dart';
import 'package:jsaw_limited/utils/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/allNatureInjury_bloc.dart';
import '../model/allNatureInjury_model.dart';
import '../service/incident_service.dart';
import '../state/allNatureInjury_state.dart';
import '../utils/app_color.dart';
import 'medical_Officer_page.dart';

class SafetyRemarkPage extends StatefulWidget {
  const SafetyRemarkPage({
    super.key,
    required this.safetyRemarkListModel,
    this.onClose,
  });

  final SafetyRemarkListModel safetyRemarkListModel;

  /// When provided, the page is rendered INLINE inside the app shell and this
  /// callback closes it (the bool is whether the list should refresh) instead
  /// of popping a full-screen route.
  final ValueChanged<bool>? onClose;

  @override
  State<SafetyRemarkPage> createState() => _SafetyRemarkPageState();
}

class _SafetyRemarkPageState extends State<SafetyRemarkPage> {
  late final TextEditingController safetyRemarkController;

  static const Color _bgLight = Color(0xFFF5F7FA);
  static const Color _cardBorder = Color(0xFFE4E9EF);
  static const Color _labelColor = Color(0xFF607D8B);
  static const Color _valueColor = Color(0xFF263238);
  static const Color _accentPrimary = Color(0xFF1E88E5);

  late SafetyRemarkResponseBloc safetyRemarkResponseBloc;

  late AllNatureInjuryBloc allNatureInjuryBloc;
  ValueNotifier<String> injuryType = ValueNotifier("");

  @override
  void initState() {
    super.initState();
    safetyRemarkController = TextEditingController();
    final incidentService = Provider.of<IncidentService>(context, listen: false);
    safetyRemarkResponseBloc = SafetyRemarkResponseBloc(incidentService);
    allNatureInjuryBloc = AllNatureInjuryBloc(incidentService);
    allNatureInjuryBloc.initState();
  }

  @override
  void dispose() {
    safetyRemarkController.dispose();
    super.dispose();
  }

  // Close the page: inline mode calls back to the host; route mode pops.
  void _close(bool refresh) {
    if (widget.onClose != null) {
      widget.onClose!(refresh);
    } else {
      Navigator.pop(context, refresh);
    }
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.safetyRemarkListModel;
    return Scaffold(
      backgroundColor: _bgLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(m),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              child: Column(
                children: [
                  _buildHeroImage(m.imageUrl, m.lowQualityImageUrl),
                  const SizedBox(height: 20),
                  _buildIncidentDetailsCard(m),
                  const SizedBox(height: 16),
                  _buildDescriptionCard(m.descpOfIncident),
                  const SizedBox(height: 16),
                  _buildMedicalAssessmentCard(m),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildIcon(Icons.healing_outlined, Colors.deepOrange),
                      const SizedBox(width: 8),
                      _buildHeadingText("Type Of Injury"),
                      const SizedBox(width: 10),
                      Expanded(child: _buildInjuryType()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSafetyRemarkCard(),
                  const SizedBox(height: 24),
                  _buildSubmitButton(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- Header --------------------
  Widget _buildHeader(SafetyRemarkListModel m) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFF7B2C), Color(0xFFEF4A8B), Color(0xFF8B5CF6)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: Colors.white.withValues(alpha: 0.18),
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: kcWhite),
                  onPressed: () => _close(false),
                  tooltip: 'Back',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Safety Observation",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: kcWhite,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      m.incidentUniqueId.isEmpty
                          ? "Incident details"
                          : "Incident ID: ${m.incidentUniqueId}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.92),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (m.incidentType.isNotEmpty) _statusChip(m.incidentType),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: kcWhite,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // -------------------- Hero Image --------------------
  Widget _buildHeroImage(String url, String lowUrl) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 22.screenWidth,
          height: 18.screenHeight,
          child: url.isEmpty
              ? _imagePlaceholder()
              : ProgressiveImage(highUrl: url, lowUrl: lowUrl),
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: Colors.grey.shade100,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.image_outlined, size: 40, color: Colors.grey.shade400),
          const SizedBox(height: 6),
          Text(
            "No image",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
          ),
        ],
      ),
    );
  }

  // -------------------- Section Card --------------------
  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _valueColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey.shade200, height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }

  // -------------------- Incident Details --------------------
  Widget _buildIncidentDetailsCard(SafetyRemarkListModel m) {
    return _sectionCard(
      title: "Incident Details",
      icon: Icons.assignment_outlined,
      color: _accentPrimary,
      child: Column(
        children: [
          _infoRow([
            _infoTile(
              icon: Icons.person_outline_rounded,
              color: Colors.blue,
              label: "Employee",
              value: m.employeeName,
            ),
            _infoTile(
              icon: Icons.badge_outlined,
              color: Colors.purple,
              label: "Employee Code",
              value: m.employeeCode,
            ),
          ]),
          const SizedBox(height: 12),
          _infoRow([
            _infoTile(
              icon: Icons.business_outlined,
              color: Colors.teal,
              label: "Department",
              value: m.deptName.trim(),
            ),
            _infoTile(
              icon: Icons.factory_outlined,
              color: Colors.indigo,
              label: "Plant",
              value: m.plant,
            ),
          ]),
          const SizedBox(height: 12),
          _infoRow([
            _infoTile(
              icon: Icons.engineering_outlined,
              color: Colors.deepPurple,
              label: "Responsible Engineer",
              value: m.responsibleShiftEngg,
            ),
            _infoTile(
              icon: Icons.location_on_outlined,
              color: Colors.pink,
              label: "Location",
              value: m.location,
            ),
          ]),
          const SizedBox(height: 12),
          _infoRow([
            _infoTile(
              icon: Icons.access_time_rounded,
              color: Colors.orange,
              label: "Shift",
              value: m.shift,
            ),
            _infoTile(
              icon: Icons.cake_outlined,
              color: Colors.redAccent,
              label: "Age",
              value: m.age == 0 ? "" : m.age.toString(),
            ),
          ]),
          const SizedBox(height: 12),
          _infoRow([
            _infoTile(
              icon: Icons.event_note_outlined,
              color: Colors.red,
              label: "FIR Received",
              value: m.firDateTime,
            ),
            _infoTile(
              icon: Icons.calendar_today_rounded,
              color: Colors.deepOrange,
              label: "Incident Date",
              value: m.incidentDateTime,
            ),
          ]),
        ],
      ),
    );
  }

  // -------------------- Description --------------------
  Widget _buildDescriptionCard(String description) {
    final isEmpty = description.trim().isEmpty;
    return _sectionCard(
      title: "Description of Incident",
      icon: Icons.description_outlined,
      color: Colors.cyan.shade700,
      child: Text(
        isEmpty ? "No description provided." : description,
        style: TextStyle(
          fontSize: 14,
          height: 1.5,
          color: isEmpty ? Colors.grey : _valueColor,
        ),
      ),
    );
  }

  // Medical officer (submitter) display: "Name (Code)" / just one / blank.
  String _medicalOfficerDisplay(SafetyRemarkListModel m) {
    final name = m.medicalOfficerName.trim();
    final code = m.medicalOfficerCode.trim();
    if (name.isNotEmpty && code.isNotEmpty) return "$name ($code)";
    if (name.isNotEmpty) return name;
    return code;
  }

  // -------------------- Medical Assessment --------------------
  Widget _buildMedicalAssessmentCard(SafetyRemarkListModel m) {
    return _sectionCard(
      title: "Medical Assessment",
      icon: Icons.medical_services_outlined,
      color: Colors.red.shade400,
      child: Column(
        children: [
          _infoRow([
            _infoTile(
              icon: Icons.badge_outlined,
              color: Colors.teal,
              label: "Medical Officer",
              value: _medicalOfficerDisplay(m),
            ),
          ]),
          const SizedBox(height: 12),
          _infoRow([
            _infoTile(
              icon: Icons.healing_outlined,
              color: Colors.red,
              label: "Type of Injury",
              value: m.typeOfInjury,
            ),
            _infoTile(
              icon: Icons.accessibility_new_outlined,
              color: Colors.deepPurple,
              label: "Body Part",
              value: m.bodyPart,
            ),
          ]),
          const SizedBox(height: 12),
          _infoRow([
            _infoTile(
              icon: Icons.local_hospital_outlined,
              color: Colors.orange,
              label: "Nature of Injury",
              value: m.natureOfInjury,
            ),
            _infoTile(
              icon: Icons.bedtime_outlined,
              color: Colors.indigo,
              label: "Rest Upto (days)",
              value: m.restUpto == 0 ? "" : m.restUpto.toString(),
            ),
          ]),
          const SizedBox(height: 12),
          _infoRow([
            _infoTile(
              icon: Icons.event_available_outlined,
              color: Colors.green,
              label: "Fit For Duty From",
              value: m.fitForDutyFrom,
            ),
            _infoTile(
              icon: Icons.warning_amber_rounded,
              color: Colors.amber.shade700,
              label: "Work Injury",
              value: m.workInjury,
            ),
          ]),
        ],
      ),
    );
  }

  // -------------------- Safety Remark Input --------------------
  Widget _buildSafetyRemarkCard() {
    return _sectionCard(
      title: "Safety Officer's Remark",
      icon: Icons.rate_review_outlined,
      color: _accentPrimary,
      child: TextFormField(
        controller: safetyRemarkController,
        maxLines: 6,
        minLines: 4,
        textInputAction: TextInputAction.newline,
        style: const TextStyle(fontSize: 14, color: _valueColor),
        decoration: InputDecoration(
          hintText:
              "Enter your safety remark, observations, and recommended actions...",
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          filled: true,
          fillColor: _bgLight,
          contentPadding: const EdgeInsets.all(14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _accentPrimary, width: 1.5),
          ),
        ),
      ),
    );
  }

  // -------------------- Submit Button --------------------
  Widget _buildSubmitButton() {
    return BlocConsumer<SafetyRemarkResponseBloc, SafetyRemarkResponseState>(
      bloc: safetyRemarkResponseBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message ?? "Data Saved Successfully"),
            ));
            _close(true);
          },
          failed: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: (_) => true,
          orElse: () => false,
        );
        // Safety Remarks can only be submitted once the Medical Officer has
        // logged their remark for this incident.
        final hasMedicalRemark = widget
            .safetyRemarkListModel.medicalOfficerRemarks
            .trim()
            .isNotEmpty;
        return Column(
          children: [
            if (!hasMedicalRemark) ...[
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4E5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFFC107)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline,
                        size: 18, color: Color(0xFFB26A00)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'The Medical Officer has not submitted their remark for '
                        'this incident yet. Safety Remarks can be submitted only '
                        'after the Medical Officer response is recorded.',
                        style: TextStyle(
                            fontSize: 12.5, color: Color(0xFFB26A00)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(
          width: 300,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: (isLoading || !hasMedicalRemark)
                ? null
                : () {
              final data = {
                "incidentUniqueId": widget.safetyRemarkListModel.incidentUniqueId,
                "typeOfInjury": injuryType.value,
                "safetyRemarks": safetyRemarkController.text,
              };
              safetyRemarkResponseBloc.saveResponce(data);
            },
            icon: isLoading
                ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(kcWhite),
              ),
            )
                : const Icon(Icons.check_circle_outline, color: kcWhite),
            label: const Text(
              "Submit",
              style: TextStyle(
                color: kcWhite,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: kcRed,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
          ],
        );
      },
    );
  }

  // -------------------- Reusable info row + tile --------------------
  Widget _infoRow(List<Widget> children) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(child: children[i]),
        ],
      ],
    );
  }

  Widget _infoTile({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    final empty = value.trim().isEmpty;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _bgLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _labelColor,
                    letterSpacing: 0.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            empty ? "—" : value,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: empty ? Colors.grey.shade400 : _valueColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Injury Type
  Widget _buildInjuryType() {
    return BlocConsumer<AllNatureInjuryBloc, AllNatureInjuryState>(
      bloc: allNatureInjuryBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: (_) => const SizedBox(height: 44, child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
            content: _buildInjuryTypeDropdown,
            success: _buildInjuryTypeDropdown,
            failed: (form, __) => _buildInjuryTypeDropdown(form));
      },
    );
  }

  Widget _buildInjuryTypeDropdown(List<AllNatureInjuryModel> allNatureInjury) {
    return ValueListenableBuilder<String>(
      valueListenable: injuryType,
      builder: (context, value, child) => _buildSelector(
        value.isEmpty ? "Select Injury Type" : value,
        value.isEmpty,
            () => _buildInjuryTypeDialog(allNatureInjury),
      ),
    );
  }

  Future<void> _buildInjuryTypeDialog(List<AllNatureInjuryModel> allNatureInjury) {
    final list = InjuryTypeListNotifier(allNatureInjury);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select Injury Type",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              TextFormField(
                onChanged: list.filterBasedOn,
                decoration: const InputDecoration(
                  hintText: "search here...",
                  prefixIcon: Icon(Icons.search, color: kcLightGrey),
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 300,
            height: 400,
            child: ValueListenableBuilder<List<AllNatureInjuryModel>>(
              valueListenable: list,
              builder: (context, items, _) => ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          injuryType.value = items[index].description;
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(items[index].description),
                        ),
                      ),
                      const Divider(height: 1, color: kcDarkGreyColor),
                    ],
                  );
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("close", style: TextStyle(color: kcDarkGreyColor)),
            ),
          ],
        );
      },
    );
  }

  /// Colored icon, optionally with required asterisk.
  Widget _buildIcon(IconData icon, Color color, {bool required = true}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        if (required) ...[
          const SizedBox(width: 4),
          const Text("*", style: TextStyle(color: Colors.red, fontSize: 16)),
        ],
      ],
    );
  }

  Widget _buildHeadingText(String title) {
    return SizedBox(
      width: 140,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: _labelColor,
        ),
      ),
    );
  }

  /// Reusable styled dropdown selector box.
  Widget _buildSelector(String displayText, bool isPlaceholder, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                displayText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isPlaceholder ? Colors.grey : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}