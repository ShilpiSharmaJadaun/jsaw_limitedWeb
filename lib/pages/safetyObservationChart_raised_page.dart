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
import '../bloc/departmentgraphexport_bloc.dart';
import '../bloc/observation_status_List_bloc.dart';
import '../model/allSafetyObservationByManager_Graph_model.dart';
import '../model/allsafetyObservationRaisedModelbyengg_model.dart';
import '../model/allsafetyobservationraised_pieGrpah_model.dart';
import '../service/graph.dart';
import '../state/AllSafetyObservationByManagerandEngg_State.dart';
import '../state/departmentgraphExport_state.dart';
import '../utils/app_color.dart';

class SafetyobservationchartRaisedPage extends StatefulWidget {
  const SafetyobservationchartRaisedPage({super.key});

  @override
  State<SafetyobservationchartRaisedPage> createState() => _SafetyobservationchartRaisedPageState();
}

class _SafetyobservationchartRaisedPageState extends State<SafetyobservationchartRaisedPage> {

  late DepartmentgraphExportBloc departmentgraphExportBloc;

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
    departmentgraphExportBloc = DepartmentgraphExportBloc(graphService);
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
                    style: ElevatedButton.styleFrom(backgroundColor: kcgreen),
                    icon: Icon(Icons.refresh),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        openFilterDialog();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kcRed, fixedSize: const Size(150, 30)),
                      child: const Text(
                        "Filter",
                        style: TextStyle(color: kcWhite),
                      )),
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
    return SfCartesianChart(
      key: UniqueKey(), // Forces the chart to rebuild
      backgroundColor: kcWhite,
      title: const ChartTitle(text: 'Safety Observations by Department'),
      legend: const Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: const CategoryAxis(
        title: AxisTitle(text: 'Department'),
        isVisible: true,
        labelRotation: 30,
        labelIntersectAction: AxisLabelIntersectAction.none,
        labelStyle: TextStyle(fontSize: 8, color: Colors.black),
      ),
      primaryYAxis: const NumericAxis(
        title: AxisTitle(text: 'Total No of Observations'),
      ),
      series: <CartesianSeries>[
        ColumnSeries<AllSafetyObservationRaisedByManagerandEnggModel, String>(
          dataSource: data,
          xValueMapper: (obs, _) => obs.pantDept,
          yValueMapper: (obs, _) => obs.count,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
            textStyle: TextStyle(fontSize: 10, color: Colors.black),
          ),
          color: Colors.blue,
          width: 0.6,
          spacing: 0.2,
        ),
      ],
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
                borderRadius: BorderRadius.all(Radius.circular(10))),
            contentPadding: const EdgeInsets.all(8.0),
            content: SizedBox(
              height: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "SELECT FILTERS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  _buildDateRangeContainer("Start Date", startDateInput),
                  _buildDateRangeContainer("End Date", endDateInput),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: kcRed),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: kcWhite),
                ),
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
                    backgroundColor: kcobservationgreen),
                child: const Text(
                  "Apply Filters",
                  style: TextStyle(color: kcWhite),
                ),
              ),
            ],
          );
        });
  }

  //date

  _buildDateRangeContainer(String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300,
        height: 40,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            hintText: hintText,
            fillColor: kcWhite,
            suffixIcon: const Icon(
              Icons.calendar_month,
              size: 20.0,
            ),
            filled: true,
            enabledBorder: _border(),
            focusedBorder: _border(),
          ),
          readOnly: true,
          onTap: hintText == "Start Date"
              ? () async {
            // Open a date range picker only for Start Date
            DateTimeRange? pickedDateRange = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
              initialDateRange: startDateInput.text.isNotEmpty &&
                  endDateInput.text.isNotEmpty
                  ? DateTimeRange(
                start: DateTime.parse(startDateInput.text),
                end: DateTime.parse(endDateInput.text),
              )
                  : DateTimeRange(
                start: DateTime.now()
                    .subtract(const Duration(days: 7)),
                end: DateTime.now(),
              ),
            );

            if (pickedDateRange != null) {
              String formattedStartDate =
              DateFormat('yyyy-MM-dd').format(pickedDateRange.start);
              String formattedEndDate =
              DateFormat('yyyy-MM-dd').format(pickedDateRange.end);

              setState(() {
                startDateInput.text = formattedStartDate;
                endDateInput.text = formattedEndDate;
              });
            }
          }
              : null, // Do nothing for "End Date"
        ),
      ),
    );
  }

  _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: kcBlack));

  _buildDownloadExcel() {
    return BlocConsumer<DepartmentgraphExportBloc, DepartmentgraphExportState>(
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
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          "assets/images/excelicon.png",
                          scale: 20,
                        ),
                      ),
                      const Text(
                        "Export",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: kcBlack),
                      ),
                    ],
                  )),
            );
          });
        });
  }

}
