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
        return  Card(
            color: kcWhite,
            elevation: 8,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.network(
                      alignment: Alignment.center,
                      model[index].imageCompliance,
                      //fit: BoxFit.cover,
                      scale: 30,
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
                            Container(
                              width: 300,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildHeadingText("Date :"),
                                  _buildTextBox(model[index].updatedDate, kcRed),
                                ],
                              ),
                            ),
                            Container(
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
                            Container(
                              width: 300,
                              child: Row(
                                children: [
                                  _buildHeadingText("Action Taken By :"),
                                  _buildTextBox(model[index].updatedByEmpName, kcRed),
                                ],
                              ),
                            )

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
                            width: 1500,
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
                                model[index].observationText,
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

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF' + hexString;
    }
    return Color(int.parse(hexString, radix: 16));
  }

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
              child: Container(
                width: 200,
                height: 200,
                child: Image.network(
                  alignment: Alignment.center,
                 widget.model.imageCompliance,
                  fit: BoxFit.cover,
                  //scale: 12 ,
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
                            _buildTextBox(widget.model.observationRaisedByEmpUnqId.toString(), kcDarkGreyColor),
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
                          _buildTextBox(widget.model.raisedDate.toString(), kcRed)
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset("assets/images/plant.png", scale: 20),
                          _buildHeadingText("Plant / Dept :"),
                          _buildTextBox(widget.model.plantDept.toString(), kcDarkGreyColor),
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
                            _buildTextBox(widget.model.plantDept.toString(), kcDarkGreyColor),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/responsibility.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Responsibility"),
                            _buildTextBox(widget.model.responsibility.toString(), kcDarkGreyColor),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/location.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Location :"),
                            _buildTextBox(widget.model.location.toString(), kcDarkGreyColor),
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
                            _buildTextBox(widget.model.responsibilityHODName.toString(), kcDarkGreyColor),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/observation.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Priority"),
                            _buildTextBox(widget.model.priorityStatusName.toString(), kcDarkGreyColor),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/location.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Hazard :"),
                            _buildTextBox(widget.model.hazardCategory.toString(), kcDarkGreyColor),
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
                Container(
                  width: 800,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                       //  width: 400,
                        child: Row(
                          children: [
                            _buildHeadingText("Current Status :"),
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
                                    widget.model.status,
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
                                  left: 1,
                                  right: 1),
                              child: Text(
                                widget.model.observationCompletionTargetDate,
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
                                widget.model.complianceDate,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/observation.png",
                      scale: 20,
                    ),
                    _buildHeadingText("Observations :"),
                    SizedBox(
                     // width: 200,
                      child: Padding(
                        padding:
                        const EdgeInsets.all(5),
                        child: Text(
                          widget.model.observationText.toString(),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 1000,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeadingText("Remark :"),
                            Container(
                              width: 500,
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  maxLines: 10,
                                  controller: remarkController,
                                  decoration: InputDecoration(
                                    hintText: "Enter Remark",
                                    border: _border(),
                                    errorBorder: _border(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildReject(),
                            _buildUpdate(),

                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              // width: 150,
                              // height: 100,
                              child: Column(
                                children: [
                                  IconButton(onPressed: (){
                                    _showImageComparisonDialog(context);
                                  }, icon: Image.asset("assets/images/compareimage.png", scale: 10,)),
                                  const Text("Compare Image"),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));

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