import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/departmentgraphexport_bloc.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/departmentgraphExport_state.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/allSafetyObservationByManagerGraph_bloc.dart';
import '../state/AllSafetyObservationByManagerandEngg_State.dart';
import '../model/allSafetyObservationByManager_Graph_model.dart';
import '../utils/app_color.dart';

class SafetyObservationsChart extends StatefulWidget {
  const SafetyObservationsChart({super.key});

  @override
  _SafetyObservationsChartState createState() =>
      _SafetyObservationsChartState();
}

class _SafetyObservationsChartState extends State<SafetyObservationsChart> {
  late DepartmentgraphExportBloc departmentgraphExportBloc;

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController fromDateInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call initState of SafetyByManagerBloc to fetch data
    context
        .read<SafetyByManagerBloc>()
        .initState("", ""); // Pass the necessary deptCode here
    final graphService = Provider.of<GraphService>(context, listen: false);
 //   departmentgraphExportBloc = DepartmentgraxphExportBloc(graphService);

    startDateInput.text = "";
    endDateInput.text = "";
    fromDateInput.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SafetyByManagerBloc, AllSafetyByManagerState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (state) => _buildBody(state.allSafetyObservationByManager),
          failed: (state) => Center(child: Text('Error: ${state.msg}')),
          content: (state) => _buildBody(state.allSafetyObservationByManager),
        );
      },
    );
  }

  Widget _buildBody(List<AllSafetyObservationByManagerandEnggModel> data) {
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
                      context.read<SafetyByManagerBloc>().initState(
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
          SfCircularChart(
            key: UniqueKey(), // Forces the chart to rebuild
            backgroundColor: kcWhite,
            title: const ChartTitle(text: 'Safety Observations by Department'),
            legend: const Legend(
                isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries>[
              PieSeries<AllSafetyObservationByManagerandEnggModel, String>(
                dataSource: data,
                xValueMapper: (obs, _) => obs.pantDept,
                yValueMapper: (obs, _) => obs.count,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(fontSize: 12, color: Colors.black),
                ),
                explode: true, // Optional: Explode the segments
                explodeIndex: 0, // Optional: Highlight the first segment
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildChart(List<AllSafetyObservationByManagerandEnggModel> data) {
    return Column(
      children: [
        SfCartesianChart(
          key: UniqueKey(), // Forces the chart to rebuild
          backgroundColor: kcWhite,
          title: const ChartTitle(text: 'Safety Observations by Department'),
          legend: const Legend(isVisible: false),
          tooltipBehavior: TooltipBehavior(enable: true),
          primaryXAxis: const CategoryAxis(
            title: AxisTitle(text: 'Department'),
            isVisible: true,
            labelRotation: 45,
            labelStyle: TextStyle(fontSize: 12, color: Colors.black),
          ),
          primaryYAxis: const NumericAxis(
            title: AxisTitle(text: 'Total No of Observations'),
          ),
          series: <CartesianSeries>[
            ColumnSeries<AllSafetyObservationByManagerandEnggModel, String>(
              dataSource: data,
              xValueMapper: (obs, _) => obs.pantDept,
              yValueMapper: (obs, _) => obs.count,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
                textStyle: TextStyle(fontSize: 12, color: Colors.black),
              ),
              color: Colors.blue,
              width: 0.6,
              spacing: 0.2,
            ),
          ],
        ),

      ],
    );
  }

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
                    dialogContext.read<SafetyByManagerBloc>().initState(
                          startDateInput.text + " 00:00:00",
                          endDateInput.text + " 23:59:59",
                        );

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
