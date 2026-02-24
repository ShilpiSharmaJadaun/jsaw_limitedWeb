import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/deleteObservation_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:html';
import 'dart:html' as html;
import '../bloc/allDepart_bloc.dart';
import '../bloc/all_filter_observation_bloc.dart';
import '../bloc/allhazard_cat_bloc.dart';
import '../bloc/allplant_bloc.dart';
import '../bloc/alltype_hazard_bloc.dart';
import '../bloc/employeeResponsibility_bloc.dart';
import '../bloc/filterObservation_bloc.dart';
import '../bloc/location_bloc.dart';
import '../bloc/observationby_uni_bloc.dart';
import '../bloc/priority_bloc.dart';
import '../bloc/raisedObservationBloc.dart';
import '../bloc/responsibleHod_bloc.dart';
import '../bloc/save_observation_bloc.dart';
import '../bloc/uniqueId_bloc.dart';
import '../model/allDepartment_model.dart';
import '../model/all_filter_observation_model.dart';
import '../model/allhazard_cat_model.dart';
import '../model/allplant_model.dart';
import '../model/alltype_hazard_model.dart';
import '../model/allwork_group_model.dart';
import '../model/employeeResponsibility_model.dart';
import '../model/location_model.dart';
import '../model/priority_model.dart';
import '../model/uniqueId_model.dart';
import '../service/dashboard_service.dart';
import '../service/observation_service.dart';
import '../state/allDepart_state.dart';
import '../state/all_filter_observation_state.dart';
import '../state/allhazard_cat_state.dart';
import '../state/allplant_state.dart';
import '../state/employeeResponsibility_state.dart';
import '../state/location_state.dart';
import '../state/priority_state.dart';
import '../state/responsibleHOD_state.dart';
import '../state/uniqueId_state.dart';
import '../utils/app_color.dart';
import 'edit_raised_observations_page.dart';

class HseEditObservationPage extends StatefulWidget {
  const HseEditObservationPage({super.key});

  @override
  State<HseEditObservationPage> createState() => _HseEditObservationPageState();
}

class _HseEditObservationPageState extends State<HseEditObservationPage> {


  late final RaisedObservationBloc raisedObservationBloc;

  late final FilterObservationBloc filterObservationBloc;

  late final ObservationbyUniBloc observationbyUniBloc;

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

  late final DeleteObservationBloc deleteObservationBloc;


  ValueNotifier<String> workGroup = ValueNotifier("Select Work Group");
  ValueNotifier<String> plant = ValueNotifier("Filter Plant");
  ValueNotifier<String> stat = ValueNotifier("Filter Department");
  ValueNotifier<String> responsibility = ValueNotifier("Filter Responsibility");
  ValueNotifier<String> responsibleHOD = ValueNotifier("Filter Responsible HOD");
  ValueNotifier<String> priority = ValueNotifier("");
  ValueNotifier<String> priorityDesc = ValueNotifier("Deadline");
  ValueNotifier<String> location = ValueNotifier("");
  ValueNotifier<String> hazard = ValueNotifier("");
  ValueNotifier<String> uniqueId = ValueNotifier("");
  ValueNotifier<String> hazardType = ValueNotifier("Select Hazard Type");
  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController fromDateInput = TextEditingController();

  late String employeeName;
  late String employeeCode;
  late String raisedSessionID = window.localStorage['kRaisedSessionID'] ?? "";
  late String statCode = "";
  late String departCode = "";
  late String responsibleCode;
  late String responsibleHODCode;
  late String priorityColor = "";
  late String status = "";
  late String responsibleEnggDesignationCode = "";

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<String> statusList = ['PENDING', 'CLOSED', 'IN PROGRESS', 'COMPLIANCE'];

  int currentPage = 0;
  // int intialCurrentPage = 0;

  final int itemsPerPage = 10;

  late final UniqueIdBloc uniqueIdBloc;

