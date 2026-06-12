import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/allBodyParts_bloc.dart';
import 'package:jsaw_limited/bloc/allNatureInjury_bloc.dart';
import 'package:jsaw_limited/bloc/allTypeIncident_bloc.dart';
import 'package:jsaw_limited/bloc/saveMedicalResponse_bloc.dart';
import 'package:jsaw_limited/model/allBodyParts_model.dart';
import 'package:jsaw_limited/model/allMedicalOfficerList_model.dart';
import 'package:jsaw_limited/model/allNatureInjury_model.dart';
import 'package:jsaw_limited/model/allTypeIncident_model.dart';
import 'package:jsaw_limited/state/allBodyParts_state.dart';
import 'package:jsaw_limited/state/allNatureInjury_state.dart';
import 'package:jsaw_limited/state/allTypeIncident_state.dart';
import 'package:jsaw_limited/state/saveMedicalResponse_state.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../bloc/employeeBasicDetail_bloc.dart';
import '../service/incident_service.dart';
import '../utils/app_color.dart';
import '../utils/progressive_image.dart';

class MedicalOfficerPage extends StatefulWidget {
  MedicalOfficerPage({
    super.key,
    required this.allMedicalOfficerListModel,
    this.onClose,
  });

  AllMedicalOfficerListModel allMedicalOfficerListModel;

  /// When provided, the page is rendered INLINE inside the app shell and this
  /// callback closes it (the bool is whether the list should refresh) instead
  /// of popping a full-screen route.
  final ValueChanged<bool>? onClose;

  @override
  State<MedicalOfficerPage> createState() => _MedicalOfficerPageState();
}

class _MedicalOfficerPageState extends State<MedicalOfficerPage> {
  static const Color _bgLight = Color(0xFFF5F7FA);
  static const Color _labelColor = Color(0xFF607D8B);

  late final TextEditingController detailsController;
  late final TextEditingController dateController;
  late final TextEditingController remarkController;

