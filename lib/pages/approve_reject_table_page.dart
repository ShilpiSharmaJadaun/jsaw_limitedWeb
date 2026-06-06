import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/utils/progressive_image.dart';
import 'package:jsaw_limited/pages/widgets/observation_filter.dart';
import 'package:provider/provider.dart';
import '../bloc/allDepart_bloc.dart';
import '../bloc/all_filter_observation_bloc.dart';
import '../bloc/allhazard_cat_bloc.dart';
import '../bloc/allobservation_bloc.dart';
import '../bloc/allplant_bloc.dart';
import '../bloc/alltype_hazard_bloc.dart';
import '../bloc/approve_compliance_bloc.dart';
import '../bloc/complainceApproveReject_bloc.dart';
import '../bloc/employeeResponsibility_bloc.dart';
import '../bloc/filterObservation_bloc.dart';
import '../bloc/location_bloc.dart';
import '../bloc/priority_bloc.dart';
import '../bloc/responsibleHod_bloc.dart';
import '../bloc/save_observation_bloc.dart';
import '../bloc/uniqueId_bloc.dart';
import '../bloc/update_observation_bloc.dart';
import '../model/allDepartment_model.dart';
import '../model/all_filter_observation_model.dart';
import '../model/allhazard_cat_model.dart';
import '../model/allplant_model.dart';
import '../model/alltype_hazard_model.dart';
import '../model/allwork_group_model.dart';
import '../model/employeeResponsibility_model.dart';
import '../model/filterObservation_model.dart';
import '../model/location_model.dart';
import '../model/priority_model.dart';
import '../model/stationwise_graphtable_model.dart';
import '../model/uniqueId_model.dart';
import '../service/dashboard_service.dart';
import '../service/observation_service.dart';
import '../state/allDepart_state.dart';
import '../state/all_filter_observation_state.dart';
import '../state/allhazard_cat_state.dart';
import '../state/allplant_state.dart';
import '../state/complainceApproveReject_state.dart';
import '../state/employeeResponsibility_state.dart';
import '../state/filterObservation_state.dart';
import '../state/location_state.dart';
import '../state/priority_state.dart';
import '../state/responsibleHOD_state.dart';
import '../state/uniqueId_state.dart';
import '../state/update_observation_state.dart';
import '../utils/app_color.dart';
import 'package:web/web.dart' show window;
import 'package:web/web.dart' as html;

import 'observation.dart';

class ApproveRejectTablePage extends StatefulWidget {
  const ApproveRejectTablePage({super.key});

  @override
  State<ApproveRejectTablePage> createState() => _ApproveRejectTablePageState();
}

class _ApproveRejectTablePageState extends State<ApproveRejectTablePage> {

  late final ApproveComplianceBloc approveComplianceBloc;

  late final AllPlantBloc allPlantBloc;

  late final AllDepartBloc allDepartBloc;

  late final EmployeeResponsibilityBloc employeeResponsibilityBloc;

  late final PriorityBloc priorityBloc;

  late final LocationBloc locationBloc;

  late final AllHazardCatBloc allHazardCatBloc;

  late final SaveObservationBloc saveObservationBloc;

  late final AllTypeHazardBloc allTypeHazardBloc;

  late final ResponsibleHODBloc responsibleHODBloc;
  //
  // late final AllObservationBloc allObservationBloc;

  late final AllFilterObservationBloc allFilterObservationBloc;

  late final ComplainceApproveRejectBloc complainceApproveRejectBloc;

  late final UpdateObservationBloc updateObservationBloc;

  late final UniqueIdBloc uniqueIdBloc;

  final Map<int, TextEditingController> _remarkControllers = {};

  TextEditingController _remarkFor(int index) {
    return _remarkControllers.putIfAbsent(index, () => TextEditingController());
  }

  bool isLoading = false;
  bool isLastUpdate = false;

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  ValueNotifier<String> workGroup = ValueNotifier("Select Work Group");
  ValueNotifier<String> plant = ValueNotifier("Filter Plant");
  ValueNotifier<String> stat = ValueNotifier("Filter Department");
  ValueNotifier<String> responsibility = ValueNotifier("Filter Responsibility");
  ValueNotifier<String> responsibleHOD = ValueNotifier("Filter Responsible HOD");
  ValueNotifier<String> priority = ValueNotifier("");
  ValueNotifier<String> priorityDesc = ValueNotifier("Deadline");
  ValueNotifier<String> location = ValueNotifier("");
  ValueNotifier<String> uniqueId = ValueNotifier("");
  ValueNotifier<String> hazard = ValueNotifier("");
  ValueNotifier<String> hazardType = ValueNotifier("Select Hazard Type");
  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController fromDateInput = TextEditingController();

  List<String> statusList = ['PENDING', 'CLOSED', 'IN PROGRESS', 'COMPLIANCE'];

  late String employeeName;
  late String employeeCode;
  late String sessionID = window.localStorage.getItem('ksessionID') ?? "";
  late String statCode = "";
  late String departCode = "";
  late String responsibleCode;
  late String responsibleHODCode;
  late String priorityColor = "";
  late String status = "";
  late String responsibleEnggDesignationCode = "";

  Set<int> selectedIndices = {};


  int currentPage = 0;
  final int itemsPerPage = 10;

