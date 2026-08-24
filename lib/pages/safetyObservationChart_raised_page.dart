import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/allSafetyObservationRaisedbyManager_bloc.dart';
import 'package:jsaw_limited/model/observation_status_List_model.dart';
import 'package:jsaw_limited/state/allSafetyRaisedbyManagerPieGraph_state.dart';
import 'package:jsaw_limited/state/allSafetyRaisedbyManager_state.dart';
import 'package:jsaw_limited/state/observation_status_List_state.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/allSafetyObservationByManagerGraph_bloc.dart';
import '../bloc/allSafetyObservationRaisedByManagerPieChart_bloc.dart';
import '../bloc/departmentRaisedGraphexport_bloc.dart';
import '../bloc/observation_status_List_bloc.dart';
import '../model/allSafetyObservationByManager_Graph_model.dart';
import '../model/allsafetyObservationRaisedModelbyengg_model.dart';
import '../model/allsafetyobservationraised_pieGrpah_model.dart';
import '../service/graph.dart';
import '../state/AllSafetyObservationByManagerandEngg_State.dart';
import '../state/departmentgraphExport_state.dart';
import '../utils/app_color.dart';
import 'package:jsaw_limited/utils/compact_date_range_picker.dart';

class SafetyobservationchartRaisedPage extends StatefulWidget {
  const SafetyobservationchartRaisedPage({super.key});

  @override
  State<SafetyobservationchartRaisedPage> createState() => _SafetyobservationchartRaisedPageState();
}

class _SafetyobservationchartRaisedPageState extends State<SafetyobservationchartRaisedPage> {

  late DepartmentRaisedGraphExportBloc departmentgraphExportBloc;

