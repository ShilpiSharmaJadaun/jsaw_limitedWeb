import 'dart:math' as math;

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
        kcvoilet,
      ));

      for (var station in model.stations) {
        chartData.add(ChartData(
          station.name,
          double.tryParse(station.count) ?? 0.0,
          kcStatAmber,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Wrap(
              spacing: 16,
              runSpacing: 6,
              children: const [
                _LegendChip(color: kcvoilet, label: 'Plant Total'),
                _LegendChip(color: kcStatAmber, label: 'Station'),
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
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
                return KeyEventResult.handled;
              } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                // Scroll left when the left arrow key is pressed
                _scrollController.animateTo(
                  _scrollController.offset - 50, // Adjust scroll amount as needed
                  duration: const Duration(milliseconds: 200),
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
              child: SizedBox(
                height: 460,
                child: Scrollbar(
                  thumbVisibility: true, // Thumb always visible
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: math.max(
                        chartData.length * 60.0,
                        MediaQuery.of(context).size.width,
                      ),
                      child: SfCartesianChart(
                        backgroundColor: kcWhite,
                        title: const ChartTitle(
                            text:
                                'Safety Observations by Line Engineers / Incharges',
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: kcValueDark,
                            )),
                        legend: const Legend(isVisible: false),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        plotAreaBorderWidth: 0,
                        primaryXAxis: const CategoryAxis(
                          labelRotation: 40,
                          majorGridLines: MajorGridLines(width: 0),
                          labelStyle:
                              TextStyle(fontSize: 12, color: kcValueDark),
                        ),
                        primaryYAxis: const NumericAxis(
                          title: AxisTitle(text: 'Total No of Observations'),
                          axisLine: AxisLine(width: 0),
                          majorTickLines: MajorTickLines(size: 0),
                        ),
                        series: <CartesianSeries>[
                          ColumnSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            pointColorMapper: (ChartData data, _) => data.color,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              labelPosition: ChartDataLabelPosition.outside,
                              textStyle:
                                  TextStyle(fontSize: 11, color: kcValueDark),
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            width: 0.5,
                            spacing: 0.2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Data Table
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 24.0,
                  headingRowColor:
                      WidgetStateProperty.all(kcvoilet),
                  headingTextStyle: const TextStyle(
                    color: kcWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  dataTextStyle: const TextStyle(
                    color: kcValueDark,
                    fontSize: 13,
                  ),
                  dividerThickness: 0.5,
                  columns: const [
                    DataColumn(label: Text('Plant / Department')),
                    DataColumn(label: Text('Actual Reported')),
                  ],
                  rows: chartData.map((data) {
                    return DataRow(
                      cells: [
                        DataCell(Text(data.x)),
                        DataCell(Text(
                          data.y.toStringAsFixed(0),
                          style: const TextStyle(
                              color: kcvoilet, fontWeight: FontWeight.w600),
                        )),
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
                  _buildDateRangeContainer("Start Date", startDateInput),
                  _buildDateRangeContainer("End Date", endDateInput),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: SizedBox(
        width: 300,
        height: 44,
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 14, color: kcValueDark),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            hintText: hintText,
            hintStyle: const TextStyle(color: kcLightGrey, fontSize: 14),
            fillColor: kcWhite,
            prefixIcon: const Icon(
              Icons.calendar_month_outlined,
              size: 18,
              color: kcLightGrey,
            ),
            filled: true,
            enabledBorder: _border(),
            focusedBorder: _focusedBorder(),
          ),
          readOnly: true,
          onTap: () async {
            DateTimeRange? pickedDateRange = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
              builder: (ctx, child) => Theme(
                data: Theme.of(ctx).copyWith(
                  colorScheme: Theme.of(ctx).colorScheme.copyWith(
                        primary: kcvoilet,
                        onPrimary: kcWhite,
                      ),
                ),
                child: child!,
              ),
              initialDateRange: startDateInput.text.isNotEmpty &&
                      endDateInput.text.isNotEmpty
                  ? DateTimeRange(
                      start: DateTime.parse(startDateInput.text),
                      end: DateTime.parse(endDateInput.text),
                    )
                  : DateTimeRange(
                      start:
                          DateTime.now().subtract(const Duration(days: 7)),
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
          },
        ),
      ),
    );
  }

  _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: kcVeryLightGrey));

  _focusedBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: kcvoilet));

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

class ChartData {
  final String x;
  final double y;
  final Color color;

  ChartData(this.x, this.y, this.color);
}

class _LegendChip extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendChip({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: kcValueDark),
        ),
      ],
    );
  }
}