  void _nextPage() {
    setState(() {
      currentPage++;
      allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", "", "",sessionID,"");
    });
  }

  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
        allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", "", "",sessionID,"");
      });
    }
  }

  void initState() {
    super.initState();
    final observationService = Provider.of<ObservationService>(context, listen: false);
    final dashboardService = Provider.of<DashboardService>(context, listen: false);

    approveComplianceBloc = ApproveComplianceBloc(observationService);
    String? employeeCode = html.window.localStorage.getItem('kEmployeeCode');
    approveComplianceBloc.initState();

    allPlantBloc = AllPlantBloc(observationService);
    allPlantBloc.initState();
    allDepartBloc = AllDepartBloc(observationService);
    employeeResponsibilityBloc = EmployeeResponsibilityBloc(observationService);
    employeeName = window.localStorage.getItem('kEmployeename') ?? "";
    employeeCode = window.localStorage.getItem('kEmployeeCode') ?? "";
    // sessionID = window.localStorage.getItem('ksessionID') ?? "";
    priorityBloc = PriorityBloc(observationService);
    priorityBloc.initState();
    locationBloc = LocationBloc(observationService);
    allHazardCatBloc = AllHazardCatBloc(dashboardService);
    allHazardCatBloc.initState();
    allTypeHazardBloc = AllTypeHazardBloc(observationService);
    allTypeHazardBloc.initState();
    saveObservationBloc = SaveObservationBloc(observationService);
    responsibleHODBloc = ResponsibleHODBloc(observationService);
    complainceApproveRejectBloc = ComplainceApproveRejectBloc(observationService);
    updateObservationBloc = UpdateObservationBloc(observationService);
    uniqueIdBloc = UniqueIdBloc(observationService);
    allFilterObservationBloc = AllFilterObservationBloc(observationService);
    allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "COMPLIANCE", "", "", "","","");
    startDateInput.text = "";
    endDateInput.text = "";
    fromDateInput.text = "";
  }

  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    for (final c in _remarkControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcDashboardBg1,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kcDashboardBg1, kcDashboardBg2],
          ),
        ),
        child: _buildDataTableBody(),
      ),
    );
  }

  _buildDataTableBody(){
    return BlocConsumer<AllFilterObservationBloc, AllFilterObservationState>(
      bloc: allFilterObservationBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: _buildDataTableLoading,
            content: _buildCreditNoteContent,
            success: _buildCreditNoteContent,
            failed: (form, __) => _buildCreditNoteContent(form));
      },
    );
  }

  Widget _buildDataTableLoading(AllFilterObservationModel model){
    return const CircularProgressIndicator();
  }

  Widget _buildCreditNoteContent(AllFilterObservationModel model){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildToolbar(model),
        _buildActionBar(model),
        Expanded(
          child: Scrollbar(
            trackVisibility: true,
            thumbVisibility: true,
            controller: _horizontalController,
            scrollbarOrientation: ScrollbarOrientation.bottom,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _horizontalController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(overscroll: false),
            child: Scrollbar(
              controller: _horizontalController,
              thumbVisibility: true,
              child: SizedBox(
                width: 2800,
                child: Row(
                  children: [
                    _buildTableHeaderContainer("Select", 170),
                    _buildTableHeaderContainer("Raised By", 170),
                    _buildTableHeaderContainer("Unique ID", 170),
                    _buildTableHeaderContainer("Date", 170),
                    _buildTableHeaderContainer("Plant / Dept", 170),
                    _buildTableHeaderContainer("Responsibility", 170),
                    _buildTableHeaderContainer("Responsible HOD", 170),
                    _buildTableHeaderContainer("Location", 170),
                    _buildTableHeaderContainer("Hazard", 170),
                    _buildTableHeaderContainer("Target Date", 170),
                    _buildTableHeaderContainer("Status", 170),
                    _buildTableHeaderContainer("Observation", 170),
                    _buildTableHeaderContainer("Before / After", 170),
                    _buildTableHeaderContainer("Remark", 170),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: Scrollbar(
                controller: _verticalController,
                thumbVisibility: true,
                child: SizedBox(
                  width: 2800,
                  child: ListView.builder(
                    controller: _verticalController,
                    itemCount: model.model.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          _buildApproveRejectBodyContainer(model, index),
                          _buildTableBodyContainer(model.model[index].observationRaisedBy.toString(), 200, rowIndex: index),
                          _buildTableBodyContainer(model.model[index].uniqueIdentificationNumber.toString(), 200, rowIndex: index),
                          _buildTableBodyContainer(model.model[index].raisedDate.toString(), 200, rowIndex: index),
                          _buildTableBodyContainer(model.model[index].plantDept.toString(), 200, rowIndex: index),
                          _buildTableBodyContainer(model.model[index].responsibility.toString(), 200, rowIndex: index),
                          _buildTableBodyContainer(model.model[index].responsibilityHODName.toString(), 200, rowIndex: index),
                          _buildTableBodyContainer(model.model[index].location.toString(), 200, rowIndex: index),
                          _buildTableBodyContainer(model.model[index].hazardCategory.toString(), 200, rowIndex: index),
                          _buildTableBodyContainer(model.model[index].observationCompletionTargetDate.toString(), 200, rowIndex: index),
                          _buildTableBodyContainer(model.model[index].status.toString(), 200, isStatus: true, rowIndex: index),
                          _buildTableBodyContainer(model.model[index].observationText.toString(), 200, rowIndex: index),
                          _buildImageContainer(model, index),
                          _buildRemarkCell(index),
                        ],
                      );
                    },

                  ),
                ),
              ),
            ),
          )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToolbar(AllFilterObservationModel model) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Pagination
          IconButton(
            tooltip: 'Previous',
            onPressed:
                model.totalItems != 0 && currentPage > 0 ? _previousPage : null,
            icon: const Icon(Icons.chevron_left),
            color: kcvoilet,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: kcvoilet.withOpacity(0.10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              model.totalItems == 0
                  ? 'No records'
                  : 'Page $currentPage / ${model.totalPages}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: kcvoilet,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Next',
            onPressed: model.totalItems != 0 && currentPage < model.totalPages
                ? _nextPage
                : null,
            icon: const Icon(Icons.chevron_right),
            color: kcvoilet,
          ),
          const SizedBox(width: 8),
          Container(
            height: 24,
            width: 1,
            color: kcVeryLightGrey,
          ),
          const SizedBox(width: 8),
          Text(
            '${model.totalItems} total',
            style: const TextStyle(
              fontSize: 12,
              color: kcLabelGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          // Right-side actions
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                currentPage = 0;
              });
              allFilterObservationBloc.initState(0, "", "", "", "", "",
                  "COMPLIANCE", "", "", "", "", "");
            },
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Refresh'),
            style: OutlinedButton.styleFrom(
              foregroundColor: kcStatGreen,
              side: BorderSide(color: kcStatGreen.withOpacity(0.4)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {
              uniqueIdBloc.initState();
              openFilterDialog();
            },
            icon: const Icon(Icons.filter_alt_outlined, size: 18),
            label: const Text('Filter'),
            style: ElevatedButton.styleFrom(
              backgroundColor: kcvoilet,
              foregroundColor: kcWhite,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar(AllFilterObservationModel model) {
    final hasSelection = selectedIndices.isNotEmpty;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: hasSelection
            ? kcvoilet.withOpacity(0.06)
            : kcWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: hasSelection
              ? kcvoilet.withOpacity(0.30)
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            hasSelection ? Icons.task_alt : Icons.checklist,
            color: hasSelection ? kcvoilet : kcLabelGrey,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            hasSelection
                ? '${selectedIndices.length} selected'
                : 'Select rows to act on',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: hasSelection ? kcvoilet : kcLabelGrey,
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Text(
              'Enter each row’s remark in the table',
              style: TextStyle(
                fontSize: 11,
                color: kcLabelGrey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          _buildUpdate(model),
          const SizedBox(width: 8),
          _buildReject(model),
        ],
      ),
    );
  }

  _buildTableHeaderContainer(String title, double width) {
    return Container(
      width: 200,
      height: 56,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [navyBlue, kcvoilet],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border(
          right: BorderSide(color: Color(0x33FFFFFF), width: 1),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: kcWhite,
              fontSize: 13,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }

  _buildTableBodyContainer(String title, double width,
      {bool isStatus = false, int rowIndex = 0}) {
    final zebra = rowIndex.isOdd ? kcDashboardBg1 : kcWhite;
    return Container(
      width: 200,
      constraints: const BoxConstraints(minHeight: 60),
      decoration: BoxDecoration(
        color: zebra,
        border: Border(
          right: BorderSide(color: Colors.grey.shade200),
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: isStatus
          ? _statusPill(title)
          : Text(
              title.isEmpty ? '—' : title,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
                color: kcValueDark,
              ),
            ),
    );
  }

  Widget _statusPill(String status) {
    final s = status.trim().toUpperCase();
    Color bg;
    Color fg;
    IconData icon;
    switch (s) {
      case 'CLOSED':
      case 'COMPLIANCE':
        bg = kcStatGreen;
        icon = Icons.check_circle_outline;
        fg = kcWhite;
        break;
      case 'PENDING':
        bg = kcStatAmber;
        icon = Icons.schedule;
        fg = kcWhite;
        break;
      case 'IN PROGRESS':
      case 'INPROGRESS':
        bg = kcStatPurple;
        icon = Icons.autorenew;
        fg = kcWhite;
        break;
      case 'REJECTED':
        bg = kcRed;
        icon = Icons.cancel_outlined;
        fg = kcWhite;
        break;
      default:
        bg = kcLabelGrey;
        icon = Icons.info_outline;
        fg = kcWhite;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: bg.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 6),
          Text(
            s.isEmpty ? '—' : s,
            style: TextStyle(
              color: fg,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  _buildApproveRejectBodyContainer(AllFilterObservationModel model, int index) {
    final isSelected = selectedIndices.contains(index);
    final zebra = index.isOdd ? kcDashboardBg1 : kcWhite;
    return Container(
      width: 200,
      constraints: const BoxConstraints(minHeight: 60),
      decoration: BoxDecoration(
        color: isSelected ? kcvoilet.withOpacity(0.08) : zebra,
        border: Border(
          right: BorderSide(color: Colors.grey.shade200),
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Center(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedIndices.remove(index);
              } else {
                selectedIndices.add(index);
              }
            });
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  size: 22,
                  color: isSelected ? kcvoilet : kcLightGrey,
                ),
                const SizedBox(width: 6),
                Text(
                  isSelected ? 'Selected' : 'Select',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? kcvoilet : kcLabelGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> getSelectedData(AllFilterObservationModel model) {
    return selectedIndices.map((index) {
      return {
        "uniqueIdentificationNumber": model.model[index].uniqueIdentificationNumber.toString(),
        "observationText": model.model[index].observationText.toString(),
        "actionTaken": model.model[index].actionTaken.toString(),
        "status": "CHECKED", // Example status
        "remarks": _remarkFor(index).text,
        "updatedByEmpId": html.window.localStorage.getItem('kEmployeeCode')!,
        "updatedByEmpName": html.window.localStorage.getItem('kEmployeename')!,
        "updatedByEmail": html.window.localStorage.getItem('kUserEmail')!,
        "raisedByEmpID": model.model[index].observationRaisedByEmpUnqId.toString(),
        "imgURL": model.model[index].imageCompliance,
      };
    }).toList();
  }

  _buildUpdate(AllFilterObservationModel model) {
    return BlocConsumer<ComplainceApproveRejectBloc, ComplainceApproveRejectState>(
      bloc: complainceApproveRejectBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            if (isLastUpdate) {  // Only show success message when last update is processed
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message ?? "Selected observations updated successfully."),
              ));
              setState(() {
                isLoading = false;
                selectedIndices.clear();
              });
            }
          },
          failed: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
            setState(() {
              isLoading = false;
            });
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final hasSelection = selectedIndices.isNotEmpty;
        return ElevatedButton.icon(
          onPressed: (isLoading || !hasSelection)
              ? null
              : () async {
                  setState(() {
                    isLoading = true;
                  });

                  final selectedData = selectedIndices.map((index) {
                    return {
                      "uniqueIdentificationNumber": model.model[index]
                          .uniqueIdentificationNumber
                          .toString(),
                      "observationText":
                          model.model[index].observationText.toString(),
                      "actionTaken":
                          model.model[index].actionTaken.toString(),
                      "status": "CLOSED",
                      "remarks": _remarkFor(index).text,
                      "updatedByEmpId":
                          html.window.localStorage.getItem('kEmployeeCode')!,
                      "updatedByEmpName":
                          html.window.localStorage.getItem('kEmployeename')!,
                      "updatedByEmail":
                          html.window.localStorage.getItem('kUserEmail')!,
                      "raisedByEmpID": model
                          .model[index].observationRaisedByEmpUnqId
                          .toString(),
                      "imgURL": model.model[index].imageCompliance,
                    };
                  }).toList();

                  for (int i = 0; i < selectedData.length; i++) {
                    isLastUpdate = (i == selectedData.length - 1);
                    await complainceApproveRejectBloc
                        .updateObservation(selectedData[i]);
                  }
                },
          icon: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(kcWhite),
                  ),
                )
              : const Icon(Icons.check_circle_outline,
                  size: 18, color: kcWhite),
          label: const Text('Close',
              style: TextStyle(
                  color: kcWhite,
                  fontSize: 13,
                  fontWeight: FontWeight.w700)),
          style: ElevatedButton.styleFrom(
            backgroundColor: kcobservationgreen,
            disabledBackgroundColor: kcVeryLightGrey,
            elevation: 0,
            padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }

  _buildReject(AllFilterObservationModel model) {
    return BlocConsumer<UpdateObservationBloc, UpdateObservationState>(
      bloc: updateObservationBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message ?? "Selected observations rejected successfully."),
            ));
          },
          failed: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final loading = state.maybeWhen(loading: (_) => true, orElse: () => false);
        final hasSelection = selectedIndices.isNotEmpty;
        return ElevatedButton.icon(
          onPressed: (loading || !hasSelection)
              ? null
              : () async {
                  final selectedData = selectedIndices.map((index) {
                    return {
                      "uniqueIdentificationNumber": model.model[index]
                          .uniqueIdentificationNumber
                          .toString(),
                      "observationText":
                          model.model[index].observationText.toString(),
                      "actionTaken":
                          model.model[index].actionTaken.toString(),
                      "status": "IN PROGRESS",
                      "remarks": _remarkFor(index).text,
                      "updatedByEmpId":
                          html.window.localStorage.getItem('kEmployeeCode')!,
                      "updatedByEmpName":
                          html.window.localStorage.getItem('kEmployeename')!,
                      "updatedByEmail":
                          html.window.localStorage.getItem('kUserEmail')!,
                      "raisedByEmpID": model
                          .model[index].observationRaisedByEmpUnqId
                          .toString(),
                      "imgURL": model.model[index].imageCompliance,
                    };
                  }).toList();

                  await Future.forEach(selectedData, (data) async {
                    await complainceApproveRejectBloc
                        .updateObservation(data);
                  });

                  setState(() {
                    selectedIndices.clear();
                  });
                },
          icon: loading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(kcWhite),
                  ),
                )
              : const Icon(Icons.replay, size: 18, color: kcWhite),
          label: const Text('Reopen',
              style: TextStyle(
                  color: kcWhite,
                  fontSize: 13,
                  fontWeight: FontWeight.w700)),
          style: ElevatedButton.styleFrom(
            backgroundColor: kcRed,
            disabledBackgroundColor: kcVeryLightGrey,
            elevation: 0,
            padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRemarkCell(int index) {
    final zebra = index.isOdd ? kcDashboardBg1 : kcWhite;
    return Container(
      width: 200,
      constraints: const BoxConstraints(minHeight: 60),
      decoration: BoxDecoration(
        color: zebra,
        border: Border(
          right: BorderSide(color: Colors.grey.shade200),
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: TextField(
        controller: _remarkFor(index),
        maxLines: 2,
        minLines: 1,
        style: const TextStyle(fontSize: 12.5),
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Add remark…',
          hintStyle: const TextStyle(
            fontSize: 12,
            color: kcLightGrey,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          filled: true,
          fillColor: kcWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: kcvoilet, width: 1.5),
          ),
        ),
      ),
    );
  }

  _buildImageContainer(AllFilterObservationModel model, int index){
    final zebra = index.isOdd ? kcDashboardBg1 : kcWhite;
    return Container(
      width: 200,
      constraints: const BoxConstraints(minHeight: 60),
      decoration: BoxDecoration(
        color: zebra,
        border: Border(
          right: BorderSide(color: Colors.grey.shade200),
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Center(
        child: TextButton.icon(
          onPressed: () => _showImageComparisonDialog(context, model, index),
          icon: const Icon(Icons.compare_outlined,
              size: 18, color: kcStatBlue),
          label: const Text(
            'Compare',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: kcStatBlue,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: kcStatBlue.withOpacity(0.08),
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  // Deprecated: replaced by per-row _buildRemarkCell; kept as no-op for any
  // stragglers calling it.
  Widget _buildRemarkContainer(){
    return const SizedBox.shrink();
  }

  void _showImageComparisonDialog(BuildContext context,AllFilterObservationModel model, int index ) {
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
                      child: ProgressiveImage(
                        highUrl: model.model[index].imageNumber,
                        lowUrl: model.model[index].lowQualityImageUrl,
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
                      child: ProgressiveImage(
                        highUrl: model.model[index].imageCompliance,
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
      // borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: kcBlack));

  Future<void> openFilterDialog() async {
    final employeeCode = window.localStorage.getItem('kEmployeeCode') ?? "";  // Retrieve value before dialog
    await _buildFilterDialog(context, employeeCode);  // Pass employeeCode to the dialog
  }

  Future<void> _buildFilterDialog(BuildContext dialogContext, String employeeCode) {
    return showDialog(
      context: dialogContext,
      builder: (ctx) => ObservationFilterDialog(
        startDateInput: startDateInput,
        endDateInput: endDateInput,
        fromDateInput: fromDateInput,
        plantWidget: _buildPlant(),
        departWidget: _buildDepartment(),
        statusWidget: _buildStatusContent(statusList),
        locationWidget: _buildLocation(),
        hazardWidget: _buildHazard(),
        uniqueIdWidget: _buildUniqueId(),
        onClear: () {
          clearFormValues();
          Navigator.pop(ctx);
        },
        onApply: () {
          // Snapshot the chosen filter values before clearFormValues() wipes them.
          final fStat = statCode;
          final fFrom = fromDateInput.text;
          final fEnd = endDateInput.text;
          final fLoc = location.value;
          final fDept = departCode;
          final fHazard = hazard.value;
          final fUin = uniqueId.value;

          // Close the dialog FIRST so it always dismisses.
          Navigator.pop(ctx);

          allFilterObservationBloc.initState(0, fStat, fFrom, fEnd, fLoc, fDept,
              "COMPLIANCE", fHazard, "", "", "", fUin);
          html.window.localStorage.removeItem('ksessionID');
          startDateInput.clear();
          endDateInput.clear();
          clearFormValues();
        },
      ),
    );
  }

  void clearFormValues() {
    // Reset ValueNotifier values
    workGroup.value = "";
    plant.value = "";
    stat.value = "";
    responsibility.value = "";
    responsibleHOD.value = "";
    priority.value = "";
    priorityDesc.value = "";
    location.value = "";
    hazard.value = "";
    hazardType.value = "";
    uniqueId.value = "";

    // Clear TextEditingControllers
    startDateInput.clear();
    endDateInput.clear();
    fromDateInput.clear();

    // Reset late-initialized String values
    employeeName = "";
    employeeCode = "";
    statCode = "";
    departCode = "";
    responsibleCode = "";
    responsibleHODCode = "";
    priorityColor = "";
    status="";
  }

  //date

  _buildDateRangeContainer(String hintText, TextEditingController controller,) {
    return SizedBox(
      width: 300,
      height: 40,
      child: TextFormField(
        controller: controller,  // Use the existing startController
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          hintText: hintText, // Hint text to show before selection
          fillColor: kcWhite,
          suffixIcon: const Icon(
            Icons.calendar_month, size: 20.0,
          ),
          filled: true,
          enabledBorder: _border(),
          focusedBorder: _border(),
        ),
        readOnly: true,
        onTap: () async {
          // Open a date range picker for selecting the start and end dates
          DateTimeRange? pickedDateRange = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            initialDateRange: startDateInput.text.isNotEmpty && endDateInput.text.isNotEmpty
                ? DateTimeRange(
              start: DateTime.parse(startDateInput.text),
              end: DateTime.parse(endDateInput.text),
            )
                : DateTimeRange(
              start: DateTime.now().subtract(const Duration(days: 7)),
              end: DateTime.now(),
            ),
          );

          if (pickedDateRange != null) {
            String formattedStartDate = DateFormat('yyyy-MM-dd').format(pickedDateRange.start);
            String formattedEndDate = DateFormat('yyyy-MM-dd').format(pickedDateRange.end);

            setState(() {
              // Set the start and end date inputs
              startDateInput.text = formattedStartDate;
              fromDateInput.text = formattedStartDate;// Display as "start to end"
              endDateInput.text = formattedEndDate; // Optionally, save end date separately if needed
            });
          }
        },
      ),
    );
  }


  //status

  Widget _buildStatusContent(List<String> statusList) {
    return FilterDropdownChip(
      notifier: priority, // priority stores the selected status
      placeholder: "Filter Status",
      onTap: () => showObservationPicker<String>(
        context: context,
        title: "Select Status",
        items: statusList,
        label: (s) => s,
        filter: (s, q) => s.toLowerCase().contains(q.toLowerCase()),
        onSelect: (s) => priority.value = s,
      ),
    );
  }

  Future<void> _buildStatusDialog(List<String> statusList) {
    final statusListNotifier = ValueNotifier<List<String>>(statusList);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select or search Status",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                onChanged: (value) {
                  // Filter the list based on user input
                  List<String> filteredList = statusList.where((status) => status.toLowerCase().contains(value.toLowerCase())).toList();
                  statusListNotifier.value = filteredList;
                },
                decoration: const InputDecoration(
                  hintText: "Search here...",
                  prefixIcon: Icon(Icons.search, color: kcLightGrey),
                ),
              )
            ],
          ),
          content: SizedBox(
            width: 210,
            height: 300,
            child: ValueListenableBuilder<List<String>>(
              valueListenable: statusListNotifier,
              builder: (context, list, widget) {
                return ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            priority.value = list[index]; // Update selected status
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(list[index]),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            height: 0.8,
                            thickness: 1,
                            color: kcDarkGreyColor,
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  // All Plant APi Implementation

  Widget _buildPlant(){
    return  BlocConsumer<AllPlantBloc, AllPlantState>(
      bloc: allPlantBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading1,
            content: _buildContent1,
            success: _buildContent1,
            failed: (form, __) => _buildContent1(form));
      },
    );
  }

  Widget _buildLoading1(List<AllPlantModel> model){
    return const LoadingChip();
  }

  Widget _buildContent1(List<AllPlantModel> model){
    return FilterDropdownChip(
      notifier: plant,
      placeholder: "Filter Plant",
      onTap: () => showObservationPicker<AllPlantModel>(
        context: context,
        title: "Select Plant",
        items: model,
        label: (m) => m.deptName,
        filter: (m, q) => m.deptName.toLowerCase().contains(q.toLowerCase()),
        onSelect: (m) {
          plant.value = m.deptName;
          departCode = m.deptCode;
          allDepartBloc.initState(departCode);
          locationBloc.initState(departCode);
        },
      ),
    );
  }

  Future<void> _buildallPlantListDialog(List<AllPlantModel> model) {
    final listNotifier = SearchableListNotifier(model);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // actionsPadding: EdgeInsets.all(5.dw),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            // contentPadding: EdgeInsets.all(10.dw),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search plant",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: listNotifier.filterBasedOn,
                  decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      )),
                )
              ],
            ),
            content: SizedBox(
                width: 200,
                height: 800,
                child:ValueListenableBuilder<List<AllPlantModel>>(
                    valueListenable: listNotifier,
                    builder: (context, list, widget){
                      return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    plant.value = list[index].deptName;
                                    departCode = list[index].deptCode;
                                    allDepartBloc.initState(departCode);
                                    locationBloc.initState(departCode);
                                    // filterObservationBloc.initState("", "", "", "", departCode, "", "", "", "");
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].deptName,),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.8,
                                    thickness: 1,
                                    color: kcDarkGreyColor,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                )
            ),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  // Unique Id
  Widget _buildUniqueId(){
    return  BlocConsumer<UniqueIdBloc, UniqueIdState>(
      bloc: uniqueIdBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildUniqueIDLoding,
            content: _buildUNiqueIdContent,
            success: _buildUNiqueIdContent,
            failed: (form, __) => _buildUNiqueIdContent(form));
      },
    );
  }

  Widget _buildUniqueIDLoding(List<UniqueIdModel> uniqueIdModel){
    return const LoadingChip();
  }

  Widget _buildUNiqueIdContent(List<UniqueIdModel> uniqueIdModel){
    return FilterDropdownChip(
      notifier: uniqueId,
      placeholder: "Filter Unique ID",
      onTap: () {
        uniqueIdBloc.initState();
        showObservationPicker<UniqueIdModel>(
          context: context,
          title: "Select Unique Id",
          items: uniqueIdModel,
          label: (m) => m.uniqueIdentificationNumber,
          filter: (m, q) =>
              m.uniqueIdentificationNumber.toLowerCase().contains(q.toLowerCase()),
          onSelect: (m) => uniqueId.value = m.uniqueIdentificationNumber,
        );
      },
    );
  }

  Future<void> _buildUniqueIdDialog(List<UniqueIdModel> uniqueIdModel) {
    final uniqueIdListNotifier = UniqueIdSearchableListNotifier(uniqueIdModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Location",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: uniqueIdListNotifier.filterBasedOn,
                  decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      )),
                )
              ],
            ),
            content: SizedBox(
                width: 210,
                height: 800,
                child:ValueListenableBuilder<List<UniqueIdModel>>(
                    valueListenable: uniqueIdListNotifier,
                    builder: (context, list, widget){
                      return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    uniqueId.value = list[index].uniqueIdentificationNumber;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].uniqueIdentificationNumber,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.8,
                                    thickness: 1,
                                    color: kcDarkGreyColor,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                )
            ),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  // //ALl Work Group
  //
  // Widget _buildWorkGroup(){
  //   return  BlocConsumer<AllWorkGroupBloc, AllWorkGroupState>(
  //     bloc: allWorkGroupBloc,
  //     listener: (_, state){},
  //     builder: (_, state){
  //       return state.when(
  //           loading: _buildLoading2,
  //           content: _buildContent2,
  //           success: _buildContent2,
  //           failed: (form, __) => _buildContent2(form));
  //     },
  //   );
  // }
  //
  // Widget _buildLoading2(List<AllWorkGroupModel> model){
  //   return const CircularProgressIndicator();
  // }
  //
  // Widget _buildContent2(List<AllWorkGroupModel> workModel){
  //   return Padding(
  //     padding: const EdgeInsets.all(5),
  //     child: InkWell(
  //       onTap: (){
  //         _buildallWorkGroupListDialog(workModel);
  //       },
  //       child: SizedBox(
  //         width: 150,
  //         height: 30,
  //         child: Container(
  //           width: 80,
  //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
  //           child: ValueListenableBuilder<String>(
  //             valueListenable: workGroup,
  //             builder: (context, value, child) => Padding(
  //               padding: const EdgeInsets.all(2.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   SizedBox(
  //                     width: 100,
  //                     child: Text(
  //                       workGroup.value,
  //                       textAlign: TextAlign.center,
  //                       maxLines: 4,
  //                       style: TextStyle(color: (workGroup.value == "Select Work Group") ? kcDarkGreyColor : kcLightGrey),
  //                     ),
  //                   ),
  //                   const Icon(Icons.arrow_drop_down_sharp)
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  //
  // }
  //
  // Future<void> _buildallWorkGroupListDialog(List<AllWorkGroupModel> workModel) {
  //   final listNotifier = WorkGroupSearchableListNotifier(workModel);
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           // actionsPadding: EdgeInsets.all(5.dw),
  //           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
  //           // contentPadding: EdgeInsets.all(10.dw),
  //           title: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const Text(
  //                 "Select or search Work Group",
  //                 style:
  //                 TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //               ),
  //               TextFormField(
  //                 onChanged: listNotifier.filterBasedOn,
  //                 decoration: const InputDecoration(
  //                     hintText: "search here...",
  //                     prefixIcon: Icon(
  //                       Icons.search,
  //                       color: kcLightGrey,
  //                     )),
  //               )
  //             ],
  //           ),
  //           content: SizedBox(
  //               width: 200,
  //               height: 800,
  //               child:ValueListenableBuilder<List<AllWorkGroupModel>>(
  //                   valueListenable: listNotifier,
  //                   builder: (context, list, widget){
  //                     return ListView.builder(
  //                         itemCount: list.length,
  //                         shrinkWrap: true,
  //                         itemBuilder: (context, index) {
  //                           return Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               InkWell(
  //                                 onTap: () {
  //
  //                                   allPlantBloc.initState();
  //                                   Navigator.pop(context);
  //                                 },
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.all(2.0),
  //                                   child: Text(list[index].wrkGrp,),
  //                                 ),
  //                               ),
  //                               const Padding(
  //                                 padding: EdgeInsets.all(8.0),
  //                                 child: Divider(
  //                                   height: 0.8,
  //                                   thickness: 1,
  //                                   color: kcDarkGreyColor,
  //                                 ),
  //                               )
  //                             ],
  //                           );
  //                         });
  //                   }
  //               )
  //           ),
  //           actions: [
  //             Align(
  //               alignment: Alignment.centerRight,
  //               child: TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text(
  //                   "close",
  //                   style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
  //                 ),
  //               ),
  //             )
  //           ],
  //         );
  //       }
  //   );
  // }

  // _buildObservationCard() {
  //   return Card(
  //     elevation: 2,
  //     color: kcWhite,
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Column(
  //                 // mainAxisAlignment: MainAxisAlignment.start,
  //                 // crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.all(1.screenWidth),
  //                     child: Image.asset(
  //                       alignment: Alignment.center,
  //                       "assets/images/peopleimage.jpg",
  //                       //fit: BoxFit.cover,
  //                       scale: 1.5.screenWidth,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           _buildHeadingText("Raised By"),
  //                           _buildHeadingText("-"),
  //                           _buildRaisedByTypeDropDown()
  //                         ],
  //                       ),
  //                       SizedBox(width: 200),
  //                       Row(
  //                         children: [
  //                           _buildHeadingText("Unique Identification no."),
  //                           _buildHeadingText("-"),
  //                           _buildTextBox("HSM/SO/3/2024", Colors.black),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           _buildHeadingText("Date"),
  //                           _buildHeadingText("-"),
  //                           _buildTextBox("04.03.2024", kcRed),
  //                         ],
  //                       ),
  //                       SizedBox(width: 260),
  //                       Row(
  //                         children: [
  //                           _buildHeadingText("Responsibility"),
  //                           _buildHeadingText("-"),
  //                           _buildTextBox("Mr. M Narayana", kcmegenta),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                   Row(
  //                     children: [
  //                       _buildHeadingText("Location"),
  //                       _buildHeadingText("-"),
  //                       _buildLocationTypeDropDown(),
  //                       SizedBox(width: 205),
  //                       Row(
  //                         children: [
  //                           _buildHeadingText("Plant / Dept"),
  //                           _buildHeadingText("-"),
  //                           _buildPlantTypeDropDown(),
  //
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                   Row(
  //                     children: [
  //                       _buildHeadingText("Category"),
  //                       _buildHeadingText("-"),
  //                       _buildCategoryTypeDropDown(),
  //                     ],
  //                   ),
  //                   Center(child: Container(height: 0.1.screenHeight,alignment: Alignment.center,color: kcVeryLightGrey,width: 140.screenWidth,)),
  //
  //                 ],
  //               ),
  //
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               _buildHeadingText("Observation"),
  //               SizedBox(
  //                 width: 100.screenWidth,
  //                 child: Padding(
  //                   padding: EdgeInsets.all(1.0.screenWidth),
  //                   child: Text(
  //                     "Oil spillage was found at gas regulating valve 1 area, at BF stove",
  //                     maxLines: 3,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 1.8.screenWidth,color: kcvoilet),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               _buildHeadingText("Corrective Action Taken/Suggested"),
  //               SizedBox(
  //                 width: 100.screenWidth,
  //                 child: Padding(
  //                   padding: EdgeInsets.all(1.0.screenWidth),
  //                   child: Text(
  //                     "it should be cleaned, to avoid slip & trip hazard",
  //                     maxLines: 3,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 1.8.screenWidth,color: kcvoilet),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Department APi Implementation

  //All Department

  Widget _buildDepartment(){
    return  BlocConsumer<AllDepartBloc, AllDepartState>(
      bloc: allDepartBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading4,
            content: _buildContent4,
            success: _buildContent4,
            failed: (form, __) => _buildContent4(form));
      },
    );
  }

  Widget _buildLoading4(List<AllDepartmentModel> departModel){
    return const LoadingChip();
  }

  Widget _buildContent4(List<AllDepartmentModel> departModel){
    return FilterDropdownChip(
      notifier: stat,
      placeholder: "Filter Department",
      onTap: () {
        if (departCode.isEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Please Select Plant")));
          return;
        }
        showObservationPicker<AllDepartmentModel>(
          context: context,
          title: "Select Department",
          items: departModel,
          label: (m) => m.statName,
          filter: (m, q) => m.statName.toLowerCase().contains(q.toLowerCase()),
          onSelect: (m) {
            stat.value = m.statName;
            statCode = m.statCode;
            employeeResponsibilityBloc.initState(
                departCode, statCode, window.localStorage.getItem('kDesgnCode')!);
          },
        );
      },
    );
  }

  Future<void> _buildallDepartDialog(List<AllDepartmentModel> departModel) {
    final departListNotifier = departmentSearchableListNotifier(departModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // actionsPadding: EdgeInsets.all(5.dw),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            // contentPadding: EdgeInsets.all(10.dw),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Department",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: departListNotifier.filterBasedOn,
                  decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      )),
                )
              ],
            ),
            content: SizedBox(
                width: 210,
                height: 800,
                child:ValueListenableBuilder<List<AllDepartmentModel>>(
                    valueListenable: departListNotifier,
                    builder: (context, list, widget){
                      return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    stat.value = list[index].statName;
                                    statCode = list[index].statCode;
                                    employeeResponsibilityBloc.initState(departCode, statCode, window.localStorage.getItem('kDesgnCode')!);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].statName,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.8,
                                    thickness: 1,
                                    color: kcDarkGreyColor,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                )
            ),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  // Responsibility

  Widget _buildResponsibility(){
    return  BlocConsumer<EmployeeResponsibilityBloc, EmployeeResponsibilityState>(
      bloc: employeeResponsibilityBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading3,
            content: _buildContent3,
            success: _buildContent3,
            failed: (form, __) => _buildContent3(form));
      },
    );
  }

  Widget _buildLoading3(List<EmployeeResponsibilityModel> responsibilityModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent3(List<EmployeeResponsibilityModel> responsibilityModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildResponsibilityDialog(responsibilityModel);
        },
        child: SizedBox(
          width: 180,
          height: 40,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: responsibility,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        responsibility.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (responsibility.value == "Select Responsibility") ? kcDarkGreyColor : kcLightGrey),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down_sharp)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  Future<void> _buildResponsibilityDialog(List<EmployeeResponsibilityModel> responsibilityModel) {
    final responsibilityListNotifier = responsibilitySearchableListNotifier(responsibilityModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Responsibility",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: responsibilityListNotifier.filterBasedOn,
                  decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      )),
                )
              ],
            ),
            content: SizedBox(
                width: 210,
                height: 800,
                child:ValueListenableBuilder<List<EmployeeResponsibilityModel>>(
                    valueListenable: responsibilityListNotifier,
                    builder: (context, list, widget){
                      return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    responsibility.value = list[index].empName;
                                    responsibleCode = list[index].empUnqId;
                                    workGroup.value = list[index].wrkGrp;
                                    responsibleHODBloc.initState(departCode, statCode, responsibleEnggDesignationCode, responsibleCode);
                                    //filterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", responsibleCode, "");
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].empName,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.8,
                                    thickness: 1,
                                    color: kcDarkGreyColor,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                )
            ),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  //Responsible HOD

  Widget _buildResponsibleHOD(){
    return  BlocConsumer<ResponsibleHODBloc, ResponsibleHODState>(
      bloc: responsibleHODBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading5,
            content: _buildContent5,
            success: _buildContent5,
            failed: (form, __) => _buildContent3(form));
      },
    );
  }

  Widget _buildLoading5(List<EmployeeResponsibilityModel> responsibilityModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent5(List<EmployeeResponsibilityModel> responsibilityModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildResponsibilityBYHODDialog(responsibilityModel);
        },
        child: SizedBox(
          width: 180,
          height: 40,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: responsibleHOD,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        responsibleHOD.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (responsibility.value == "Select Responsibility") ? kcDarkGreyColor : kcLightGrey),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down_sharp)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  Future<void> _buildResponsibilityBYHODDialog(List<EmployeeResponsibilityModel> responsibleHodModel) {
    final responsibilityListNotifier = responsibleHODySearchableListNotifier(responsibleHodModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Responsible HOD",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: responsibilityListNotifier.filterBasedOn,
                  decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      )),
                )
              ],
            ),
            content: SizedBox(
                width: 210,
                height: 800,
                child:ValueListenableBuilder<List<EmployeeResponsibilityModel>>(
                    valueListenable: responsibilityListNotifier,
                    builder: (context, responsibleList, widget){
                      return ListView.builder(
                          itemCount: responsibleList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    responsibleHOD.value = responsibleList[index].empName;
                                    responsibleHODCode = responsibleList[index].empUnqId;
                                    //filterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", responsibleHODCode, "");
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(responsibleList[index].empName,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.8,
                                    thickness: 1,
                                    color: kcDarkGreyColor,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                )
            ),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  //Priority

  Widget _buildPriority(){
    return  BlocConsumer<PriorityBloc, PriorityState>(
      bloc: priorityBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading6,
            content: _buildContent6,
            success: _buildContent6,
            failed: (form, __) => _buildContent6(form));
      },
    );
  }

  Widget _buildLoading6(List<PriorityModel> priorityModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent6(List<PriorityModel> priorityModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildPriorityDialog(priorityModel);
        },
        child: SizedBox(
          width: 180,
          height: 40,
          child: Container(
            //width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: priority,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Filter Priority" : priority.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (priority.value == "Filter Priority") ? kcDarkGreyColor : kcLightGrey),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down_sharp)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  Future<void> _buildPriorityDialog(List<PriorityModel> priorityModel) {
    final priorityListNotifier = PrioritySearchableListNotifier(priorityModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Prioroty",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: priorityListNotifier.filterBasedOn,
                  decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      )),
                )
              ],
            ),
            content: SizedBox(
                width: 210,
                height: 800,
                child:ValueListenableBuilder<List<PriorityModel>>(
                    valueListenable: priorityListNotifier,
                    builder: (context, list, widget){
                      return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    priority.value = list[index].priorityStatusName;
                                    priorityDesc.value = list[index].priorityStatusDeadline;
                                    priorityColor = list[index].priorityStatusColour;
                                    Navigator.pop(context);
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(list[index].priorityStatusName,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(list[index].priorityStatusDeadline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.8,
                                    thickness: 1,
                                    color: kcDarkGreyColor,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                )
            ),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  //location

  Widget _buildLocation(){
    return  BlocConsumer<LocationBloc, LocationState>(
      bloc: locationBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading7,
            content: _buildContent7,
            success: _buildContent7,
            failed: (form, __) => _buildContent7(form));
      },
    );
  }

  Widget _buildLoading7(List<LocationModel> locationModel){
    return const LoadingChip();
  }

  Widget _buildContent7(List<LocationModel> locationModel){
    return FilterDropdownChip(
      notifier: location,
      placeholder: "Filter Location",
      onTap: () => showObservationPicker<LocationModel>(
        context: context,
        title: "Select Location",
        items: locationModel,
        label: (m) => m.locations,
        filter: (m, q) => m.locations.toLowerCase().contains(q.toLowerCase()),
        onSelect: (m) => location.value = m.locations,
      ),
    );
  }

  Future<void> _buildLocationDialog(List<LocationModel> locationModel) {
    final locationListNotifier = LocationSearchableListNotifier(locationModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Location",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: locationListNotifier.filterBasedOn,
                  decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      )),
                )
              ],
            ),
            content: SizedBox(
                width: 210,
                height: 800,
                child:ValueListenableBuilder<List<LocationModel>>(
                    valueListenable: locationListNotifier,
                    builder: (context, list, widget){
                      return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    location.value = list[index].locations;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].locations,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.8,
                                    thickness: 1,
                                    color: kcDarkGreyColor,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                )
            ),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  //Hazard

  Widget _buildHazard(){
    return  BlocConsumer<AllHazardCatBloc, AllHazardCatState>(
      bloc: allHazardCatBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading8,
            content: _buildContent8,
            success: _buildContent8,
            failed: (form, __) => _buildContent8(form));
      },
    );
  }

  Widget _buildLoading8(List<AllHazardCatModel> hazardModel){
    return const LoadingChip();
  }

  Widget _buildContent8(List<AllHazardCatModel> hazardModel){
    return FilterDropdownChip(
      notifier: hazard,
      placeholder: "Filter Hazard",
      onTap: () => showObservationPicker<AllHazardCatModel>(
        context: context,
        title: "Select Hazard",
        items: hazardModel,
        label: (m) => m.hazardCategoryName,
        filter: (m, q) =>
            m.hazardCategoryName.toLowerCase().contains(q.toLowerCase()),
        onSelect: (m) => hazard.value = m.hazardCategoryName,
      ),
    );
  }

  Future<void> _buildHazardDialog(List<AllHazardCatModel> hazardModel) {
    final hazardListNotifier = HazardSearchableListNotifier(hazardModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Hazard Category",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: hazardListNotifier.filterBasedOn,
                  decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      )),
                )
              ],
            ),
            content: SizedBox(
                width: 210,
                height: 800,
                child:ValueListenableBuilder<List<AllHazardCatModel>>(
                    valueListenable: hazardListNotifier,
                    builder: (context, list, widget){
                      return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    hazard.value = list[index].hazardCategoryName;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].hazardCategoryName,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.8,
                                    thickness: 1,
                                    color: kcDarkGreyColor,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                )
            ),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

}

