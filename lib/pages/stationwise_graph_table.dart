import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/stationwise_graphtable_bloc.dart';
import 'package:jsaw_limited/bloc/stationwise_tableexport_bloc.dart';
import 'package:jsaw_limited/model/stationwise_graphtable_model.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/stationwise_graphtable_state.dart';
import 'package:jsaw_limited/state/stationwise_tableexport_state.dart';
import 'package:jsaw_limited/utils/app_color.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jsaw_limited/utils/compact_date_range_picker.dart';

class StationWiseGraphTablePage extends StatefulWidget {
  const StationWiseGraphTablePage({super.key});

  @override
  State<StationWiseGraphTablePage> createState() => _StationWiseGraphTablePageState();
}

class _StationWiseGraphTablePageState extends State<StationWiseGraphTablePage> {
  // Shared with the horizontal SingleChildScrollView below; a Scrollbar with
  // thumbVisibility:true needs an attached controller (horizontal scroll views
  // don't attach to the PrimaryScrollController) or it asserts every frame.
  final ScrollController _hScroll = ScrollController();


  late StationWiseGraphTableBloc stationWiseGraphTableBloc;
  late StationWiseTableExportBloc stationWiseTableExportBloc;
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController fromDateInput = TextEditingController();


  @override
  void dispose() {
    _hScroll.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final graphService = Provider.of<GraphService>(context, listen: false);
    stationWiseGraphTableBloc = StationWiseGraphTableBloc(graphService);
    stationWiseGraphTableBloc.init("", "");
    stationWiseTableExportBloc = StationWiseTableExportBloc(graphService);

    startDateInput.text = "";
    endDateInput.text = "";
    fromDateInput.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildDataTableBody(),
    ) ;
  }

  _buildDataTableBody(){
    return BlocConsumer<StationWiseGraphTableBloc, StationWiseGraphTableState>(
      bloc: stationWiseGraphTableBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildDataTableLoading,
            content: _buildCreditNoteContent,
            success: _buildCreditNoteContent,
            failed: (form, __) => _buildCreditNoteContent(form));
      },
    );
  }

  Widget _buildDataTableLoading(List<StationWiseGraphTableModel> model){
    return const CircularProgressIndicator();
  }

  Widget _buildCreditNoteContent(List<StationWiseGraphTableModel> model){
    // print(model.length);
    return Column(
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
                    stationWiseGraphTableBloc.init("", "");
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
                    ),
                  ),
                  icon: const Icon(Icons.filter_alt_outlined, size: 18),
                  label: const Text("Filter"),
                ),
              ),
              _buildDownloadExcel(),
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            controller: _hScroll,
            child: SingleChildScrollView(
              controller: _hScroll,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 760,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildTableHeaderContainer("Station Name", 240),
                        _buildTableHeaderContainer(
                            "Total Observations Raised by Station", 260),
                        _buildTableHeaderContainer(
                            "Total Observations Received by Station", 260),
                      ],
                    ),
                    Expanded(
                      child: model.isEmpty
                          ? const _TableEmptyState(
                              message: "No data available",
                            )
                          : ListView.builder(
                              itemCount: model.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                final row = model[index];
                                final rowColor = index.isOdd
                                    ? kcDashboardBg2
                                    : kcWhite;
                                return Container(
                                  color: rowColor,
                                  child: Row(
                                    children: [
                                      _buildTableBodyContainer(
                                          row.stationName.toString(), 240),
                                      _buildTableBodyContainer(
                                        row.totalRaised.toString(),
                                        260,
                                        valueColor: kcStatBlue,
                                      ),
                                      _buildTableBodyContainer(
                                        row.totalReceived.toString(),
                                        260,
                                        valueColor: kcStatGreen,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

  }

  _buildTableHeaderContainer(String title, double width) {
    return Container(
      width: width,
      height: 56,
      decoration: const BoxDecoration(
        color: kcvoilet,
        border: Border(
          right: BorderSide(color: Colors.white24, width: 0.5),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: kcWhite,
            ),
          ),
        ),
      ),
    );
  }

  _buildTableBodyContainer(String title, double width, {Color? valueColor}) {
    return Container(
      width: width,
      height: 48,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: kcVeryLightGrey, width: 0.6),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight:
                  valueColor != null ? FontWeight.w600 : FontWeight.w400,
              fontSize: 13,
              color: valueColor ?? kcValueDark,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openFilterDialog() async {

    await _buildFilterDialog(context);  // Pass employeeCode to the dialog
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
                    // Trigger the API
                    // Trigger the API with filter parameters
                    stationWiseGraphTableBloc.init( startDateInput.text + " 00:00:00",endDateInput.text + " 23:59:59");

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

  _buildDownloadExcel(){
    return BlocConsumer<StationWiseTableExportBloc, StationWiseTableExportState>(
        bloc: stationWiseTableExportBloc,
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
                  onPressed: (){ stationWiseTableExportBloc.initState(startDateInput.text + " 00:00:00",endDateInput.text + " 23:59:59");},
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

class _TableEmptyState extends StatelessWidget {
  final String message;
  const _TableEmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.inbox_outlined, size: 48, color: kcLightGrey),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(color: kcLightGrey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
