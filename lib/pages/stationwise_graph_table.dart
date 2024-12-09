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

class StationWiseGraphTablePage extends StatefulWidget {
  const StationWiseGraphTablePage({super.key});

  @override
  State<StationWiseGraphTablePage> createState() => _StationWiseGraphTablePageState();
}

class _StationWiseGraphTablePageState extends State<StationWiseGraphTablePage> {

  late StationWiseGraphTableBloc stationWiseGraphTableBloc;
  late StationWiseTableExportBloc stationWiseTableExportBloc;
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController fromDateInput = TextEditingController();


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
                child: IconButton(onPressed: (){
                  stationWiseGraphTableBloc.init("","");
                },
                  style: ElevatedButton.styleFrom(backgroundColor: kcgreen),
                  icon: Icon(Icons.refresh),
                ),
              ),
              Center(
                child: ElevatedButton(onPressed: (){
                  openFilterDialog();
                },
                    style: ElevatedButton.styleFrom(backgroundColor: kcRed, fixedSize: const Size(150, 30)),
                    child: const Text("Filter", style: TextStyle(color: kcWhite),)),
              ),
              _buildDownloadExcel(),
            ],
          ),
        ),
        // _buildDateContainer(),
        // _buildDownloadExcel(),
        SizedBox(
          width: 1800,
          //   color: Colors.grey,
          child: Row(
            children: [
              _buildTableHeaderContainer("Station Name",160),
              _buildTableHeaderContainer("Total Observations Raised by Station",170),
              _buildTableHeaderContainer("Total Observations Received by Station",170),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: 1800,
            child: ListView.builder(
              itemCount: model.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    _buildTableBodyContainer(model[index].stationName.toString(),170),
                    _buildTableBodyContainer(model[index].totalRaised.toString(),200),
                    _buildTableBodyContainer(model[index].totalReceived.toString(),200),
                  ],
                );
              },

            ),
          ),
        )
      ],
    );

  }

  _buildTableHeaderContainer(String title,double width) {
    return Container(
      width: 300,
      height: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width:2),
          color: kcDarkGreyColor
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold,color: kcWhite),),
        ),),);
  }

  _buildTableBodyContainer(String title, double width) {
    return Container(
      width: 300,
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: .5)
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),),
        ),),);
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
                style: ElevatedButton.styleFrom(backgroundColor: kcobservationgreen),
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

                  child:
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset("assets/images/excelicon.png", scale: 20,),
                      ),
                      const Text("Export", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: kcBlack),),
                    ],
                  )
              ),
            );

          });
        });
  }

}