class SearchableListNotifier extends ValueNotifier<List<AllPlantModel>> {
  SearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllPlantModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.deptName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class departmentSearchableListNotifier extends ValueNotifier<List<AllDepartmentModel>> {

  departmentSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllDepartmentModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.statName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }

}

class responsibilitySearchableListNotifier extends ValueNotifier<List<EmployeeResponsibilityModel>> {

  responsibilitySearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<EmployeeResponsibilityModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.empName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class responsibleHODySearchableListNotifier extends ValueNotifier<List<EmployeeResponsibilityModel>> {

  responsibleHODySearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<EmployeeResponsibilityModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.empName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class WorkGroupSearchableListNotifier extends ValueNotifier<List<AllWorkGroupModel>> {

  WorkGroupSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllWorkGroupModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.wrkGrp.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class PrioritySearchableListNotifier extends ValueNotifier<List<PriorityModel>> {

  PrioritySearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<PriorityModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.priorityStatusName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class LocationSearchableListNotifier extends ValueNotifier<List<LocationModel>> {

  LocationSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<LocationModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.locations.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class HazardSearchableListNotifier extends ValueNotifier<List<AllHazardCatModel>> {

  HazardSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllHazardCatModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.hazardCategoryName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class HazardTypeSearchableListNotifier extends ValueNotifier<List<AllTypeHazardModel>> {

  HazardTypeSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllTypeHazardModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.categoryName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class UniqueIdSearchableListNotifier extends ValueNotifier<List<UniqueIdModel>> {

  UniqueIdSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<UniqueIdModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.uniqueIdentificationNumber.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}