  late ObservationStatusListBloc observationStatusListBloc;

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController fromDateInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call initState of SafetyByManagerBloc to fetch data
    context.read<SafetyRaisedByManagerBloc>().initState("", ""); // Pass the necessary deptCode here
    //context.read<SafetyRaisedByManagerPieChartBloc>().initState("", ""); // Pass the necessary deptCode here
    context.read<ObservationStatusListBloc>().initState();
    final graphService = Provider.of<GraphService>(context, listen: false);
    departmentgraphExportBloc = DepartmentRaisedGraphExportBloc(graphService);
    observationStatusListBloc = ObservationStatusListBloc(graphService);
    startDateInput.text = "";
    endDateInput.text = "";
    fromDateInput.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SafetyRaisedByManagerBloc, AllSafetyRaisedByManagerState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (state) => _buildBody(state.allSafetyObservationRaisedByManager),
          failed: (state) => Center(child: Text('Error: ${state.msg}')),
          content: (state) => _buildBody(state.allSafetyObservationRaisedByManager),
        );
      },
    );
  }

  Widget _buildBody(List<AllSafetyObservationRaisedByManagerandEnggModel> data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 1000,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      context.read<SafetyRaisedByManagerBloc>().initState(
                        "",
                        "",
                      );
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: kcgreen,
                      foregroundColor: kcMediumGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    tooltip: 'Refresh',
                    icon: const Icon(Icons.refresh),
                  ),
                ),
                Center(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        openFilterDialog();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kcvoilet,
                          foregroundColor: kcWhite,
                          fixedSize: const Size(150, 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          )),
                      icon: const Icon(Icons.filter_alt_outlined, size: 18),
                      label: const Text("Filter")),
                ),
                _buildDownloadExcel(),
              ],
            ),
          ),
          _buildChart(data),
         // _buildPieBody()
        ],
      ),
    );
  }

  Widget _buildChart(List<AllSafetyObservationRaisedByManagerandEnggModel> data) {
    return SizedBox(
      height: 420,
      child: SfCartesianChart(
        backgroundColor: kcWhite,
        title: const ChartTitle(
          text: 'Safety Observations by Department',
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: kcValueDark,
          ),
        ),
        legend: const Legend(isVisible: false),
        tooltipBehavior: TooltipBehavior(enable: true),
        plotAreaBorderWidth: 0,
        primaryXAxis: const CategoryAxis(
          title: AxisTitle(text: 'Department'),
          isVisible: true,
          labelRotation: 45,
          labelIntersectAction: AxisLabelIntersectAction.rotate45,
          majorGridLines: MajorGridLines(width: 0),
          labelStyle: TextStyle(fontSize: 12, color: kcValueDark),
        ),
        primaryYAxis: const NumericAxis(
          title: AxisTitle(text: 'Total No of Observations'),
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0),
        ),
        series: <CartesianSeries>[
          ColumnSeries<AllSafetyObservationRaisedByManagerandEnggModel, String>(
            dataSource: data,
            xValueMapper: (obs, _) => obs.pantDept,
            yValueMapper: (obs, _) => obs.count,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyle(fontSize: 12, color: kcValueDark),
            ),
            color: kcvoilet,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            width: 0.6,
            spacing: 0.2,
          ),
        ],
      ),
    );
  }
  //
  // _buildPieBody(){
  //   return BlocBuilder<SafetyRaisedByManagerPieChartBloc, SafetyRaisedByManagerPieChartState>(
  //     builder: (context, state) {
  //       return state.map(
  //         loading: (_) => const Center(child: CircularProgressIndicator()),
  //         success: (state) => _buildPieChartWithTable(state.allSafetyObservationRaisedByManager),
  //         failed: (state) => Center(child: Text('Error: ${state.msg}')),
  //         content: (state) => _buildPieChartWithTable(state.allSafetyObservationRaisedByManager),
  //       );
  //     },
  //   );
  // }
  //
  // _buildPieBody1(){
  //   return BlocBuilder<ObservationStatusListBloc, ObservationStatusListState>(
  //     builder: (context, state) {
  //       return state.map(
  //         loading: (_) => const Center(child: CircularProgressIndicator()),
  //         success: (state) => _buildPieGraph(state.observationStatusListModel),
  //         failed: (state) => Center(child: Text('Error: ${state.msg}')),
  //         content: (state) => _buildPieGraph(state.observationStatusListModel),
  //       );
  //     },
  //   );
  // }
  //
  //
  // Widget _buildPieGraph(List<ObservationStatusListModel> observationStatusList){
  //   return Expanded(
  //       flex: 1,
  //       child: SfCircularChart(
  //         key: UniqueKey(),
  //         title: const ChartTitle(text: 'Safety Observations by Status'),
  //         legend: const Legend(
  //             isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
  //         tooltipBehavior: TooltipBehavior(enable: true),
  //         series: <CircularSeries>[
  //           PieSeries<ObservationStatusListModel, String>(
  //             dataSource: observationStatusList,
  //             xValueMapper: (data, _) => "${data.name}-${data.percentage}%",
  //             yValueMapper: (data, _) => data.count,
  //             dataLabelSettings: const DataLabelSettings(
  //               isVisible: true,
  //               textStyle: TextStyle(fontSize: 12, color: Colors.black),
  //             ),
  //             explode: true,
  //             explodeIndex: 0,
  //           ),
  //         ],
  //       ),
  //     );
  // }
  //
  // Widget _buildPieChartWithTable(List<AllSafetyObservationRaisedByManagerandEnggModelPieChart> allRaisedPieChart) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //
  //       _buildPieBody1(),
  //       // Data Table
  //       Expanded(
  //         flex: 2,
  //         child: SingleChildScrollView(
  //           scrollDirection: Axis.vertical,
  //           child: DataTable(
  //             columnSpacing: 12.0,
  //             columns: const [
  //               DataColumn(label: Text('Plant / Department', style: TextStyle(fontWeight: FontWeight.bold))),
  //               DataColumn(label: Text('Closed', style: TextStyle(fontWeight: FontWeight.bold))),
  //               DataColumn(label: Text('Compliance', style: TextStyle(fontWeight: FontWeight.bold))),
  //               DataColumn(label: Text('In Progress', style: TextStyle(fontWeight: FontWeight.bold))),
  //               DataColumn(label: Text('Pending', style: TextStyle(fontWeight: FontWeight.bold))),
  //             ],
  //             rows: allRaisedPieChart.map((data) {
  //               return DataRow(
  //                 cells: [
  //                   DataCell(Text(data.plant)),
  //                   DataCell(Text(data.closed.toString())),
  //                   DataCell(Text(data.compliance.toString())),
  //                   DataCell(Text(data.inProgress.toString())),
  //                   DataCell(Text(data.pending.toString())),
  //                 ],
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Future<void> openFilterDialog() async {
    await _buildFilterDialog(context); // Pass employeeCode to the dialog
  }

  Future<void> _buildFilterDialog(BuildContext dialogContext) {
    return showDialog(
        context: dialogContext,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            contentPadding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
            actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            title: Row(
              children: const [
                Icon(Icons.filter_alt_outlined, color: kcvoilet, size: 20),
                SizedBox(width: 8),
                Text(
                  "Select Filters",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: kcValueDark,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CompactDateRangeField(
                    startController: startDateInput,
                    endController: endDateInput,
                    width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(foregroundColor: kcLightGrey),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (startDateInput.text.isNotEmpty &&
                      endDateInput.text.isNotEmpty) {
                    // Trigger the API
                    // Trigger the API with filter parameters
                    dialogContext.read<SafetyRaisedByManagerBloc>().initState(
                      startDateInput.text + " 00:00:00",
                      endDateInput.text + " 23:59:59",
                    );

                    // context.read<SafetyRaisedByManagerPieChartBloc>().initState(startDateInput.text + " 00:00:00",
                    //   endDateInput.text + " 23:59:59");
                    // Clear inputs
                    startDateInput.clear();
                    endDateInput.clear();

                    // Close dialog
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select start date and end date."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcvoilet,
                  foregroundColor: kcWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text("Apply Filters"),
              ),
            ],
          );
        });
  }

  //date


  _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: kcVeryLightGrey));

  _focusedBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: kcvoilet));

  _buildDownloadExcel() {
    return BlocConsumer<DepartmentRaisedGraphExportBloc, DepartmentgraphExportState>(
        bloc: departmentgraphExportBloc,
        listener: (_, state) {
          state.maybeWhen(
              success: (_, url) {
                launchUrl(Uri.parse(url!));
              },
              failed: (_, message) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              },
              orElse: () {});
        },
        builder: (context, state) {
          return state.maybeWhen(loading: (_) {
            return const Center(child: CircularProgressIndicator());
          }, orElse: () {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    departmentgraphExportBloc.initState();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcWhite,
                    foregroundColor: kcobservationgreen,
                    elevation: 0,
                    side: const BorderSide(
                        color: kcobservationgreen, width: 1.2),
                    fixedSize: const Size(140, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Image.asset(
                          "assets/images/excelicon.png",
                          width: 18,
                          height: 18,
                        ),
                      ),
                      const Text(
                        "Export",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kcobservationgreen),
                      ),
                    ],
                  )),
            );
          });
        });
  }

}