  DateTime? selectedDate;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.day.toString().padLeft(2, '0')}/"
            "${picked.month.toString().padLeft(2, '0')}/"
            "${picked.year}";
      });
    }
  }

  late EmployeeBasicDetailBloc employeeBasicDetailBloc;
  ValueNotifier<String> employeeId = ValueNotifier("");

  late AllNatureInjuryBloc allNatureInjuryBloc;
  ValueNotifier<String> injuryType = ValueNotifier("");

  late AllBodyPartsBloc allBodyPartsBloc;
  ValueNotifier<String> bodyPart = ValueNotifier("");

  late AllTypeIncidentBloc allTypeIncidentBloc;
  ValueNotifier<String> typeOfIncident = ValueNotifier("");

  late SaveMedicalResponseBloc saveMedicalResponseBloc;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    detailsController = TextEditingController();
    remarkController = TextEditingController();

    final incidentService = Provider.of<IncidentService>(context, listen: false);

    employeeBasicDetailBloc = EmployeeBasicDetailBloc(incidentService);
    employeeBasicDetailBloc.initState();

    allNatureInjuryBloc = AllNatureInjuryBloc(incidentService);
    allNatureInjuryBloc.initState();

    allBodyPartsBloc = AllBodyPartsBloc(incidentService);
    allBodyPartsBloc.initState();

    allTypeIncidentBloc = AllTypeIncidentBloc(incidentService);
    allTypeIncidentBloc.initState();

    saveMedicalResponseBloc = SaveMedicalResponseBloc(incidentService);
  }

  @override
  void dispose() {
    dateController.dispose();
    detailsController.dispose();
    remarkController.dispose();
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
    return Scaffold(
      backgroundColor: _bgLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFullWidthHeader("Medical Officer Form"),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                  /// Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 22.screenWidth,
                      height: 18.screenHeight,
                      child: ProgressiveImage(
                        highUrl: widget.allMedicalOfficerListModel.imageUrl,
                        lowUrl:
                            widget.allMedicalOfficerListModel.lowQualityImageUrl,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildSectionTitle("Incident Details"),
                  const SizedBox(height: 12),

                  /// Employee + Department
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildIcon(Icons.person_outline_rounded, Colors.blue, required: false),
                            const SizedBox(width: 8),
                            _buildHeadingText("Employee"),
                            const SizedBox(width: 10),
                            Expanded(child: _buildInfoText(widget.allMedicalOfficerListModel.employeeName)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIcon(Icons.business_outlined, Colors.teal, required: false),
                            const SizedBox(width: 8),
                            _buildHeadingText("Department"),
                            const SizedBox(width: 10),
                            Expanded(child: _buildInfoText(widget.allMedicalOfficerListModel.deptName)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// Unique Id + Engineer
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildIcon(Icons.badge_outlined, Colors.purple, required: false),
                            const SizedBox(width: 8),
                            _buildHeadingText("Employee Code"),
                            const SizedBox(width: 10),
                            Expanded(child: _buildInfoText(widget.allMedicalOfficerListModel.employeeCode)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIcon(Icons.engineering_outlined, Colors.indigo, required: false),
                            const SizedBox(width: 8),
                            _buildHeadingText("Responsible Engineer"),
                            const SizedBox(width: 10),
                            Expanded(child: _buildInfoText(widget.allMedicalOfficerListModel.responsibleShiftEngg)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// Description + Age
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildIcon(Icons.description_outlined, Colors.cyan, required: false),
                            const SizedBox(width: 8),
                            _buildHeadingText("Description"),
                            const SizedBox(width: 10),
                            Expanded(child: _buildInfoText(widget.allMedicalOfficerListModel.descpOfIncident)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIcon(Icons.cake_outlined, Colors.pink, required: false),
                            const SizedBox(width: 8),
                            _buildHeadingText("Age"),
                            const SizedBox(width: 10),
                            Expanded(child: _buildInfoText(widget.allMedicalOfficerListModel.age == 0 ? "" : widget.allMedicalOfficerListModel.age.toString())),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle("Medical Assessment"),
                  const SizedBox(height: 12),

                  /// nature Of Injury + Body Part
                  Row(
                    children: [

                      Expanded(
                        child: Row(
                          children: [
                            _buildIcon(Icons.local_hospital_outlined, Colors.red),
                            const SizedBox(width: 8),
                            _buildHeadingText("Nature Of Injury"),
                            const SizedBox(width: 10),
                            Expanded(child: _buildAllTypeOfIncident()),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIcon(Icons.accessibility_new_rounded, Colors.orange),
                            const SizedBox(width: 8),
                            _buildHeadingText("Body Part"),
                            const SizedBox(width: 10),
                            Expanded(child: _buildBodyPart()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// Fit for Duty Date + Rest Upto
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildIcon(Icons.hotel_outlined, Colors.amber, required: false),
                            const SizedBox(width: 8),
                            _buildHeadingText("Rest Upto in Days"),
                            const SizedBox(width: 10),
                            Expanded(child: _buildDetailsTextField()),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIcon(Icons.event_available_outlined, Colors.green, required: false),
                            const SizedBox(width: 8),
                            _buildHeadingText("Fit for Duty from Date"),
                            const SizedBox(width: 10),
                            Expanded(child: _buildDateTextField()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                      Row(
                        children: [
                          _buildIcon(Icons.health_and_safety_outlined, Colors.teal),
                          const SizedBox(width: 8),
                          _buildHeadingText("Remark"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildRemarkTextField()),
                        ],
                      ),
                      const SizedBox(height: 24),
                  _buildSubmitButton(),
                  const SizedBox(height: 20),
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

  Widget _buildFullWidthHeader(String title) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFF7B2C), Color(0xFFEF4A8B), Color(0xFF8B5CF6)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: kcWhite),
              onPressed: () { _close(false); },
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kcWhite,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.allMedicalOfficerListModel.uniqueId.isEmpty
                          ? "Incident details"
                          : "Incident ID: ${widget.allMedicalOfficerListModel.uniqueId}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.92),
                      ),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(width: 4, height: 18, color: kclightOrange),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _labelColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Divider(color: Colors.grey.shade300)),
        ],
      ),
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

  Widget _buildInfoText(String title) {
    final isEmpty = title.isEmpty;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        isEmpty ? "—" : title,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: isEmpty ? Colors.grey.shade400 : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDetailsTextField() {
    return TextFormField(
      controller: detailsController,
      maxLines: 1,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: "Enter days",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  Widget _buildDateTextField() {
    return TextField(
      controller: dateController,
      readOnly: true,
      onTap: _pickDate,
      decoration: InputDecoration(
        hintText: "Select date",
        suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  Widget _buildRemarkTextField() {
    return TextFormField(
      controller: remarkController,
      maxLines: 10,
      minLines: 1,
      decoration: InputDecoration(
        hintText: "Enter details",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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

  /// Body Part
  Widget _buildBodyPart() {
    return BlocConsumer<AllBodyPartsBloc, AllBodyPartsState>(
      bloc: allBodyPartsBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: (_) => const SizedBox(height: 44, child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
            content: _buildBodyPartDropdown,
            success: _buildBodyPartDropdown,
            failed: (form, __) => _buildBodyPartDropdown(form));
      },
    );
  }

  Widget _buildBodyPartDropdown(List<AllBodyPartsModel> allBodyPart) {
    return ValueListenableBuilder<String>(
      valueListenable: bodyPart,
      builder: (context, value, child) => _buildSelector(
        value.isEmpty ? "Select Body Part" : value,
        value.isEmpty,
            () => _buildBodyPartDialog(allBodyPart),
      ),
    );
  }

  Future<void> _buildBodyPartDialog(List<AllBodyPartsModel> allBodyPart) {
    final list = BodyPartListNotifier(allBodyPart);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select Body Part",
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
            child: ValueListenableBuilder<List<AllBodyPartsModel>>(
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
                          bodyPart.value = items[index].description;
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

  /// Type of Incident (Nature of Injury)
  Widget _buildAllTypeOfIncident() {
    return BlocConsumer<AllTypeIncidentBloc, AllTypeIncidentState>(
      bloc: allTypeIncidentBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: (_) => const SizedBox(height: 44, child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
            content: _buildAllTypeOfIncidentDropdown,
            success: _buildAllTypeOfIncidentDropdown,
            failed: (form, __) => _buildAllTypeOfIncidentDropdown(form));
      },
    );
  }

  Widget _buildAllTypeOfIncidentDropdown(List<AllTypeIncidentModel> allTypeIncident) {
    return ValueListenableBuilder<String>(
      valueListenable: typeOfIncident,
      builder: (context, value, child) => _buildSelector(
        value.isEmpty ? "Select Nature of Injury" : value,
        value.isEmpty,
            () => _buildAllTypeOfIncidentDialog(allTypeIncident),
      ),
    );
  }

  Future<void> _buildAllTypeOfIncidentDialog(List<AllTypeIncidentModel> allTypeIncident) {
    final list = IncidentTypeNotifier(allTypeIncident);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select Nature of Injury",
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
            child: ValueListenableBuilder<List<AllTypeIncidentModel>>(
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
                          typeOfIncident.value = items[index].description;
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

  Widget _buildSubmitButton() {
    return BlocConsumer<SaveMedicalResponseBloc, SaveMedicalResponseState>(
      bloc: saveMedicalResponseBloc,
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
        return SizedBox(
          width: 300,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: isLoading
                ? null
                : () {
                    final data = {
                      "incidentUniqueId": widget.allMedicalOfficerListModel.uniqueId,
                      // "typeOfInjury": injuryType.value,
                      "bodyPart": bodyPart.value,
                      "natureOfInjury": typeOfIncident.value,
                      "restUpto": detailsController.text,
                      "fitForDutyFrom": selectedDate == null
                          ? ""
                          : "${selectedDate!.year.toString().padLeft(4, '0')}-"
                              "${selectedDate!.month.toString().padLeft(2, '0')}-"
                              "${selectedDate!.day.toString().padLeft(2, '0')}",
                      "medicalOfficerRemarks" : remarkController.text
                    };
                    saveMedicalResponseBloc.saveResponce(data);
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
        );
      },
    );
  }

}

class InjuryTypeListNotifier extends ValueNotifier<List<AllNatureInjuryModel>> {
  InjuryTypeListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllNatureInjuryModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue
          .where((e) => e.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

class BodyPartListNotifier extends ValueNotifier<List<AllBodyPartsModel>> {
  BodyPartListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllBodyPartsModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue
          .where((e) => e.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

class IncidentTypeNotifier extends ValueNotifier<List<AllTypeIncidentModel>> {
  IncidentTypeNotifier(super.value) {
    initialValue = value;
  }

  late List<AllTypeIncidentModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue
          .where((e) => e.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}