  @override
  void initState() {
    super.initState();
    final observationService = Provider.of<ObservationService>(context, listen: false);
    final dashboardService = Provider.of<DashboardService>(context, listen: false);
    //allObservationBloc = AllObservationBloc(observationService);
    filterObservationBloc= FilterObservationBloc(observationService);
    deleteObservationBloc = DeleteObservationBloc(observationService);
    // allObservationBloc.initState();
    //filterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", "", window.localStorage['kEmployeeCode'] ?? "");
    allPlantBloc = AllPlantBloc(observationService);
    allPlantBloc.initState();
    allFilterObservationBloc = AllFilterObservationBloc(observationService);
    allFilterObservationBloc.initState(currentPage, "", "", "", "", "", "PENDING", "", "", "", "", "");
    allDepartBloc = AllDepartBloc(observationService);
    employeeResponsibilityBloc = EmployeeResponsibilityBloc(observationService);
    employeeName = window.localStorage['kEmployeename'] ?? "";
    employeeCode = window.localStorage['kEmployeeCode'] ?? "";
    priorityBloc = PriorityBloc(observationService);
    priorityBloc.initState();
    locationBloc = LocationBloc(observationService);
    allHazardCatBloc = AllHazardCatBloc(dashboardService);
    allHazardCatBloc.initState();
    allTypeHazardBloc = AllTypeHazardBloc(observationService);
    allTypeHazardBloc.initState();
    saveObservationBloc = SaveObservationBloc(observationService);
    responsibleHODBloc = ResponsibleHODBloc(observationService);
    uniqueIdBloc = UniqueIdBloc(observationService);
    startDateInput.text = "";
    endDateInput.text = "";
    fromDateInput.text = "";}

