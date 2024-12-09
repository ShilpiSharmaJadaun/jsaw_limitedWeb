import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../bloc/allDepart_bloc.dart';
import '../bloc/allhazard_cat_bloc.dart';
import '../bloc/allplant_bloc.dart';
import '../bloc/employeeResponsibility_bloc.dart';
import '../bloc/location_bloc.dart';
import '../bloc/observationby_uni_bloc.dart';
import '../bloc/priority_bloc.dart';
import '../bloc/update_observation_bloc.dart';
import '../model/observationby_uni_model.dart';
import '../service/dashboard_service.dart';
import '../service/observation_service.dart';
import '../state/observationby_uni_state.dart';
import '../utils/app_color.dart';
import '../utils/page_header.dart';

class EditAllObservationPage extends StatefulWidget {
  EditAllObservationPage({super.key,
    required this.uniqueId,
    required this.raisedBy,
    required this.wrkGrp,
    required this.stationName,
    required this.stateCode,
    required this.plant,
    this.department,
    this.responsibility,
    required this.location,
    required this.resHod,
    required this.priority,
    required this.hazard ,
    required this.observation,
    required this.name,
    required this.raisedDate ,
    required this.raisedByEmpID,
    required this.status,
    required this.correctiveMeasure,
     required this.image,
    required this.targetDate,
    required this.complianceDate,
  });
  final String? uniqueId; final String? raisedBy;
  final String? wrkGrp; final String? stationName;
  final String? stateCode;final String? plant;
  final String? department; final String? responsibility;
  final String location;final String resHod; final String priority;
  final String hazard; final String observation; final String name;
  final String raisedDate; final String raisedByEmpID; final String status;
  final String correctiveMeasure; final String image; final String targetDate;
  final String complianceDate;

  @override
  State<EditAllObservationPage> createState() => _EditAllObservationPageState();
}

class _EditAllObservationPageState extends State<EditAllObservationPage> {


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
    locationBloc.initState(widget.location.toString());

    updateObservationBloc = UpdateObservationBloc(observationService);
    allHazardCatBloc = AllHazardCatBloc(dashboardService);
    allHazardCatBloc.initState();

    priorityBloc = PriorityBloc(observationService);
    priorityBloc.initState();
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
            PageHeader("Observation Details"),
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
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        alignment: Alignment.center,
                        model[index].imageCompliance,
                        fit: BoxFit.cover,
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
                                  _buildHeadingText2("Updated Date :"),
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
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Image.asset(
                      //           "assets/images/observation.png",
                      //           scale: 18,
                      //         ),
                      //         _buildHeadingText("Observations :"),
                      //       ],
                      //     ),
                      //     SizedBox(
                      //       width: 1000,
                      //       child: Padding(
                      //         padding:
                      //         const EdgeInsets.all(1.0),
                      //         child: Text(
                      //           model[index].observationText,
                      //           maxLines: 3,
                      //           overflow: TextOverflow.ellipsis,
                      //           style: const TextStyle(
                      //               fontWeight: FontWeight.w400,
                      //               fontSize: 14,
                      //               color: Colors.black),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
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

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
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
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.network(
                  alignment: Alignment.center,
                  widget.image,
                  fit: BoxFit.contain,
                 // scale: 20 ,
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
                        width: 280,
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
                            _buildTextBox(widget.stationName.toString(), kcDarkGreyColor),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/responsibility.png",
                              scale: 20,
                            ),
                            _buildHeadingText("Responsibility"),
                            _buildTextBox(widget.name.toString(), kcDarkGreyColor),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 1000,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                  width: 600,
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
                            // Padding(
                            //   padding: const EdgeInsets.all(10.0),
                            //   child: ElevatedButton(onPressed: (){
                            //     Navigator.of(context).push(
                            //       MaterialPageRoute(builder: (context) => CompliancePage(UnqIdnNo:  widget.uniqueId.toString() , raisedByUnqID: widget.raisedByEmpID,), fullscreenDialog: true),
                            //     );
                            //   },
                            //       style: ElevatedButton.styleFrom(
                            //           fixedSize: Size(200, 30),
                            //           backgroundColor: navyBlue
                            //       ),
                            //       child: Text("Send Compliance", style: TextStyle(color: kcWhite),)),
                            // ),
                            // _buildUpdate()

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
                                Padding(
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
                          Image.asset(
                            "assets/images/observation.png",
                            scale: 20,
                          ),
                          _buildHeadingText("Corrective Measure :"),
                          SizedBox(
                            width: 600,
                            child: Padding(
                              padding:
                              const EdgeInsets.all(5),
                              child: Text(
                                widget.correctiveMeasure.toString(),
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
              ],
            ),
          ],
        ));

  }


  _buildHeadingText(String title){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 100,
        child: Text(title, style: const TextStyle( fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black),),
      ),
    );
  }

  _buildTextBox(String title, Color color){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.only(left: 3, right: 3),
        child: SizedBox(
          width: 120,
          child: Text(title,
            maxLines: 4,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: color),),
        ),
      ),
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

}


class ErrorPage extends StatelessWidget {
  final Exception error;

  ErrorPage({super.key, required this.error});

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