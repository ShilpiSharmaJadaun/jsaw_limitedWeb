import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/allDesignation_bloc.dart';
import 'package:jsaw_limited/bloc/userwise_table_export_bloc.dart';
import 'package:jsaw_limited/bloc/userwise_tablegraph_bloc.dart';
import 'package:jsaw_limited/model/allDesignation_model.dart';
import 'package:jsaw_limited/model/userwise_tablegraph_model.dart';
import 'package:jsaw_limited/service/graph.dart';
import 'package:jsaw_limited/state/allDesignation_state.dart';
import 'package:jsaw_limited/state/userwise_table_export_state.dart';
import 'package:jsaw_limited/state/userwise_tablegraph_state.dart';
import 'package:jsaw_limited/utils/app_color.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserwiseGraphTable extends StatefulWidget {
  const UserwiseGraphTable({super.key});

  @override
  State<UserwiseGraphTable> createState() => _UserwiseGraphTableState();
}

class _UserwiseGraphTableState extends State<UserwiseGraphTable> {

  late UserWiseTableGraphBloc userWiseTableGraphBloc;
  late UserWiseTableExportBloc userWiseTableExportBloc;
  late  AllDesignationBloc allDesignationBloc;

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController fromDateInput = TextEditingController();
  ValueNotifier<String> stat = ValueNotifier("");

  late String statCode = "";

