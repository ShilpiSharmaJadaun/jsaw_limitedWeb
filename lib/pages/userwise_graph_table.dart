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
                  icon: const Icon(Icons.refresh),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    openFilterDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcRed,
                    fixedSize: const Size(150, 30),
                  ),
                  child: const Text(
                    "Filter",
                    style: TextStyle(color: kcWhite),
                  ),
                ),
              ),
              _buildDownloadExcel(),
            ],
          ),
        ),
        TextFormField(
          onChanged: userWiseNotifier.filterBasedOn,
          decoration: const InputDecoration(
            hintText: "search here...",
            prefixIcon: Icon(
              Icons.search,
              color: kcLightGrey,
            ),
          ),
        ),
        SizedBox(
          width: 1800,
          child: Row(
            children: [
              _buildTableHeaderContainer("Emp Code", 80),
              _buildTableHeaderContainer("Emp Name", 100),
              _buildTableHeaderContainer("Total Raised", 20),
              _buildTableHeaderContainer("Total Received", 20),
              _buildTableHeaderContainer("Total Pending", 20),
              _buildTableHeaderContainer("Total Closed", 20),
              _buildTableHeaderContainer("Department", 40),
              _buildTableHeaderContainer("Designation Name", 40),
            ],
          ),
        ),
        if(model.isNotEmpty)
        Expanded(
          child: ValueListenableBuilder<List<UserWiseTableGraphModel>>(
            valueListenable: userWiseNotifier,
            builder: (context, list, widget) {
              if (list.isEmpty) {
                // Show a message if the list is empty
                return const Center(
                  child: Text(
                    "No data available",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTableBodyContainer(
                        list[index].empUnqId,
                        120,
                      ),
                      _buildTableBodyContainer(
                        list[index].empName,
                        120,
                      ),
                      _buildTableBodyContainer(
                        list[index].totalRaised.toString(),
                        40,
                      ),
                      _buildTableBodyContainer(
                        list[index].totalReceived.toString(),
                        40,
                      ),
                      _buildTableBodyContainer(
                        list[index].totalPendingRaised.toString(),
                        40,
                      ),
                      _buildTableBodyContainer(
                        list[index].totalClosedRaised.toString(),
                        80,
                      ),
                      _buildTableBodyContainer(
                        list[index].departmentName.toString(),
                        80,
                      ),
                      _buildTableBodyContainer(
                        list[index].designationName.toString(),
                        80,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
       // const Text("No Data Found")

      ],
    );
  }


  _buildTableHeaderContainer(String title,double width) {
    return Container(
      width: 120,
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
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold,color: kcWhite),),
        ),),);
  }

  _buildTableBodyContainer(String title, double width) {
    return Container(
      width: 120,
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: .5)
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(title,
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),),
        ),),);
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
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildallDepartDialog(departModel, context);
        },
        child: SizedBox(
          width: 250,
          height: 40,
          child: Container(
            // width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: stat,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                       width: 100,
                      child: Text(
                        value.isEmpty ? "Select Designation" : stat.value,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(color: (stat.value == "Select Designation") ? kcDarkGreyColor : kcLightGrey),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down_sharp)
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
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select or search Department",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    onChanged: departListNotifier.filterBasedOn,
                    decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      ),
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: 300,
                height: 800,
                child: ValueListenableBuilder<List<AllDesignationModel>>(
                  valueListenable: departListNotifier,
                  builder: (context, list, widget) {
                    return ListView.builder(
                      itemCount: list.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final designation = list[index];
                        final isSelected = selectedDesignations.contains(designation.designation_name);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedDesignations.remove(designation.designation_name);
                                  } else {
                                    selectedDesignations.add(designation.designation_name);
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == true) {
                                          selectedDesignations.add(designation.designation_name);
                                        } else {
                                          selectedDesignations.remove(designation.designation_name);
                                        }
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      designation.designation_name,
                                      style: const TextStyle(color: kcBlack),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(
                                height: 0.8,
                                thickness: 1,
                                color: kcDarkGreyColor,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              actions: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, selectedDesignations);
                    },
                    child: const Text(
                      "Done",
                      style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((selectedValues) {
      if (selectedValues != null && selectedValues is List<String>) {
        stat.value = selectedValues.join(", ");
        print("Selected values: $selectedValues");
      }
    });

  }

  _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: kcBlack));

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