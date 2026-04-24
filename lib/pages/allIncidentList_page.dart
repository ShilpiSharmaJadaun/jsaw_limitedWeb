import 'dart:ui' hide window;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/allIncidentList_bloc.dart';
import 'package:flutter/material.dart';
import 'package:jsaw_limited/model/allIncidentList_model.dart';
import 'package:jsaw_limited/state/allIncidentList_state.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:html';
import '../bloc/all_filter_observation_bloc.dart';
import '../service/incident_service.dart';
import '../utils/app_color.dart';
import 'dart:html' as html;

class AllincidentlistPage extends StatefulWidget {
  const AllincidentlistPage({super.key});

  @override
  State<AllincidentlistPage> createState() => _AllincidentlistPageState();
}

class _AllincidentlistPageState extends State<AllincidentlistPage> {

  late AllIncidentListBloc allincidentlistBloc;

  late final AllFilterObservationBloc allFilterObservationBloc;

  @override
  void initState() {
    super.initState();
    final incidentService = Provider.of<IncidentService>(context, listen: false);
    allincidentlistBloc = AllIncidentListBloc(incidentService);
    allincidentlistBloc.initState();
  }

  int currentPage = 0;
  late String raisedSessionID = window.localStorage['kRaisedSessionID'] ?? "";

  void _nextPage() {
    setState(() {
      currentPage++;
      allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", "", "",raisedSessionID,"");
    });
  }

  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
        allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", "", "",raisedSessionID,"");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _buildAllIncidentList(),
    );
  }

  _buildAllIncidentList() {
    return BlocConsumer<AllIncidentListBloc, AllIncidentListState>(
      bloc: allincidentlistBloc,
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

  Widget _buildContent(List<AllIncidentListModel> model) {
    return Column(
      children: [
        ///sliver list, lazy loading
        Expanded(
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
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              width: 40.screenWidth,
                              height: 20.screenHeight,
                              child: FadeInImage(
                                placeholder: NetworkImage(model[index].imageUrl), // Low-quality image
                                image: NetworkImage(model[index].imageUrl), // High-quality image
                                fadeInDuration: const Duration(milliseconds: 300), // Fade duration for transition
                                fadeOutDuration: const Duration(milliseconds: 300), // Fade out duration for the placeholder
                                fit: BoxFit.cover, // Image fit mode
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error); // Handle any error loading the image
                                },
                              ),
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
                                                    "Employee Name / Code :"),
                                              ],
                                            ),
                                            _buildTextBox(
                                                model[index].employeeName + " ("+ model[index].employeeCode + ")",
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
                                                  scale: 18,
                                                ),
                                                _buildHeadingText(
                                                    "Plant / Dept :"),
                                              ],
                                            ),
                                            _buildTextBox(model[index].plant,
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
                                                    "Contractor Name :"),
                                              ],
                                            ),
                                            _buildTextBox(
                                                model[index].contractorName,
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
                                            _buildTextBox(model[index].location,
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
                                                model[index].raisedDate, kcRed)
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
                                                model[index].responsibleShiftEngg,
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
                                            _buildHeadingText("FIR Date :"),
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
                                              model[index].firDateTime,
                                              style:  const TextStyle(
                                                  color: kcWhite,
                                                  fontWeight: FontWeight.w500),
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
                                            _buildHeadingText("Injury Type :"),
                                          ],
                                        ),
                                        Container(
                                          width: 150,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 1,
                                                right: 1),
                                            child: Text(
                                              model[index].workInjury,
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
                                            _buildHeadingText("Incident Date :"),
                                          ],
                                        ),
                                        Container(
                                          width: 120,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 1,
                                                right: 1),
                                            child: Text(
                                              model[index].incidentDateTime,
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
                                        model[index].descpOfIncident,
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
                                      _buildHeadingText("Plant:"),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 500,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        model[index].plant,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  // IconButton(
                                  //     onPressed: () async{
                                  //       final shouldInit = await Navigator.of(context).push(
                                  //         MaterialPageRoute(builder: (context) => EditRaisedObservationsPage(filterObservationModel: model.model[index],),
                                  //             fullscreenDialog: true),
                                  //       );
                                  //       if(shouldInit != null && shouldInit) {
                                  //         allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", "", window.localStorage['kEmployeeCode'] ?? "", "","");   }
                                  //     },
                                  //     icon: const Icon(
                                  //         Icons.arrow_forward_ios_sharp)),

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


  _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 2, color: kcWhite));
}
