import 'package:flutter/material.dart';
import 'package:jsaw_limited/bloc/hazard_graph_bloc.dart';
import 'package:jsaw_limited/bloc/observation_status_List_bloc.dart';
import 'package:jsaw_limited/pages/hazard_graph.dart';
import 'package:jsaw_limited/pages/safetyObservationChart_raised_page.dart';
import 'package:jsaw_limited/pages/stationwise_graph_table.dart';
import 'package:jsaw_limited/pages/userwise_graph_table.dart';
import 'package:provider/provider.dart';
import 'package:jsaw_limited/pages/safety_observation_incharge_graph.dart';
import 'package:jsaw_limited/utils/app_color.dart';
import '../bloc/allSafetyObservationRaisedByManagerPieChart_bloc.dart';
import '../bloc/allSafetyObservationRaisedbyManager_bloc.dart';
import '../bloc/graph2_bloc.dart';
import '../bloc/allSafetyObservationByManagerGraph_bloc.dart';
import '../service/graph.dart';
import 'SafetyObservation_graph_page.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => SafetyByManagerBloc(context.read<GraphService>()),),
        Provider(create: (context) => SafetyRaisedByManagerBloc(context.read<GraphService>())),
        Provider(create: (context) => HazardGraphBloc(context.read<GraphService>())),
        Provider(create: (context) => SafetyRaisedByManagerPieChartBloc(context.read<GraphService>())),
        Provider(create: (context) => Graph2Bloc(context.read<GraphService>()),),
        Provider(create: (context) => ObservationStatusListBloc(context.read<GraphService>())),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // const AppDrawer(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  //  PageHeader(drawerTitles[_selectedDrawerIndex]),
                    TabBar(
                      isScrollable: false,
                      controller: tabController,
                      indicatorColor: kcvoilet,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: const [
                        Tab(
                          icon: Icon(
                            Icons.bar_chart,
                            color: kcMediumGrey,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Department Wise Received Observation",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kcMediumGrey,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.bar_chart,
                            color: kcMediumGrey,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Department Wise Raised Observation",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kcMediumGrey,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.bar_chart,
                            color: kcMediumGrey,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hazard Graph",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kcMediumGrey,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.bar_chart,
                            color: kcMediumGrey,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total No Of Observation Received",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kcMediumGrey,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.bar_chart,
                            color: kcMediumGrey,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "User Wise Table",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kcMediumGrey,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.bar_chart,
                            color: kcMediumGrey,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Station WIse Table",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kcMediumGrey,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - kToolbarHeight, // Set a specific height for the TabBarView
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          SafetyObservationsChart(),
                          SafetyobservationchartRaisedPage(),// This calls the manager's graph
                          HazardGraph(),
                          SafetyObservationByIncharge(),
                          UserwiseGraphTable(),
                          StationWiseGraphTablePage()// This calls the in-charge's graph
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