  void _nextPage() {
    setState(() {
      currentPage++;
      allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "PENDING", "", "", "",raisedSessionID,"");
    });
  }

  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
        allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "PENDING", "", "", "",raisedSessionID,"");
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildObservation(),
    );
  }

  _buildObservation() {
    return BlocConsumer<AllFilterObservationBloc, AllFilterObservationState>(
      bloc: allFilterObservationBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: (_){return Center(child: Lottie.asset("assets/lottie/loading.json",height: 80, width: 80 ));},
            content: _buildContent,
            success: _buildContent,
            failed: (form, __) => _buildContent(form));
      },
    );
  }

  Widget _buildContent(AllFilterObservationModel model) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                uniqueIdBloc.initState();
                openFilterDialog();
              },
                  style: ElevatedButton.styleFrom(backgroundColor: kcRed, fixedSize: const Size(300, 40)),
                  child: const Text("Filter", style: TextStyle(color: kcWhite),)),
              TextButton(onPressed: (){
                setState(() {
                  currentPage = 0;
                });

                allFilterObservationBloc.initState(0,"", "", "", "", "", "PENDING", "", "", "","","");
              }, child: const Row(
                children: [
                  Text("Refresh"),
                  Icon(Icons.refresh)
                ],
              ))
            ],
          ),
        ),
        const Divider(),
        if(model.totalItems != 0)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if(currentPage < model.totalPages)
                  ElevatedButton(onPressed: _previousPage, child: const Text("Previous", style: TextStyle(fontWeight: FontWeight.w600, color: kcWhite),), style: ElevatedButton.styleFrom(backgroundColor: kcmegenta),),
                Row(
                  children: [
                    Text("Page $currentPage"),
                    Text(" Out of Total Pages " + model.totalPages.toString()),
                  ],
                ),
                if(currentPage < model.totalPages)
                  ElevatedButton(onPressed: _nextPage, child: Text("Next", style: TextStyle(fontWeight: FontWeight.w600, color: kcWhite),), style: ElevatedButton.styleFrom(backgroundColor: kcmegenta)),
              ],
            ),
          ),

        ///sliver list, lazy loading
        Expanded(
          child: ListView.builder(
              itemCount: model.model.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    color: kcWhite,
                    elevation: 8,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 40.screenWidth,
                                  height: 20.screenHeight,
                                  child: FadeInImage(
                                    placeholder: NetworkImage(model.model[index].lowQualityImageUrl), // Low-quality image
                                    image: NetworkImage(model.model[index].imageNumber), // High-quality image
                                    fadeInDuration: const Duration(milliseconds: 300), // Fade duration for transition
                                    fadeOutDuration: const Duration(milliseconds: 300), // Fade out duration for the placeholder
                                    fit: BoxFit.cover, // Image fit mode
                                    imageErrorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error); // Handle any error loading the image
                                    },
                                  ),

                                  // child:CachedNetworkImage(
                                  //   imageUrl: 'https://cors-anywhere.herokuapp.com'+model.model[index].imageNumber,
                                  //   placeholder: (context, url) => Image.network(
                                  //     model.model[index].lowQualityImageUrl,  // Display low-quality image as a placeholder
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                                  //   fit: BoxFit.cover,
                                  // )
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(onPressed: (){
                                    _showDeleteDialog(context, model.model[index].uniqueIdentificationNumber, employeeCode);

                                  },
                                      style: ElevatedButton.styleFrom(backgroundColor: kcRed,),
                                      child: const Text("Delete Observation", style: TextStyle(color: kcWhite),)),
                                )
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100.screenWidth,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/raisedby.png",
                                                  scale: 20,
                                                ),
                                                _buildHeadingText(
                                                    "Observation Raised By :"),
                                              ],
                                            ),
                                            _buildTextBox(
                                                model.model[index].observationRaisedBy,
                                                kcDarkGreyColor),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/plant.png",
                                                  scale: 20,
                                                ),
                                                _buildHeadingText(
                                                    "Plant / Dept :"),
                                              ],
                                            ),
                                            _buildTextBox(model.model[index].plantDept,
                                                Colors.black)
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/uniqueid.png",
                                                  scale: 20,
                                                ),
                                                _buildHeadingText(
                                                    "Unique ID No. :"),
                                              ],
                                            ),
                                            _buildTextBox(
                                                model.model[index]
                                                    .uniqueIdentificationNumber,
                                                kcDarkGreyColor),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/location.png",
                                                  scale: 20,
                                                ),
                                                _buildHeadingText("Location :"),
                                              ],
                                            ),
                                            _buildTextBox(model.model[index].location,
                                                Colors.black)
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/date.png",
                                                  scale: 20,
                                                ),
                                                _buildHeadingText("Date :"),
                                              ],
                                            ),
                                            _buildTextBox(
                                                model.model[index].raisedDate, kcRed)
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/responsibility.png",
                                                  scale: 20,
                                                ),
                                                _buildHeadingText(
                                                    "Responsibility"),
                                              ],
                                            ),
                                            _buildTextBox(
                                                model.model[index].responsibility,
                                                kcmegenta)
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                  child: Container(
                                    height: 2,
                                    alignment: Alignment.center,
                                    color: kcVeryLightGrey,
                                    width: 800,
                                  )),
                              SizedBox(
                                width: 600,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/suggestions.png",
                                              scale: 20,
                                            ),
                                            _buildHeadingText("Status :"),
                                          ],
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 2.0,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                                )
                                              ],
                                              color: kcRed),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5,
                                                right: 5),
                                            child: Text(
                                              model.model[index].status,
                                              style:  const TextStyle(
                                                  color: kcWhite,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/observation.png",
                                              scale: 20,
                                            ),
                                            _buildHeadingText("Priority :"),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black,
                                                    blurRadius: 2.0,
                                                    spreadRadius: 0.0,
                                                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                                  )
                                                ],
                                                color: hexToColor(model.model[index].priorityStatusColour,
                                                )),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 1.screenWidth,
                                                  right: 1.screenWidth),
                                              child: Text(
                                                model.model[index].priorityStatusName,
                                                style: const TextStyle(
                                                    color: kcWhite,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 600,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/tagetdate.png",
                                              scale: 20,
                                            ),
                                            _buildHeadingText("Target Date :"),
                                          ],
                                        ),
                                        Container(
                                          width: 150,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 1,
                                                right: 1),
                                            child: Text(
                                              model.model[index].observationCompletionTargetDate,
                                              style:  const TextStyle(
                                                  color: kcBlack,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/tagetdate.png",
                                              scale: 20,
                                            ),
                                            _buildHeadingText("Compliance Date :"),
                                          ],
                                        ),
                                        Container(
                                          width: 120,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 1,
                                                right: 1),
                                            child: Text(
                                              model.model[index].complianceDate,
                                              style:  const TextStyle(
                                                  color: kcBlack,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/observation.png",
                                        scale: 20,
                                      ),
                                      _buildHeadingText("Observations :"),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 500,
                                    child: Padding(
                                      padding:
                                      EdgeInsets.all(1.0.screenWidth),
                                      child: Text(
                                        model.model[index].observationText,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 2.screenWidth,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/suggestions.png",
                                        scale: 20,
                                      ),
                                      _buildHeadingText("Corrective Measure:"),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 500,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        model.model[index].correctiveMeasure,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async{
                                        final shouldInit = await Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => EditRaisedObservationsPage(filterObservationModel: model.model[index],),
                                              fullscreenDialog: true),
                                        );
                                        if(shouldInit != null && shouldInit) {
                                          allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "PENDING", "", "", "", "","");
                                        }
                                      },
                                      icon: const Icon(
                                          Icons.arrow_forward_ios_sharp)),

                                ],
                              ),

                            ],
                          ),
                        ],
                      ),
                    ));
              }),
        ),
      ],
    );
  }

  ///Delete Observation

  void _showDeleteDialog(BuildContext context, uniqueIdentificationNumber, updatedByEmpId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this observation?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("No"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: kcRed),
              onPressed: () {
                _deleteObservation(uniqueIdentificationNumber, updatedByEmpId);
              },
              child: Text("Yes", style: TextStyle(color: kcWhite)),
            ),
          ],
        );
      },
    );
  }

  void _deleteObservation(String uniqueIdentificationNumber, String updatedByEmpId) async {
    final data = {'uniqueIdentificationNumber': uniqueIdentificationNumber, 'updatedByEmpId': updatedByEmpId};
    await deleteObservationBloc.deleteObservation(data);
    allFilterObservationBloc.initState(0,"", "", "", "", "", "PENDING", "", "", "","","");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Observation Deleted Successfully")));
    Navigator.of(context).pop(); // Close dialog
  }


  _buildHeadingText(String title) {
    return Padding(
      padding: EdgeInsets.all(1.screenWidth),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 2.2.screenWidth,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600),
      ),
    );
  }

  _buildTextBox(String title, Color color) {
    return Padding(
      padding: EdgeInsets.all(1.screenWidth),
      child: SizedBox(
        width: 30.screenWidth,
        height: 3.5.screenHeight,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: kcWhite,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 3.screenWidth,
                  right: 3.screenWidth,
                  top: 0.2.screenHeight,
                  bottom: 0.2.screenHeight),
              child: Text(
                title,
                maxLines: 4,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 2.screenWidth,
                    color: color),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }

  Future<void> openFilterDialog() async {
    final employeeCode = window.localStorage['kEmployeeCode'] ?? "";  // Retrieve value before dialog
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

                  allFilterObservationBloc.initState(0,statCode, fromDateInput.text, endDateInput.text, location.value,
                      departCode, "PENDING", "", "", "","",uniqueId.value);
                  setState(() {
                    currentPage = 0;
                  });
                  html.window.localStorage.remove('kRaisedSessionID');
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
    responsibleHOD.value = "D";
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


  _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 2, color: kcWhite));

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
          width: 250,
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
                        value.isEmpty ? "Select State" : stat.value,
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
                                    employeeResponsibilityBloc.initState(departCode, statCode, window.localStorage['kGradeCode']!);
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
                                    filterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", responsibleCode, "");
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
                                    filterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", responsibleHODCode, "");
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