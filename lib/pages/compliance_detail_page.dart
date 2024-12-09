import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../bloc/allobservationTillDate_bloc.dart';
import '../model/allobservation_model.dart';
import '../service/observation_service.dart';
import '../state/allobservationTillDate_state.dart';
import '../utils/app_color.dart';
import 'edit_received_observation.dart';

class ComplianceDetailPage extends StatefulWidget {
  const ComplianceDetailPage({super.key});

  @override
  State<ComplianceDetailPage> createState() => _ComplianceDetailPageState();
}

class _ComplianceDetailPageState extends State<ComplianceDetailPage> {
  late final AllObservaionTillDateBloc allObservaionTillDateBloc;

  void initState() {
    super.initState();
    final observationService = Provider.of<ObservationService>(context, listen: false);
    allObservaionTillDateBloc = AllObservaionTillDateBloc(observationService);
    allObservaionTillDateBloc.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildObservation(),
    );
  }

  _buildObservation() {
    return BlocConsumer<AllObservaionTillDateBloc, AllObservaionTillDateState>(
      bloc: allObservaionTillDateBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: _buildLoading,
            content: _buildContent,
            success: _buildContent,
            failed: (form, __) => _buildContent(form));
      },
    );
  }

  Widget _buildLoading(List<AllObservationModel> model) {
    return const CircularProgressIndicator();
  }

  Widget _buildContent(List<AllObservationModel> model) {
    return Expanded(
      child: ListView.builder(
          itemCount: model.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                color: kcWhite,
                elevation: 8,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: SizedBox(
                          width: 230,
                          height: 200,
                          child: Image.network(
                            alignment: Alignment.center,
                            model[index].imageNumber,
                            //fit: BoxFi,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 850,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
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
                                        model[index].observationRaisedBy,
                                        kcDarkGreyColor),
                                  ],
                                ),
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
                                        model[index]
                                            .uniqueIdentificationNumber,
                                        kcDarkGreyColor),
                                  ],
                                ),
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
                                        model[index].raisedDate, kcRed)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 850,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
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
                                    _buildTextBox(model[index].plantDept,
                                        Colors.black)
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
                                    _buildTextBox(model[index].location,
                                        Colors.black)
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
                                        model[index].responsibility,
                                        kcmegenta)
                                  ],
                                ),
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
                                    model[index].observationText,
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
                                  _buildHeadingText("Action Taken"),
                                ],
                              ),
                              SizedBox(
                                width: 500,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    model[index].actionTaken,
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
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => EditReceivedObservationsPage(uniqueId: model[index].uniqueIdentificationNumber,
                                        raisedBy: model[index].observationRaisedByEmpUnqId,
                                        department: model[index].plantDept,
                                        responsibility: model[index].responsibility,
                                        location: model[index].location,
                                        resHod: model[index].responsibilityHODName,
                                        priority: model[index].priorityStatusName,
                                        hazard: model[index].hazardCategory,
                                        observation: model[index].observationText,
                                        name: model[index].observationRaisedBy,
                                        raisedDate: model[index].raisedDate,
                                        wrkGrp:model[index].wrkGrp, deptCode: model[index].plantDept,
                                        stateCode: model[index].station_Code, plant: model[index].plantDept,
                                        raisedByEmpID: model[index].observationRaisedByEmpUnqId, status: model[index].status, imageNumber: model[index].imageNumber,
                                        correctiveMeasures: model[index].category,
                                        targetDate:"",
                                        complianceDate: "",), fullscreenDialog: true),
                                    );
                                    // context.push(
                                    //   '/edit_observation?uniqueId=${model[index].uniqueIdentificationNumber}&raisedBy=${model[index].observationRaisedByEmpUnqId}&wrkGrp=${model[index].wrkGrp}
                                    //   &deptCode=${model[index].deptCode}&stateCode=${model[index].station_Code}',
                                    // );

                                  },
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_sharp)),
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
                                      color: hexToColor(model[index].priorityStatusColour,
                                      )),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 1.screenWidth,
                                        right: 1.screenWidth),
                                    child: Text(
                                      model[index].priorityStatusName,
                                      style: const TextStyle(
                                          color: kcWhite,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          }),
    );
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
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: kcWhite,
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
    );
  }

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF' + hexString;
    }
    return Color(int.parse(hexString, radix: 16));
  }
}
