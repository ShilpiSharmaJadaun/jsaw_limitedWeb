import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/allDepart_bloc.dart';
import 'package:jsaw_limited/bloc/allplant_bloc.dart';
import 'package:jsaw_limited/bloc/employeeResponsibility_bloc.dart';
import 'package:jsaw_limited/bloc/observationby_uni_bloc.dart';
import 'package:jsaw_limited/bloc/priority_bloc.dart';
import 'package:jsaw_limited/bloc/update_observation_bloc.dart';
import 'package:jsaw_limited/model/observationby_uni_model.dart';
import 'package:jsaw_limited/utils/progressive_image.dart';
import 'package:jsaw_limited/pages/compliance_page.dart';
import 'package:jsaw_limited/state/observationby_uni_state.dart';
import 'package:jsaw_limited/state/update_observation_state.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../bloc/allhazard_cat_bloc.dart';
import '../bloc/location_bloc.dart';
import '../service/dashboard_service.dart';
import '../service/observation_service.dart';
import '../utils/app_color.dart';
import '../utils/page_header.dart';

class EditReceivedObservationsPage extends StatefulWidget {
  EditReceivedObservationsPage({super.key, required this.uniqueId, required this.raisedBy,
    required this.wrkGrp, required this.deptCode, required this.stateCode, required this.plant, this.department, this.responsibility,
  required this.location, required this.resHod, required this.priority, required this.hazard ,
    required this.observation, required this.name, required this.raisedDate , required this.raisedByEmpID, required this.status,
    required this.imageNumber, required this.correctiveMeasures, required this.targetDate, required this.complianceDate
  });
  final String? uniqueId; final String? raisedBy; final String? wrkGrp; final String? deptCode; final String? stateCode;
  final String? plant; final String? department; final String? responsibility;final String location;
  final String resHod; final String priority; final String hazard; final String observation; final String name;
  final String raisedDate; final String raisedByEmpID; final String status; final String imageNumber;
  final String correctiveMeasures; final String targetDate; final String complianceDate;

  @override
  State<EditReceivedObservationsPage> createState() => _EditReceivedObservationsPageState();
}

class _EditReceivedObservationsPageState extends State<EditReceivedObservationsPage> {


  late final ObservationbyUniBloc observationbyUniBloc;

  late final AllPlantBloc allPlantBloc;

  late final AllDepartBloc allDepartBloc;

  late final EmployeeResponsibilityBloc employeeResponsibilityBloc;

  late final LocationBloc locationBloc;

  late final UpdateObservationBloc updateObservationBloc;

  late final PriorityBloc priorityBloc;

  late final AllHazardCatBloc allHazardCatBloc;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  ValueNotifier<String> plant = ValueNotifier("Select Plant");
  ValueNotifier<String> department = ValueNotifier("Select Department");
  ValueNotifier<String> responsibility = ValueNotifier("Select Responsibility");
  ValueNotifier<String> location = ValueNotifier("Select Location");
  ValueNotifier<String> responsibleHOD = ValueNotifier("Select Responsible HOD");
  ValueNotifier<String> priority = ValueNotifier("Select Priority");
  ValueNotifier<String> priorityDesc = ValueNotifier("Select Priority");
  ValueNotifier<String> hazard = ValueNotifier("Select Hazard");

  late final workGroup;
  late final plantCode;
  late final departCode;
  late final stateCode;
  late final responsibleEnggCode;
  late final responsibleHODCode;
  late String priorityColor;
  late String priorityStatus =  widget.status;


