import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jsaw_limited/bloc/allDepart_bloc.dart';
import 'package:jsaw_limited/bloc/allplant_bloc.dart';
import 'package:jsaw_limited/bloc/allwork_group_bloc.dart';
import 'package:jsaw_limited/bloc/complainceApproveReject_bloc.dart';
import 'package:jsaw_limited/bloc/employeeResponsibility_bloc.dart';
import 'package:jsaw_limited/bloc/observationby_uni_bloc.dart';
import 'package:jsaw_limited/bloc/priority_bloc.dart';
import 'package:jsaw_limited/bloc/update_observation_bloc.dart';
import 'package:jsaw_limited/model/allplant_model.dart';
import 'package:jsaw_limited/model/employeeResponsibility_model.dart';
import 'package:jsaw_limited/model/filterObservation_model.dart';
import 'package:jsaw_limited/model/observationby_uni_model.dart';
import 'package:jsaw_limited/model/update_observation_model.dart';
import 'package:jsaw_limited/pages/compliance_page.dart';
import 'package:jsaw_limited/routes/app_routes.dart';
import 'package:jsaw_limited/state/allDepart_state.dart';
import 'package:jsaw_limited/state/allplant_state.dart';
import 'package:jsaw_limited/state/complainceApproveReject_state.dart';
import 'package:jsaw_limited/state/employeeResponsibility_state.dart';
import 'package:jsaw_limited/state/observationby_uni_state.dart';
import 'package:jsaw_limited/state/update_observation_state.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../bloc/allhazard_cat_bloc.dart';
import '../bloc/location_bloc.dart';
import '../model/allDepartment_model.dart';
import '../model/allhazard_cat_model.dart';
import '../model/approve_compliance_model.dart';
import '../model/location_model.dart';
import '../model/priority_model.dart';
import '../service/dashboard_service.dart';
import '../service/observation_service.dart';
import '../state/allhazard_cat_state.dart';
import '../state/location_state.dart';
import '../state/priority_state.dart';
import '../utils/app_color.dart';
import '../utils/page_header.dart';
import 'package:web/web.dart' as html;

class ApproveObservationDetailPage extends StatefulWidget {
  ApproveObservationDetailPage({super.key, required this.model
  });

  FilterObservationModel model;

  @override
  State<ApproveObservationDetailPage> createState() => _ApproveObservationDetailPageState();
}

class _ApproveObservationDetailPageState extends State<ApproveObservationDetailPage> {


  late final ObservationbyUniBloc observationbyUniBloc;

  late final AllPlantBloc allPlantBloc;

  late final AllDepartBloc allDepartBloc;

  late final EmployeeResponsibilityBloc employeeResponsibilityBloc;

  late final LocationBloc locationBloc;

  late final UpdateObservationBloc updateObservationBloc;

  late final PriorityBloc priorityBloc;

  late final AllHazardCatBloc allHazardCatBloc;

  late final ComplainceApproveRejectBloc complainceApproveRejectBloc;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController remarkController = TextEditingController();

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