  @override
  void initState() {
    super.initState();
    final graphService = Provider.of<GraphService>(context, listen: false);
    userWiseTableGraphBloc = UserWiseTableGraphBloc(graphService);
    userWiseTableGraphBloc.init("","","");
    userWiseTableExportBloc = UserWiseTableExportBloc(graphService);
    allDesignationBloc = AllDesignationBloc(graphService);
    allDesignationBloc.initState();
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
    return BlocConsumer<UserWiseTableGraphBloc, UserWiseTableGraphState>(
      bloc: userWiseTableGraphBloc,
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

  Widget _buildDataTableLoading(List<UserWiseTableGraphModel> model){
    return const CircularProgressIndicator();

  }

  Widget _buildCreditNoteContent(List<UserWiseTableGraphModel> model) {
    final userWiseNotifier = userWiseSearchableListNotifier(model);

    return Column(
      children: [
        SizedBox(
          width: 1000,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    userWiseTableGraphBloc.init("", "", "");
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SizedBox(
            height: 44,
            child: TextFormField(
              onChanged: userWiseNotifier.filterBasedOn,
              style: const TextStyle(fontSize: 14, color: kcValueDark),
              decoration: InputDecoration(
                hintText: "Search by name or emp code…",
                hintStyle: const TextStyle(color: kcLightGrey, fontSize: 14),
                prefixIcon: const Icon(
                  Icons.search,
                  color: kcLightGrey,
                  size: 20,
                ),
                filled: true,
                fillColor: kcWhite,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                enabledBorder: _border(),
                focusedBorder: _focusedBorder(),
              ),
            ),
          ),
        ),
        Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1090,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildTableHeaderContainer("Emp Code", 120),
                        _buildTableHeaderContainer("Emp Name", 180),
                        _buildTableHeaderContainer("Total Raised", 110),
                        _buildTableHeaderContainer("Total Received", 120),
                        _buildTableHeaderContainer("Total Pending", 110),
                        _buildTableHeaderContainer("Total Closed", 110),
                        _buildTableHeaderContainer("Department", 160),
                        _buildTableHeaderContainer("Designation Name", 180),
                      ],
                    ),
                    Expanded(
                      child: model.isEmpty
                          ? const _TableEmptyState(
                              message: "No data available",
                            )
                          : ValueListenableBuilder<
                              List<UserWiseTableGraphModel>>(
                              valueListenable: userWiseNotifier,
                              builder: (context, list, widget) {
                                if (list.isEmpty) {
                                  return const _TableEmptyState(
                                    message: "No results match your search",
                                  );
                                }
                                return ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final row = list[index];
                                    final rowColor = index.isOdd
                                        ? kcDashboardBg2
                                        : kcWhite;
                                    return Container(
                                      color: rowColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildTableBodyContainer(
                                              row.empUnqId, 120),
                                          _buildTableBodyContainer(
                                              row.empName, 180),
                                          _buildTableBodyContainer(
                                            row.totalRaised.toString(),
                                            110,
                                            valueColor: kcStatBlue,
                                          ),
                                          _buildTableBodyContainer(
                                            row.totalReceived.toString(),
                                            120,
                                            valueColor: kcStatBlue,
                                          ),
                                          _buildTableBodyContainer(
                                            row.totalPendingRaised
                                                .toString(),
                                            110,
                                            valueColor: kcStatRed,
                                          ),
                                          _buildTableBodyContainer(
                                            row.totalClosedRaised
                                                .toString(),
                                            110,
                                            valueColor: kcStatGreen,
                                          ),
                                          _buildTableBodyContainer(
                                              row.departmentName.toString(),
                                              160),
                                          _buildTableBodyContainer(
                                              row.designationName.toString(),
                                              180),
                                        ],
                                      ),
                                    );
                                  },
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
      height: 48,
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
      height: 44,
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
                start: DateTime.parse(startDateInput.text +" " +"00:00:00"),
                end: DateTime.parse(endDateInput.text+" " + "23:59:59"),
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
              height: 300,
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
                  _buildDepartment()
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

                  if(startDateInput.text.isNotEmpty && endDateInput.text.isNotEmpty || stat.value.isNotEmpty){

                    if(startDateInput.text.isEmpty && endDateInput.text.isEmpty){
                      setState(() {
                        startDateInput.text = "";
                        endDateInput.text = "";
                      });
                    }else{
                        setState(() {
                          startDateInput.text = startDateInput.text +" " +"00:00:00";
                          endDateInput.text = endDateInput.text+" " + "23:59:59";
                        });
                    }

                    userWiseTableGraphBloc.init(startDateInput.text, endDateInput.text, stat.value);

                    // Clear inputs
                    startDateInput.clear();
                    endDateInput.clear();
                    stat.value = "";

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


  //All Department

  Widget _buildDepartment(){
    return  BlocConsumer<AllDesignationBloc, AllDesignationState>(
      bloc: allDesignationBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading4,
            content: _buildContent4,
            success: _buildContent4,
            failed: (form, __) => _buildContent4(form));
      },
    );
  }

  Widget _buildLoading4(List<AllDesignationModel> departModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent4(List<AllDesignationModel> departModel){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: (){
          _buildallDepartDialog(departModel, context);
        },
        child: SizedBox(
          width: 300,
          height: 44,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: kcWhite,
              border: Border.all(color: kcVeryLightGrey, width: 1),
            ),
            child: ValueListenableBuilder<String>(
              valueListenable: stat,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.work_outline,
                      size: 18,
                      color: kcLightGrey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        value.isEmpty ? "Select Designation" : value,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                          color: value.isEmpty ? kcLightGrey : kcValueDark,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: kcLightGrey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  Future<void> _buildallDepartDialog(List<AllDesignationModel> departModel,BuildContext dialogContext,) {
    final departListNotifier = designationSearchableListNotifier(departModel);
    return showDialog(
      context: context,
      builder: (context) {
        // List to store selected designation names
        List<String> selectedDesignations = [];

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
              contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              title: Row(
                children: const [
                  Icon(Icons.work_outline, color: kcvoilet, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Select Designation",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kcValueDark,
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: 360,
                height: 440,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        onChanged: departListNotifier.filterBasedOn,
                        style: const TextStyle(
                            fontSize: 14, color: kcValueDark),
                        decoration: InputDecoration(
                          hintText: "Search designations…",
                          hintStyle: const TextStyle(
                              color: kcLightGrey, fontSize: 14),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: kcLightGrey,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: kcWhite,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          enabledBorder: _border(),
                          focusedBorder: _focusedBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ValueListenableBuilder<List<AllDesignationModel>>(
                        valueListenable: departListNotifier,
                        builder: (context, list, widget) {
                          if (list.isEmpty) {
                            return const Center(
                              child: Text(
                                "No designations match",
                                style: TextStyle(
                                    color: kcLightGrey, fontSize: 14),
                              ),
                            );
                          }
                          return Scrollbar(
                            child: ListView.separated(
                              itemCount: list.length,
                              separatorBuilder: (_, __) => const Divider(
                                height: 1,
                                thickness: 0.5,
                                color: kcVeryLightGrey,
                              ),
                              itemBuilder: (context, index) {
                                final designation = list[index];
                                final isSelected = selectedDesignations
                                    .contains(designation.designation_name);

                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedDesignations.remove(
                                            designation.designation_name);
                                      } else {
                                        selectedDesignations
                                            .add(designation.designation_name);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: isSelected,
                                          activeColor: kcvoilet,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize
                                                  .shrinkWrap,
                                          visualDensity:
                                              VisualDensity.compact,
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == true) {
                                                selectedDesignations.add(
                                                    designation
                                                        .designation_name);
                                              } else {
                                                selectedDesignations.remove(
                                                    designation
                                                        .designation_name);
                                              }
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: Text(
                                            designation.designation_name,
                                            style: const TextStyle(
                                                color: kcValueDark,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
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
                    Navigator.pop(context, selectedDesignations);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcvoilet,
                    foregroundColor: kcWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text("Done"),
                ),
              ],
            );
          },
        );
      },
    ).then((selectedValues) {
      if (selectedValues != null && selectedValues is List<String>) {
        stat.value = selectedValues.join(", ");
      }
    });

  }

  _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: kcVeryLightGrey));

  _focusedBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: kcvoilet));

  _buildDownloadExcel(){
    return BlocConsumer<UserWiseTableExportBloc, UserWiseTableExportState>(
        bloc: userWiseTableExportBloc,
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
                  onPressed: (){ userWiseTableExportBloc.initState(startDateInput.text +" "+ "00:00:00",endDateInput.text+ " " + "23:59:59", stat.value );},
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

class designationSearchableListNotifier extends ValueNotifier<List<AllDesignationModel>> {

  designationSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllDesignationModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.designation_name.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }

}

class userWiseSearchableListNotifier extends ValueNotifier<List<UserWiseTableGraphModel>> {

  userWiseSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<UserWiseTableGraphModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) =>
      e.empName.toLowerCase().contains(query.toLowerCase()) ||
          e.empUnqId.toLowerCase().contains(query.toLowerCase())).toList();
      notifyListeners();
    }

  }

}