  TextEditingController dateTimeController = TextEditingController();

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 2)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      helpText: "Select Target Date on Calendar",
    );

    if (selectedDate != null) {
      // Format the date as dd-MMMM-yyyy
      String formattedDate = DateFormat('dd-MMMM-yyyy').format(selectedDate);

      // Update the UI
      dateTimeController.text = formattedDate;

      // Perform backend update
      final data = {
        "uniqueIdentificationNumber": widget.uniqueId, // Pass your unique ID here
        "status": "IN PROGRESS",
        "observationCompletionTargetDate":formattedDate
      };

      // Assuming the updateObservationBloc has a method called `updateObservation`
      await updateObservationBloc.updateObservation(data);

      // Update local state
      setState(() {
        priorityStatus = "IN PROGRESS";
      });
    }
  }

  @override
  void initState(){
    super.initState();
    final observationService = Provider.of<ObservationService>(context, listen: false);
    final dashboardService = Provider.of<DashboardService>(context, listen: false);
    observationbyUniBloc = ObservationbyUniBloc(observationService);
    observationbyUniBloc.initState(widget.uniqueId.toString(), widget.raisedBy.toString());
    allPlantBloc = AllPlantBloc(observationService);
    allPlantBloc.initState();
    allDepartBloc = AllDepartBloc(observationService);
    workGroup = widget.wrkGrp.toString();
    employeeResponsibilityBloc = EmployeeResponsibilityBloc(observationService);
    locationBloc = LocationBloc(observationService);
    locationBloc.initState(widget.deptCode.toString());
    updateObservationBloc = UpdateObservationBloc(observationService);
    allHazardCatBloc = AllHazardCatBloc(dashboardService);
    allHazardCatBloc.initState();
    priorityBloc = PriorityBloc(observationService);
    priorityBloc.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusManager.instance.primaryFocus?.unfocus();
    });
    String priorityStatus = widget.status;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              PageHeader("Received Observations Details"),
              _buildObservation(),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              ),
              _buildObservationByUni()
            ],
          ),
        ),
      ),
    );
  }

  _buildObservationByUni(){
    return BlocConsumer<ObservationbyUniBloc, ObservationbyUniState>(
      bloc: observationbyUniBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading,
            content: _buildContent,
            success: _buildContent,
            failed: (form, __) => _buildContent(form));
      },
    );
  }

  Widget _buildLoading(List<ObservationbyUniModel> model){
    return const CircularProgressIndicator();
  }

  Widget _buildContent(List<ObservationbyUniModel> model){
    return ListView.builder(
      itemCount: model.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _buildHistoryCard(model[index]);
      },
    );
  }

  Widget _buildHistoryCard(ObservationbyUniModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kcVeryLightGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 180,
                height: 160,
                child: ProgressiveImage(
                  highUrl: item.imageCompliance,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.event_note_outlined, kcStatAmber),
                            const SizedBox(width: 8),
                            _buildLabel("Date :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                  item.updatedDate.isEmpty ? '—' : item.updatedDate,
                                  kcStatAmber),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.person_outline_rounded, kcStatBlue),
                            const SizedBox(width: 8),
                            _buildLabel("Action By :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                  item.updatedByEmpName.isEmpty
                                      ? '—'
                                      : item.updatedByEmpName,
                                  kcStatBlue),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(
                                Icons.workspace_premium_outlined, _statusColor(item.status)),
                            const SizedBox(width: 8),
                            _buildLabel("Status :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                  item.status.isEmpty ? '—' : item.status,
                                  _statusColor(item.status)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.grey.shade300,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildHistoryParagraph(
                    icon: Icons.visibility_outlined,
                    iconColor: kcObservationCyan,
                    label: "Observation",
                    text: item.observationText,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 6),
                  _buildHistoryParagraph(
                    icon: Icons.build_outlined,
                    iconColor: kcStatPurple,
                    label: "Action Taken",
                    text: item.actionTaken,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 6),
                  _buildHistoryParagraph(
                    icon: Icons.sticky_note_2_outlined,
                    iconColor: kcvoilet,
                    label: "Remark",
                    text: item.remarks,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryParagraph({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String text,
    int maxLines = 3,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIconBadge(icon, iconColor),
        const SizedBox(width: 8),
        _buildLabel("$label :"),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              text.isEmpty ? '—' : text,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: kcValueDark,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildHeadingText2(String title){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 120,
        child: Text(title, style: const TextStyle( fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black),),
      ),
    );
  }

  _buildTextBox2(String title, Color color){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.only(left: 3, right: 3),
        child: SizedBox(
          width: 300,
          child: Text(title,
            maxLines: 4,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: color),),
        ),
      ),
    );
  }

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF' + hexString;
    }
    return Color(int.parse(hexString, radix: 16));
  }

  _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide:   const BorderSide(color: kcDarkGreyColor,width: 1.5)
  );

  _buildObservation() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kcVeryLightGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----- Image -----
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 220,
                height: 200,
                child: ProgressiveImage(
                  highUrl: widget.imageNumber,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // ----- Content -----
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top: 3 columns of grouped info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              icon: Icons.person_outline_rounded,
                              iconColor: kcStatBlue,
                              label: "Raised By",
                              value: widget.raisedBy.toString(),
                              valueColor: kcValueDark,
                            ),
                            _buildInfoSection(
                              icon: Icons.factory_outlined,
                              iconColor: kcStatGreen,
                              label: "Plant / Dept",
                              value: widget.plant.toString(),
                              valueColor: kcValueDark,
                            ),
                            _buildInfoSection(
                              icon: Icons.assignment_ind_outlined,
                              iconColor: kcStatPurple,
                              label: "Responsibility",
                              value: widget.responsibility.toString(),
                              valueColor: kcmegenta,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              icon: Icons.qr_code_2_outlined,
                              iconColor: kcvoilet,
                              label: "Unique ID",
                              value: widget.uniqueId.toString(),
                              valueColor: kcValueDark,
                            ),
                            _buildInfoSection(
                              icon: Icons.apartment_outlined,
                              iconColor: kcStatBlue,
                              label: "Department",
                              value: widget.department.toString(),
                              valueColor: kcValueDark,
                            ),
                            _buildInfoSection(
                              icon: Icons.supervisor_account_outlined,
                              iconColor: kcvoilet,
                              label: "Res. HOD",
                              value: widget.resHod.toString(),
                              valueColor: kcValueDark,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              icon: Icons.workspace_premium_outlined,
                              iconColor: _statusColor(widget.status),
                              label: "Status",
                              value: widget.status.toString(),
                              valueColor: _statusColor(widget.status),
                            ),
                            _buildInfoSection(
                              icon: Icons.location_on_outlined,
                              iconColor: kcStatRed,
                              label: "Location",
                              value: widget.location.toString(),
                              valueColor: kcValueDark,
                            ),
                            _buildInfoSection(
                              icon: Icons.warning_amber_outlined,
                              iconColor: kcStatAmber,
                              label: "Hazard",
                              value: widget.hazard.toString(),
                              valueColor: kcValueDark,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Soft gradient divider
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.grey.shade300,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Date pill row: Raised + Target
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.event_note_outlined, kcStatAmber),
                            const SizedBox(width: 8),
                            _buildLabel("Raised Date :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                  widget.raisedDate.toString(), kcStatAmber),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.event_outlined, kcvoilet),
                            const SizedBox(width: 8),
                            _buildLabel("Target Date :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                  widget.targetDate.isEmpty ? '—' : widget.targetDate,
                                  kcvoilet),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Compliance + Priority
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.event_available_outlined, kcStatGreen),
                            const SizedBox(width: 8),
                            _buildLabel("Compliance Date :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                widget.complianceDate.trim().isEmpty
                                    ? '—'
                                    : widget.complianceDate,
                                widget.complianceDate.trim().isEmpty
                                    ? kcLightGrey
                                    : kcStatGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.flag_outlined, kcStatAmber),
                            const SizedBox(width: 8),
                            _buildLabel("Priority :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                  widget.priority.toString(), kcStatAmber),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Observation paragraph
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconBadge(Icons.visibility_outlined, kcObservationCyan),
                      const SizedBox(width: 8),
                      _buildLabel("Observation :"),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            widget.observation.isEmpty ? '—' : widget.observation,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: kcValueDark,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Corrective measure paragraph
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconBadge(Icons.build_outlined, kcStatPurple),
                      const SizedBox(width: 8),
                      _buildLabel("Corrective Measure :"),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            widget.correctiveMeasures.isEmpty
                                ? '—'
                                : widget.correctiveMeasures,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: kcValueDark,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Action buttons
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: (priorityStatus == "IN PROGRESS")
                              ? () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    builder: (context) =>
                                        CompliancePageBottomSheet(
                                      unqIdnNo: widget.uniqueId.toString(),
                                      raisedByUnqID: widget.raisedByEmpID,
                                    ),
                                  );
                                  setState(() {
                                    priorityStatus = "COMPLIANCE SENT";
                                  });
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(200, 30),
                              backgroundColor: navyBlue),
                          child: Text(
                            priorityStatus == "CLOSED" ||
                                    priorityStatus == "COMPLIANCE"
                                ? "COMPLIANCE SENT"
                                : "Send Compliance",
                            style: TextStyle(
                              color: priorityStatus == "CLOSED"
                                  ? Colors.black
                                  : priorityStatus == "COMPLIANCE"
                                      ? Colors.black
                                      : kcWhite,
                            ),
                          ),
                        ),
                      ),
                      _buildUpdate(widget.status),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Card-style helpers (matches receivedObservation.dart) ───

  Color _statusColor(String status) {
    switch (status.trim().toUpperCase()) {
      case 'CLOSED':
        return kcStatGreen;
      case 'PENDING':
        return kcStatRed;
      case 'IN PROGRESS':
        return kcStatPurple;
      case 'COMPLIANCE':
        return kcStatAmber;
      default:
        return kcLightGrey;
    }
  }

  Widget _buildInfoSection({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4, top: 4),
          child: Row(
            children: [
              _buildIconBadge(icon, iconColor),
              const SizedBox(width: 6),
              Flexible(child: _buildLabel("$label :")),
            ],
          ),
        ),
        _buildAccentTextBox(value, valueColor, accentColor: iconColor),
      ],
    );
  }

  Widget _buildIconBadge(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color, size: 16),
    );
  }

  Widget _buildPillBadge(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: kcLabelGrey,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildAccentTextBox(String title, Color color,
      {Color? accentColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 36),
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kcVeryLightGrey, width: 1),
          boxShadow: [
            BoxShadow(
              color: (accentColor ?? Colors.black).withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (accentColor != null)
                Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Text(
                    title.isEmpty ? '—' : title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildUpdate(String status) {
    return BlocConsumer<UpdateObservationBloc, UpdateObservationState>(
      bloc: updateObservationBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message ?? "Observation In Progress Now"),
            ));
            },
          failed: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: (_) {
            return const Center(child: CircularProgressIndicator());
          },
          orElse: () {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 30),
                    backgroundColor: kcobservationgreen,
                  ),
                  onPressed: priorityStatus == "PENDING"
                      ? () async {
                    // Open calendar dialog and trigger backend logic
                    await _selectDateTime(context);
                  }
                      : null, // Disable the button if priorityStatus is not "PENDING"
                  child: Text(
                    priorityStatus == "PENDING" ? "Start Observation" : priorityStatus,
                    style: TextStyle(color:  priorityStatus == "PENDING" ? kcWhite : Colors.black  , ),
                  ),
                ),
              )
            );
          },
        );
      },
    );
  }

  _buildHeadingText(String title){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(title, style: const TextStyle( fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black),),
    );
  }

}


class ErrorPage extends StatelessWidget {
  final Exception error;

  ErrorPage({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Text('An error occurred: ${error.toString()}'),
      ),
    );
  }
}