import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/hazard_graph_bloc.dart';
import 'package:jsaw_limited/bloc/hazardgraphExport_bloc.dart';
import 'package:jsaw_limited/model/hazard_graph_model.dart';
import 'package:jsaw_limited/state/hazardGraphExport_state.dart';
import 'package:jsaw_limited/state/hazard_graph_state.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/allSafetyObservationRaisedByManagerPieChart_bloc.dart';
import '../bloc/observation_status_List_bloc.dart';
import '../model/allsafetyobservationraised_pieGrpah_model.dart';
import '../model/observation_status_List_model.dart';
import '../service/graph.dart';
import '../state/allSafetyRaisedbyManagerPieGraph_state.dart';
import '../state/observation_status_List_state.dart';
import '../utils/app_color.dart';
import 'package:jsaw_limited/utils/compact_date_range_picker.dart';

class HazardGraph extends StatefulWidget {
  const HazardGraph({super.key});

  @override
  State<HazardGraph> createState() => _HazardGraphState();
}

class _HazardGraphState extends State<HazardGraph> {
  // Attached to both the Scrollbar and its scroll view (web/desktop scroll
  // views don't attach to the PrimaryScrollController).
  final ScrollController _tableScroll = ScrollController();

  late HazardGraphBloc hazardGraphBloc;
  late ObservationStatusListBloc observationStatusListBloc;
  late HazardGraphExportBloc hazardGraphExportBloc;

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController fromDateInput = TextEditingController();

  // Persisted applied filter values (controllers get cleared after Apply).
  String _appliedStartDate = "";
  String _appliedEndDate = "";

  @override
  void dispose() {
    _tableScroll.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<HazardGraphBloc>().initState("", ""); // Pass the necessary deptCode here
    context.read<SafetyRaisedByManagerPieChartBloc>().initState("", ""); // Pass the necessary deptCode here
    context.read<ObservationStatusListBloc>().initState();
    context.read<HazardGraphExportBloc>().initState();
    final graphService = Provider.of<GraphService>(context, listen: false);
    hazardGraphBloc = HazardGraphBloc(graphService);
    hazardGraphExportBloc = HazardGraphExportBloc(graphService);
    startDateInput.text = "";
    endDateInput.text = "";
    fromDateInput.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                      context.read<HazardGraphBloc>().initState(
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
          _buildObservationStatusPieBody(),
          _buildHazardPieBloc()
        ],
      ),
    );
  }

  _buildObservationStatusPieBody(){
    return BlocBuilder<SafetyRaisedByManagerPieChartBloc, SafetyRaisedByManagerPieChartState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (state) => _buildObservationStatusPieChartWithTable(state.allSafetyObservationRaisedByManager),
          failed: (state) => Center(child: Text('Error: ${state.msg}')),
          content: (state) => _buildObservationStatusPieChartWithTable(state.allSafetyObservationRaisedByManager),
        );
      },
    );
  }

  _buildObservationStatusPieBody1(){
    return BlocBuilder<ObservationStatusListBloc, ObservationStatusListState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (state) => _buildObservationStatusPieGraph(state.observationStatusListModel),
          failed: (state) => Center(child: Text('Error: ${state.msg}')),
          content: (state) => _buildObservationStatusPieGraph(state.observationStatusListModel),
        );
      },
    );
  }


  Widget _buildObservationStatusPieGraph(List<ObservationStatusListModel> observationStatusList){
    return Expanded(
      flex: 1,
      child: SfCircularChart(
        backgroundColor: kcWhite,
        title: const ChartTitle(
          text: 'Safety Observations by Status',
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: kcValueDark,
          ),
        ),
        legend: const Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
            position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries>[
          PieSeries<ObservationStatusListModel, String>(
            dataSource: observationStatusList,
            xValueMapper: (data, _) => data.name,
            yValueMapper: (data, _) => data.count,
            dataLabelMapper: (data, _) =>
                "${data.name} • ${data.percentage}%",
            radius: '70%',
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(fontSize: 12, color: kcValueDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObservationStatusPieChartWithTable(List<AllSafetyObservationRaisedByManagerandEnggModelPieChart> allRaisedPieChart) {
    return SizedBox(
      height: 360,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildObservationStatusPieBody1(),
          // Data Table
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Scrollbar(
                controller: _tableScroll,
                child: SingleChildScrollView(
                  controller: _tableScroll,
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 18.0,
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
                        DataColumn(label: Text('Closed')),
                        DataColumn(label: Text('Compliance')),
                        DataColumn(label: Text('In Progress')),
                        DataColumn(label: Text('Pending')),
                      ],
                      rows: allRaisedPieChart.map((data) {
                        return DataRow(
                          cells: [
                            DataCell(Text(data.plant)),
                            DataCell(Text(
                              data.closed.toString(),
                              style: const TextStyle(
                                  color: kcStatGreen,
                                  fontWeight: FontWeight.w600),
                            )),
                            DataCell(Text(
                              data.compliance.toString(),
                              style: const TextStyle(
                                  color: kcStatAmber,
                                  fontWeight: FontWeight.w600),
                            )),
                            DataCell(Text(
                              data.inProgress.toString(),
                              style: const TextStyle(
                                  color: kcStatPurple,
                                  fontWeight: FontWeight.w600),
                            )),
                            DataCell(Text(
                              data.pending.toString(),
                              style: const TextStyle(
                                  color: kcStatRed,
                                  fontWeight: FontWeight.w600),
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHazardPieBloc(){
    return BlocBuilder<HazardGraphBloc, HazardGraphState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (state) => _buildPieBody(state.hazardGraphState),
          failed: (state) => Center(child: Text('Error: ${state.error}')),
          content: (state) => _buildPieBody(state.hazardGraphState),
        );
      },
    );
  }

  Widget _buildPieBody(List<HazardGraphModel> allRaisedPieChart) {
    return SizedBox(
      height: 420,
      child: SfCircularChart(
        backgroundColor: kcWhite,
        title: const ChartTitle(
          text: 'Hazard Observations by Category',
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: kcValueDark,
          ),
        ),
        legend: const Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.scroll,
            position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries>[
          PieSeries<HazardGraphModel, String>(
            dataSource: allRaisedPieChart,
            xValueMapper: (obs, _) => obs.hazardCategory,
            yValueMapper: (obs, _) => obs.observationCount,
            dataLabelMapper: (obs, _) =>
                "${obs.hazardCategory} • ${obs.observationCount} (${obs.percentage}%)",
            radius: '70%',
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(fontSize: 12, color: kcValueDark),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openFilterDialog() async {
    await _buildFilterDialog(context);
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

                  if(startDateInput.text.isNotEmpty && endDateInput.text.isNotEmpty){

                    _appliedStartDate = startDateInput.text + " 00:00:00";
                    _appliedEndDate = endDateInput.text + " 23:59:59";
                    dialogContext.read<HazardGraphBloc>().initState(_appliedStartDate, _appliedEndDate);
                    // Clear inputs
                    startDateInput.clear();
                    endDateInput.clear();

                    // Close dialog
                    Navigator.of(context).pop();
                  }else{
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
    return BlocConsumer<HazardGraphExportBloc, HazardGraphExportState>(
        bloc: hazardGraphExportBloc,
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
                    hazardGraphExportBloc.initState(_appliedStartDate, _appliedEndDate);
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
