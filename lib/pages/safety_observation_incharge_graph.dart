import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/stationwise_export_bloc.dart';
import 'package:jsaw_limited/state/stationwise_graph_export_state.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/graph2_bloc.dart';
import '../service/graph.dart';
import '../state/graph2_state.dart';
import '../utils/app_color.dart';
import '../model/graph2_model.dart';

class SafetyObservationByIncharge extends StatefulWidget {
  @override
  _SafetyObservationByInchargeState createState() =>
      _SafetyObservationByInchargeState();
}

class _SafetyObservationByInchargeState
    extends State<SafetyObservationByIncharge> {
  late StationWiseGraphExportBloc stationWiseGraphExportBloc;

  final FocusNode _focusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();

  bool _isHovering = false;
  double _scrollSpeed = 0.0; // Adjust scroll speed

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController fromDateInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<Graph2Bloc>().initState("", "");

    final graphService = Provider.of<GraphService>(context, listen: false);

    stationWiseGraphExportBloc = StationWiseGraphExportBloc(graphService);

    startDateInput.text = "";
    endDateInput.text = "";
    fromDateInput.text = "";

    // Request focus when the screen is built
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Graph2Bloc, Graph2State>(
      builder: (context, state) {
        return state.when(
          loading: (_) => Center(child: CircularProgressIndicator()),
          success: (graph2Model) => _buildChart(graph2Model),
          failed: (_, __) => Center(child: Text('Failed to load data')),
          content: (_) => Center(child: Text('No data available')),
        );
      },
    );
  }

  Widget _buildChart(List<Graph2Model> graph2Models) {
    final List<ChartData> chartData = [];

    // Creating ChartData from the API response
    for (var model in graph2Models) {
      chartData.add(ChartData(
        model.plantDept,
        double.tryParse(model.totalCount) ?? 0.0,
        Colors.green,
      ));

      for (var station in model.stations) {
        chartData.add(ChartData(
          station.name,
          double.tryParse(station.count) ?? 0.0,
          Colors.orange,
        ));
      }
    }

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
                      context.read<Graph2Bloc>().initState("", "");
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: kcgreen),
                    icon: Icon(Icons.refresh),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        openFilterDialog();
                        // Clear inputs
                        startDateInput.clear();
                        endDateInput.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kcRed,
                          fixedSize: const Size(150, 30)),
                      child: const Text(
                        "Filter",
                        style: TextStyle(color: kcWhite),
                      )),
                ),
                _buildDownloadExcel(),
              ],
            ),
          ),
          Focus(
            focusNode: _focusNode, // FocusNode is used here
            onKey: (node, event) {
              if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                // Scroll right when the right arrow key is pressed
                _scrollController.animateTo(
                  _scrollController.offset + 50, // Adjust scroll amount as needed
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
                return KeyEventResult.handled;
              } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                // Scroll left when the left arrow key is pressed
                _scrollController.animateTo(
                  _scrollController.offset - 50, // Adjust scroll amount as needed
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
                return KeyEventResult.handled;
              }
              return KeyEventResult.ignored;
            },
            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  _isHovering = true;
                });
              },
              onExit: (_) {
                setState(() {
                  _isHovering = false;
                });
              },
              // onHover: (details) {
              //   if (_isHovering) {
              //     // Scroll based on cursor position
              //     double offset = details.localPosition.dx;
              //     _scrollController.animateTo(
              //       _scrollController.offset + (offset - _scrollController.offset) * 0.1,
              //       duration: const Duration(milliseconds: 50),
              //       curve: Curves.easeInOut,
              //     );
              //   }
              // },
              child: Scrollbar(
                thumbVisibility: true, // Thumb always visible
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: chartData.length * 60, // Adjust the width according to your data
                    child: SfCartesianChart(
                      backgroundColor: Colors.white,
                      title: const ChartTitle(
                          text:
                          'SAFETY OBSERVATIONS BY LINE ENGINEERS / INCHARGES'),
                      legend: const Legend(isVisible: false),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      primaryXAxis: const CategoryAxis(
                        labelRotation: 40,
                        majorGridLines: MajorGridLines(width: 0),
                      ),
                      primaryYAxis: const NumericAxis(
                        title: AxisTitle(text: 'Total No of Observations'),
                      ),
                      series: <CartesianSeries>[
                        ColumnSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          pointColorMapper: (ChartData data, _) => data.color,
                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                          width: 0.2,
                          spacing: 0.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Data Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enables horizontal scrolling
            child: Container(
              color: Colors.white,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                child: DataTable(
                  columnSpacing: 16.0,
                  columns: const [
                    DataColumn(
                        label: Text('Plant / Department',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Actual Reported',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: chartData.map((data) {
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          data.x,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataCell(Text(data.y.toString(),
                            style:
                            const TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
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
                    dialogContext.read<Graph2Bloc>().initState(
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

  _buildDateContainer() {
    return Container(
      width: 1000,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildDateRangeContainer("Start Date", startDateInput),
          _buildDateRangeContainer("End Date", endDateInput),
          ElevatedButton(
              onPressed: () {
                context.read<Graph2Bloc>().initState(
                    startDateInput.text + " " + "00:00:00",
                    endDateInput.text + " " + "23:59:59");
              },
              child: Text("Search")),
          ElevatedButton(
              onPressed: () {
                context.read<Graph2Bloc>().initState("", "");
              },
              style: ElevatedButton.styleFrom(backgroundColor: kcgreen),
              child: Text("Refresh")),
        ],
      ),
    );
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
    return BlocConsumer<StationWiseGraphExportBloc,
            StationWiseGraphExportState>(
        bloc: stationWiseGraphExportBloc,
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
                    stationWiseGraphExportBloc.initState(
                        startDateInput.text, endDateInput.text);
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

class ChartData {
  final String x;
  final double y;
  final Color color;

  ChartData(this.x, this.y, this.color);
}
