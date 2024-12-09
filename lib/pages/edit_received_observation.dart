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
        return  Card(
            color: kcWhite,
            elevation: 8,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 60.screenWidth,
                    height: 20.screenHeight,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.network(
                        alignment: Alignment.center,
                        model[index].imageCompliance,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 1000,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 500,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildHeadingText2("Date :"),
                                  _buildTextBox2(model[index].updatedDate, kcRed),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: 500,
                              child: Row(
                                children: [
                                  _buildHeadingText2("Action Taken By :"),
                                  _buildTextBox2(model[index].updatedByEmpName, kcRed),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            _buildHeadingText("Status :"),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 8.0, right: 8),
                              child: Container(
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
                                      left: 1,
                                      right: 1),
                                  child: Text(
                                    model[index].status,
                                    style:  const TextStyle(
                                        color: kcWhite,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
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
                                scale: 18,
                              ),
                              _buildHeadingText("Observations :"),
                            ],
                          ),
                          SizedBox(
                            width: 1000,
                            child: Padding(
                              padding:
                              const EdgeInsets.all(1.0),
                              child: Text(
                                model[index].observationText,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
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
                              _buildHeadingText(
                                  "Action Taken"),
                            ],
                          ),
                          SizedBox(
                            width: 1000,
                            child: Padding(
                              padding:
                              const EdgeInsets.all(10),
                              child: Text(
                                model[index].actionTaken,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
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
                              _buildHeadingText(
                                  "Remark"),
                            ],
                          ),
                          SizedBox(
                            width: 1000,
                            child: Padding(
                              padding:
                              const EdgeInsets.all(10),
                              child: Text(
                                model[index].remarks,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ));},);
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
    return Card(
        color: kcWhite,
        elevation: 8,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 30.screenWidth,
                height: 10.screenHeight,
                child: Image.network(
                  widget.imageNumber,
                  fit: BoxFit.contain,

                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 1000,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/raisedby.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Raised By :"),
                            _buildTextBox(widget.raisedBy.toString(), kcDarkGreyColor),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/date.png",
                            scale: 20,
                          ),
                          _buildHeadingText("Date :"),
                          _buildTextBox(widget.raisedDate.toString(), kcRed)
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset("assets/images/plant.png", scale: 20),
                          _buildHeadingText("Plant / Dept :"),
                          _buildTextBox(widget.plant.toString(), kcDarkGreyColor),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 1000,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/uniqueid.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Department : "),
                            _buildTextBox(widget.department.toString(), kcDarkGreyColor),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/responsibility.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Responsibility"),
                            _buildTextBox(widget.responsibility.toString(), kcDarkGreyColor),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/location.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Location :"),
                            _buildTextBox(widget.location.toString(), kcDarkGreyColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 1000,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/responsibility.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Res.HOD : "),
                            _buildTextBox(widget.resHod.toString(), kcDarkGreyColor),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/observation.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Priority"),
                            _buildTextBox(widget.priority.toString(), kcDarkGreyColor),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/location.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Hazard :"),
                            _buildTextBox(widget.hazard.toString(), kcDarkGreyColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Container(
                        height: 2,
                        alignment: Alignment.center,
                        color: kcVeryLightGrey,
                        width: 1000,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 1000,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/observation.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Corrective Measures :"),
                            SizedBox(
                              width: 800,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(5),
                                child: Text(
                                  widget.correctiveMeasures.toString(),
                                  maxLines: 8,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 1000,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/observation.png",
                                    scale: 20,
                                  ),
                                  _buildHeadingText("Observations :"),
                                  SizedBox(
                                    width: 400,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(5),
                                      child: Text(
                                        widget.observation.toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.black),
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5,
                                          right: 5),
                                      child: Text(
                                        widget.targetDate,
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

                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 1,
                                          right: 1),
                                      child: Text(
                                        widget.complianceDate,
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
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                  onPressed: (priorityStatus == "IN PROGRESS"
                                      // || priorityStatus == "PENDING"
                                  )
                                      ? () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                      ),
                                      builder: (context) => CompliancePageBottomSheet(
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
                                      backgroundColor: navyBlue
                                  ),
                                  child: Text(
                                    priorityStatus == "CLOSED" || priorityStatus == "COMPLIANCE" ? "COMPLIANCE SENT" : "Send Compliance",
                                    style: TextStyle(
                                      color: priorityStatus == "CLOSED"
                                          ? Colors.black // Color for "PENDING"
                                          : priorityStatus == "COMPLIANCE"
                                          ? Colors.black  // Color for "IN PROGRESS"
                                          : kcWhite,  ),
                                  )),
                            ),
                            _buildUpdate(widget.status)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));

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