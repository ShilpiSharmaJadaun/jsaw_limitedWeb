import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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

  TextEditingController remarkController = TextEditingController();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      trackVisibility: true,
      thumbVisibility: true,
      controller: _horizontalController,
      scrollbarOrientation: ScrollbarOrientation.bottom,
      child: Scaffold(
        body: _buildDataTableBody(),
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
    // print(model.length);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: AlwaysScrollableScrollPhysics(),
      controller: _horizontalController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: model.totalItems != 0 && currentPage > 0 ? _previousPage : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcvoilet,
                    foregroundColor: kcWhite,
                    disabledBackgroundColor: kcVeryLightGrey,
                    disabledForegroundColor: kcLightGrey,
                    elevation: 0,
                    fixedSize: const Size(140, 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  icon: const Icon(Icons.chevron_left, size: 18),
                  label: const Text("Previous"),
                ),
                Text(
                  model.totalItems == 0
                      ? "No records"
                      : "Page $currentPage of ${model.totalPages}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: kcValueDark,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4F4DD),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: IconButton(
                        tooltip: 'Refresh',
                        onPressed: () {
                          setState(() {
                            currentPage = 0;
                          });
                          allFilterObservationBloc.initState(0, "", "", "", "", "", "COMPLIANCE", "", "", "", "", "");
                        },
                        icon: Icon(Icons.refresh, color: kcStatGreen),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        uniqueIdBloc.initState();
                        openFilterDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kcvoilet,
                        foregroundColor: kcWhite,
                        fixedSize: const Size(120, 40),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      icon: const Icon(Icons.filter_alt_outlined, size: 18),
                      label: const Text("Filter"),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: model.totalItems != 0 && currentPage < model.totalPages
                          ? _nextPage
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kcvoilet,
                        foregroundColor: kcWhite,
                        disabledBackgroundColor: kcVeryLightGrey,
                        disabledForegroundColor: kcLightGrey,
                        elevation: 0,
                        fixedSize: const Size(140, 40),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      icon: const Icon(Icons.chevron_right, size: 18),
                      label: const Text("Next"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: kcVeryLightGrey),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 1200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildUpdate(model),
                  _buildReject(model),
                ],
              ),
            ),
          ),
          ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(overscroll: false),
            child: Scrollbar(
              controller: _horizontalController,
              thumbVisibility: true,
              child: SizedBox(
                width: 2800,
                //   color: Colors.grey,
                child: Row(
                  children: [
                    _buildTableHeaderContainer("Raised by",170),
                    _buildTableHeaderContainer("Unique ID",170),
                    _buildTableHeaderContainer("Date",170),
                    _buildTableHeaderContainer("Plant/ Dept",170),
                    _buildTableHeaderContainer("Responsibility",170),
                    _buildTableHeaderContainer("Responsible HOD",170),
                    _buildTableHeaderContainer("Location",170),
                    _buildTableHeaderContainer("Hazard",170),
                    _buildTableHeaderContainer("Target Date",170),
                    _buildTableHeaderContainer("Current Status",170),
                    _buildTableHeaderContainer("Observation",170),
                    _buildTableHeaderContainer("Approve/ Reject",170),
                    _buildTableHeaderContainer("Image",100),
                    _buildTableHeaderContainer("Remark",170),
                    // _buildTableHeaderContainer("Compliance",170),
                    // _buildTableHeaderContainer("Action Taken",170),
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
                          _buildTableBodyContainer(model.model[index].observationRaisedBy.toString(),200),
                          _buildTableBodyContainer(model.model[index].uniqueIdentificationNumber.toString(),200),
                          _buildTableBodyContainer(model.model[index].raisedDate.toString(),200),
                          _buildTableBodyContainer(model.model[index].plantDept.toString(),200),
                          _buildTableBodyContainer(model.model[index].responsibility.toString(),200),
                          _buildTableBodyContainer(model.model[index].responsibilityHODName.toString(),200),
                          _buildTableBodyContainer(model.model[index].location.toString(),200),
                          _buildTableBodyContainer(model.model[index].hazardCategory.toString(),200),
                          _buildTableBodyContainer(model.model[index].observationCompletionTargetDate.toString(),200),
                          _buildTableBodyContainer(model.model[index].status.toString(),200),
                          _buildTableBodyContainer(model.model[index].observationText.toString(),200),
                          _buildApproveRejectBodyContainer(model, index),
                          _buildImageContainer(model,index),
                          _buildRemarkContainer(),
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
    );

  }

  _buildTableHeaderContainer(String title,double width) {
    return Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width:2),
          color: navyBlue
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(title,
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold,color: kcWhite),),
        ),),);
  }

  _buildTableBodyContainer(String title, double width) {
    return Container(
      width: 200,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
          border: Border.all(color: Colors.black, width: .5)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(title,
          maxLines: 2,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),),
      ),);
  }

  _buildApproveRejectBodyContainer(AllFilterObservationModel model, int index) {
    return Container(
      width: 200,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: Center(
        child: Checkbox(
          value: selectedIndices.contains(index),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                selectedIndices.add(index);
              } else {
                selectedIndices.remove(index);
              }
            });
          },
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
        "remarks": remarkController.text,
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
        return isLoading
            ? const Center(child: CircularProgressIndicator())  // Show loader while updating
            : ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: kcobservationgreen),
          onPressed: () async {
            if (selectedIndices.isEmpty) return;

            setState(() {
              isLoading = true;  // Start loading before updates
            });

            final selectedData = selectedIndices.map((index) {
              return {
                "uniqueIdentificationNumber": model.model[index].uniqueIdentificationNumber.toString(),
                "observationText": model.model[index].observationText.toString(),
                "actionTaken": model.model[index].actionTaken.toString(),
                "status": "CLOSED",
                "remarks": remarkController.text,
                "updatedByEmpId": html.window.localStorage.getItem('kEmployeeCode')!,
                "updatedByEmpName": html.window.localStorage.getItem('kEmployeename')!,
                "updatedByEmail": html.window.localStorage.getItem('kUserEmail')!,
                "raisedByEmpID": model.model[index].observationRaisedByEmpUnqId.toString(),
                "imgURL": model.model[index].imageCompliance
              };
            }).toList();

            // Track last update for proper loading management
            for (int i = 0; i < selectedData.length; i++) {
              isLastUpdate = (i == selectedData.length - 1); // Flag last request
              await complainceApproveRejectBloc.updateObservation(selectedData[i]);
            }
          },
          child: const Text("Update", style: TextStyle(color: kcWhite)),
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
        return state.maybeWhen(
          loading: (_) {
            return const Center(child: CircularProgressIndicator());
          },
          orElse: () {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: kcRed),
              onPressed: () async {
                final selectedData = selectedIndices.map((index) {
                  return {
                    "uniqueIdentificationNumber": model.model[index].uniqueIdentificationNumber.toString(),
                    "observationText": model.model[index].observationText.toString(),
                    "actionTaken": model.model[index].actionTaken.toString(),
                    "status": "IN PROGRESS",
                    "remarks": remarkController.text,
                    "updatedByEmpId": html.window.localStorage.getItem('kEmployeeCode')!,
                    "updatedByEmpName": html.window.localStorage.getItem('kEmployeename')!,
                    "updatedByEmail": html.window.localStorage.getItem('kUserEmail')!,
                    "raisedByEmpID": model.model[index].observationRaisedByEmpUnqId.toString(),
                    "imgURL": model.model[index].imageCompliance
                  };
                }).toList();

                // Pass the selected data to the bloc or API
                await Future.forEach(selectedData, (data) async {
                  await complainceApproveRejectBloc.updateObservation(data);
                });

                // Clear selections
                setState(() {
                  selectedIndices.clear();
                });
              },
              child: const Text("Reject", style: TextStyle(color: kcWhite),),
            );
          },
        );
      },
    );
  }

  _buildImageContainer(AllFilterObservationModel model, int index){
    return Container(
      width: 200,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: .5)
      ),
      child: Column(
        children: [
          IconButton(onPressed: (){
            _showImageComparisonDialog(context, model, index);
          }, icon: Image.asset("assets/images/compareimage.png", scale: 30,)),
          const Text("Compare Image", style: TextStyle(fontSize: 12),),
        ],
      ),
    );
  }

  _buildRemarkContainer(){
    return  SizedBox(
      width: 200,
      height: 60,
      child: TextFormField(
        maxLines: 10,
        controller: remarkController,
        decoration: InputDecoration(
          hintText: "Enter Remark",
          border: _border(),
          errorBorder: _border(),
        ),
      ),
    );
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
                      child: Image.network(
                        model.model[index].imageNumber, // Replace with your second image URL or AssetImage
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
                        model.model[index].imageCompliance, // Replace with your first image URL or AssetImage
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
      // borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: kcBlack));

  Future<void> openFilterDialog() async {
    final employeeCode = window.localStorage.getItem('kEmployeeCode') ?? "";  // Retrieve value before dialog
    await _buildFilterDialog(context, employeeCode);  // Pass employeeCode to the dialog
  }

  Future<void> _buildFilterDialog(BuildContext dialogContext, String employeeCode) {
    return showDialog(
        context: dialogContext,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            contentPadding: const EdgeInsets.all(8.0),
            content: SizedBox(
              height: 600,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("SELECT FILTERS", style: TextStyle(fontWeight: FontWeight.bold),),
                  _buildDateRangeContainer("Start Date", startDateInput),
                  _buildDateRangeContainer("End Date", endDateInput),
                  _buildPlant(),
                  _buildDepartment(),
                  _buildStatusContent(statusList),
                  _buildLocation(),
                  _buildHazard(),
                  _buildUniqueId()
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  clearFormValues();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: kcRed),
                child: const Text("Cancel", style: TextStyle(color: kcWhite),),
              ),
              ElevatedButton(
                onPressed: () {
                  allFilterObservationBloc.initState(0,statCode, fromDateInput.text, endDateInput.text, location.value, departCode, "COMPLIANCE", hazard.value, "", '',"", uniqueId.value);
                  html.window.localStorage.removeItem('ksessionID');
                  startDateInput.clear();
                  endDateInput.clear();
                  clearFormValues();
                  Navigator.of(dialogContext).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: kcobservationgreen),
                child: const Text("Apply Filters", style: TextStyle(color: kcWhite),),
              ),
            ],
          );
        });
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
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildStatusDialog(statusList);  // Call the status dialog
        },
        child: SizedBox(
          width: 180,
          height: 40,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: priority, // Assuming priority stores the selected status
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        value.isEmpty ? "Filter Status" : priority.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (priority.value == "Filter Status") ? kcDarkGreyColor : kcLightGrey),
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
    return const CircularProgressIndicator();
  }

  Widget _buildContent1(List<AllPlantModel> model){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: (){
          _buildallPlantListDialog(model);
        },
        child: SizedBox(
          width: 200,
          height: 40,
          child: Container(
            // width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: plant,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 100,
                      child: Text(
                        value.isEmpty ? "Select Plant" : plant.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (plant.value == "Select Plant") ? kcDarkGreyColor : kcLightGrey),
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
    return const CircularProgressIndicator();
  }

  Widget _buildUNiqueIdContent(List<UniqueIdModel> uniqueIdModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          uniqueIdBloc.initState();
          _buildUniqueIdDialog(uniqueIdModel);
        },
        child: SizedBox(
          width: 200,
          height: 40,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: uniqueId,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Unique Id" : uniqueId.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (uniqueId.value == "Select Unique Id") ? kcDarkGreyColor : kcLightGrey),
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
    return const CircularProgressIndicator();
  }

  Widget _buildContent4(List<AllDepartmentModel> departModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          if(departCode.isEmpty){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Select Plant")));
          }else{
            _buildallDepartDialog(departModel);
          }

        },
        child: SizedBox(
          width: 200,
          height: 40,
          child: Container(
            // width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: stat,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 100,
                      child: Text(
                        value.isEmpty ? "Select Department" : stat.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (stat.value == "Select Department") ? kcDarkGreyColor : kcLightGrey),
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
    return const CircularProgressIndicator();
  }

  Widget _buildContent7(List<LocationModel> locationModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildLocationDialog(locationModel);
        },
        child: SizedBox(
          width: 200,
          height: 40,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: location,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Location" : location.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (location.value == "Select Location") ? kcDarkGreyColor : kcLightGrey),
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
    return const CircularProgressIndicator();
  }

  Widget _buildContent8(List<AllHazardCatModel> hazardModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildHazardDialog(hazardModel);
        },
        child: SizedBox(
          width: 200,
          height: 40,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: hazard,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Hazard" : hazard.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (hazard.value == "Select Hazard") ? kcDarkGreyColor : kcLightGrey),
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