  @override
  void initState(){
    super.initState();
    final observationService = Provider.of<ObservationService>(context, listen: false);
    final dashboardService = Provider.of<DashboardService>(context, listen: false);
    observationbyUniBloc = ObservationbyUniBloc(observationService);
    observationbyUniBloc.initState(widget.model.observationRaisedByEmpUnqId.toString(), widget.model.observationRaisedBy.toString());
    allPlantBloc = AllPlantBloc(observationService);
    allPlantBloc.initState();
    allDepartBloc = AllDepartBloc(observationService);
    workGroup = widget.model.wrkGrp.toString();
    employeeResponsibilityBloc = EmployeeResponsibilityBloc(observationService);
    locationBloc = LocationBloc(observationService);
    locationBloc.initState(widget.model.plantDeptCode.toString());
    updateObservationBloc = UpdateObservationBloc(observationService);
    allHazardCatBloc = AllHazardCatBloc(dashboardService);
    allHazardCatBloc.initState();
    priorityBloc = PriorityBloc(observationService);
    priorityBloc.initState();
    complainceApproveRejectBloc = ComplainceApproveRejectBloc(observationService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            PageHeader("COMPLIANCE DETAILS"),
            _buildObservation(),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            ),
            _buildObservationByUni()
          ],
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
                child: Image.network(
                  item.imageCompliance,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade100,
                    alignment: Alignment.center,
                    child: Icon(Icons.broken_image_outlined,
                        color: Colors.grey.shade400, size: 48),
                  ),
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
                                  item.updatedByEmpName.isEmpty ? '—' : item.updatedByEmpName,
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
                    text: item.observationText,
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

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF' + hexString;
    }
    return Color(int.parse(hexString, radix: 16));
  }

  _buildObservation() {
    final m = widget.model;
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
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 220,
                    height: 200,
                    child: Image.network(
                      m.imageCompliance,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade100,
                        alignment: Alignment.center,
                        child: Icon(Icons.broken_image_outlined,
                            color: Colors.grey.shade400, size: 48),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextButton.icon(
                    onPressed: () => _showImageComparisonDialog(context),
                    icon: const Icon(Icons.compare_outlined, size: 16),
                    label: const Text("Compare Image"),
                    style: TextButton.styleFrom(
                      foregroundColor: kcvoilet,
                      fixedSize: const Size(220, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: kcVeryLightGrey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              value: m.observationRaisedByEmpUnqId.toString(),
                              valueColor: kcValueDark,
                            ),
                            _buildInfoSection(
                              icon: Icons.factory_outlined,
                              iconColor: kcStatGreen,
                              label: "Plant / Dept",
                              value: m.plantDept.toString(),
                              valueColor: kcValueDark,
                            ),
                            _buildInfoSection(
                              icon: Icons.assignment_ind_outlined,
                              iconColor: kcStatPurple,
                              label: "Responsibility",
                              value: m.responsibility.toString(),
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
                              value: m.uniqueIdentificationNumber.toString(),
                              valueColor: kcValueDark,
                            ),
                            _buildInfoSection(
                              icon: Icons.apartment_outlined,
                              iconColor: kcStatBlue,
                              label: "Department",
                              value: m.plantDept.toString(),
                              valueColor: kcValueDark,
                            ),
                            _buildInfoSection(
                              icon: Icons.supervisor_account_outlined,
                              iconColor: kcvoilet,
                              label: "Res. HOD",
                              value: m.responsibilityHODName.toString(),
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
                              iconColor: _statusColor(m.status),
                              label: "Status",
                              value: m.status,
                              valueColor: _statusColor(m.status),
                            ),
                            _buildInfoSection(
                              icon: Icons.location_on_outlined,
                              iconColor: kcStatRed,
                              label: "Location",
                              value: m.location.toString(),
                              valueColor: kcValueDark,
                            ),
                            _buildInfoSection(
                              icon: Icons.warning_amber_outlined,
                              iconColor: kcStatAmber,
                              label: "Hazard",
                              value: m.hazardCategory.toString(),
                              valueColor: kcValueDark,
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
                                  m.raisedDate.toString(), kcStatAmber),
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
                                  m.observationCompletionTargetDate.toString().isEmpty
                                      ? '—'
                                      : m.observationCompletionTargetDate.toString(),
                                  kcvoilet),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                                m.complianceDate.trim().isEmpty
                                    ? '—'
                                    : m.complianceDate,
                                m.complianceDate.trim().isEmpty
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
                                  m.priorityStatusName.toString(), kcStatAmber),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
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
                            m.observationText.toString().isEmpty ? '—' : m.observationText.toString(),
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
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconBadge(Icons.sticky_note_2_outlined, kcvoilet),
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: _buildLabel("Remark :"),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                            maxLines: 4,
                            controller: remarkController,
                            decoration: InputDecoration(
                              hintText: "Enter Remark",
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: kcVeryLightGrey, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: kcVeryLightGrey, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: kcvoilet, width: 1.5),
                              ),
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: kcValueDark,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildReject(),
                      const SizedBox(width: 8),
                      _buildUpdate(),
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

  // ─── Card-style helpers ───

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

  Widget _buildAccentTextBox(String title, Color color, {Color? accentColor}) {
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

  void _showImageComparisonDialog(BuildContext context ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Image Comparison"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text("Before",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      width: 400,
                      child: Image.network(
                        widget.model.imageNumber, // Replace with your second image URL or AssetImage
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  const Text("After", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      width: 400,
                      child: Image.network(
                        widget.model.imageCompliance, // Replace with your first image URL or AssetImage
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }


  _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  const BorderSide(color: Colors.white,width: 1)
  );

  _buildUpdate() {
    return BlocConsumer<ComplainceApproveRejectBloc, ComplainceApproveRejectState>(
      bloc: complainceApproveRejectBloc,
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
                      backgroundColor: kcobservationgreen
                  ),
                  onPressed: () async {
                    final data = {
                      "uniqueIdentificationNumber": widget.model.uniqueIdentificationNumber.toString(),
                      "observationText": widget.model.observationText.toString(),
                      "actionTaken": widget.model.actionTaken.toString(),
                      "status": "CLOSED",
                      "remarks": remarkController.text,
                      "updatedByEmpId": html.window.localStorage.getItem('kEmployeeCode')!,
                      "updatedByEmpName": html.window.localStorage.getItem('kEmployeename')!,
                      "updatedByEmail": html.window.localStorage.getItem('kUserEmail')!,
                      "raisedByEmpID": widget.model.observationRaisedByEmpUnqId.toString(),
                      "imgURL": widget.model.imageCompliance
                    };
                    await complainceApproveRejectBloc.updateObservation(data);
                    observationbyUniBloc.initState(widget.model.uniqueIdentificationNumber.toString(), widget.model.observationRaisedByEmpUnqId.toString());
                  Navigator.pop(context);
                    },
                  child: const Text("Close", style: TextStyle(color: kcWhite),),
                ),
              ),
            );
          },
        );
      },
    );
  }

  _buildReject() {
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
                      backgroundColor: kcRed
                  ),
                  onPressed: () async {
                    final data = {
                      "uniqueIdentificationNumber": widget.model.uniqueIdentificationNumber.toString(),
                      "observationText": widget.model.observationText.toString(),
                      "actionTaken": widget.model.actionTaken.toString(),
                      "status": "IN PROGRESS",
                      "remarks": remarkController.text,
                      "updatedByEmpId": html.window.localStorage.getItem('kEmployeeCode')!,
                      "updatedByEmpName": html.window.localStorage.getItem('kEmployeename')!,
                      "updatedByEmail": html.window.localStorage.getItem('kUserEmail')!,
                      "raisedByEmpID": widget.model.observationRaisedByEmpUnqId.toString(),
                      "imgURL": widget.model.imageCompliance
                    };
                    await complainceApproveRejectBloc.updateObservation(data);
                    observationbyUniBloc.initState(widget.model.observationRaisedByEmpUnqId.toString(), widget.model.observationRaisedBy.toString());
                  },
                  child: const Text("Reopen", style: TextStyle(color: kcWhite),),
                ),
              ),
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

  _buildTextBox(String title, Color color){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.only(left: 3, right: 3),
        child: Text(title,
          maxLines: 4,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: color),),
      ),
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