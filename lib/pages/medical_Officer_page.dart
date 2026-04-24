import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/allBodyParts_bloc.dart';
import 'package:jsaw_limited/bloc/allNatureInjury_bloc.dart';
import 'package:jsaw_limited/bloc/allTypeIncident_bloc.dart';
import 'package:jsaw_limited/model/allBodyParts_model.dart';
import 'package:jsaw_limited/model/allNatureInjury_model.dart';
import 'package:jsaw_limited/model/allTypeIncident_model.dart';
import 'package:jsaw_limited/state/allBodyParts_state.dart';
import 'package:jsaw_limited/state/allNatureInjury_state.dart';
import 'package:jsaw_limited/state/allTypeIncident_state.dart';
import 'package:provider/provider.dart';
import '../bloc/employeeBasicDetail_bloc.dart';
import '../model/employeeBasicDetail_model.dart';
import '../service/incident_service.dart';
import '../state/employeeBasicDetail_state.dart';
import '../utils/app_color.dart';

class MedicalOfficerPage extends StatefulWidget {
  const MedicalOfficerPage({super.key});

  @override
  State<MedicalOfficerPage> createState() => _MedicalOfficerPageState();
}

class _MedicalOfficerPageState extends State<MedicalOfficerPage> {
  String selectedInjuryType = "Select Injury Type";
  String selectedBodyPaty = "Select Body Part";
  String selectedNatureOfInjury = "Select Nature Of Injury";
  String employeeName = "Select Employee Name";

  late final TextEditingController detailsController;
  late final TextEditingController dateController;
  DateTime? selectedDate;

  Map<String, String>? selectedEmployee;


  final List<Map<String, String>> employees = [
    {
      "name": "Prashant",
      "department": "CCM",
      "uniqueId": "HSM/IR&T/10/2025/01",
      "engineer": "Ravi",
      "description": "LEFT THUMB FINGER BLUNT INJURY",
      "age": "31",
      "contractor": "ABC Contractor",
    },
    {
      "name": "Ram",
      "department": "SMS",
      "uniqueId": "HSM/IR&T/10/2025/02",
      "engineer": "Amit",
      "description": "RIGHT HAND MINOR CUT",
      "age": "28",
      "contractor": "XYZ Contractor",
    },
    {
      "name": "Arjun",
      "department": "Utility",
      "uniqueId": "HSM/IR&T/10/2025/03",
      "engineer": "Suresh",
      "description": "LEG INJURY",
      "age": "35",
      "contractor": "PQR Contractor",
    },
    {
      "name": "Ravi",
      "department": "Mechanical",
      "uniqueId": "HSM/IR&T/10/2025/04",
      "engineer": "Manoj",
      "description": "HAND CUT INJURY",
      "age": "30",
      "contractor": "LMN Contractor",
    },
  ];

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text =
        "${picked.day.toString().padLeft(2, '0')}/"
            "${picked.month.toString().padLeft(2, '0')}/"
            "${picked.year}";
      });
    }
  }


  late EmployeeBasicDetailBloc employeeBasicDetailBloc;

  ValueNotifier<String> employeeId = ValueNotifier("");


  late AllNatureInjuryBloc allNatureInjuryBloc;

  ValueNotifier<String> injuryType = ValueNotifier("");

  late AllBodyPartsBloc allBodyPartsBloc;

  ValueNotifier<String> bodyPart = ValueNotifier("");

  late AllTypeIncidentBloc allTypeIncidentBloc;

  ValueNotifier<String> natureOfInjury = ValueNotifier("");



  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    detailsController = TextEditingController();

    final incidentService = Provider.of<IncidentService>(context, listen: false);

    employeeBasicDetailBloc = EmployeeBasicDetailBloc(incidentService);
    employeeBasicDetailBloc.initState();

    allNatureInjuryBloc = AllNatureInjuryBloc(incidentService);
    allNatureInjuryBloc.initState();

    allBodyPartsBloc = AllBodyPartsBloc(incidentService);
    allBodyPartsBloc.initState();

    allTypeIncidentBloc = AllTypeIncidentBloc(incidentService);
    allTypeIncidentBloc.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///Image
                SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset("assets/images/adhyamLogo.png")),
                
                /// Employee Details
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Select Employee"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildEmployeeDetail()),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/date.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Department"),
                          const SizedBox(width: 10),
                          if (selectedEmployee != null)
                            Expanded(
                              child: _buildInfoText(
                                selectedEmployee?["department"] ?? "",
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
            
                const SizedBox(height: 20),
            
                /// Unique Id + Responsible Engineer
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Unique Id"),
                          const SizedBox(width: 10),
                          if (selectedEmployee != null)
                            Expanded(
                              child: _buildInfoText(
                                selectedEmployee?["uniqueId"] ?? "",
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/date.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Responsible Engineer"),
                          const SizedBox(width: 10),
                          if (selectedEmployee != null)
                            Expanded(
                              child: _buildInfoText(
                                selectedEmployee?["engineer"] ?? "",
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
            
                const SizedBox(height: 20),
            
                /// Description + Age
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Description"),
                          const SizedBox(width: 10),
                          if (selectedEmployee != null)
                            Expanded(
                              child: _buildInfoText(
                                selectedEmployee?["description"] ?? "",
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/date.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Age"),
                          const SizedBox(width: 10),
                          if (selectedEmployee != null)
                            Expanded(
                              child: _buildInfoText(
                                selectedEmployee?["age"] ?? "",
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    
                  ],
                ),
            
                const SizedBox(height: 20),
            
                /// Type Injury + Body Part
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Type Of Injury"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildInjuryType()),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/date.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Body Part"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildBodyPart()),
                        ],
                      ),
                    ),
                  ],
                ),
            
                const SizedBox(height: 20),
            
                /// Nature of Injury + Rest Upto
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Nature Of Injury"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildNatureOfInjury()),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/date.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Rest Upto in Days"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildDetailsTextField()),
                        ],
                      ),
                    ),
                  ],
                ),
            
                const SizedBox(height: 20),
            
                Row(
                  children: [
                    SizedBox(
                      width: 500,
                      child: Row(
                        children: [
                          Image.asset("assets/images/date.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Fit for Duty from Date"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildDateTextField()),
                        ],
                      ),
                    ),
                  ],
                ),

                ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(backgroundColor: kclightOrange),
                    child: Text("Submit",style: TextStyle(color: kcWhite),)),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingText(String title) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 100,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String title) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsTextField() {
    return TextFormField(
      controller: detailsController,
      maxLines: 10,
      minLines: 1,
      decoration: InputDecoration(
        hintText: "Enter details",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }


  /// EmployeeDetails
  Widget _buildEmployeeDetail(){
    return  BlocConsumer<EmployeeBasicDetailBloc, EmployeeBasicDetailState>(
      bloc: employeeBasicDetailBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildEmployeeDetailLoding,
            content: _buildEmployeeDetailDropdown,
            success: _buildEmployeeDetailDropdown,
            failed: (form, __) => _buildEmployeeDetailDropdown(form));
      },
    );
  }

  Widget _buildEmployeeDetailLoding(List<EmployeeBasicDetailModel> employeeDetail){
    return const CircularProgressIndicator();
  }


  Widget _buildEmployeeDetailDropdown(List<EmployeeBasicDetailModel> employeeDetail) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildEmployeeDetailDialog(employeeDetail);
        },
        child: SizedBox(
          width: 200,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: kcWhite,
            ),
            child:  ValueListenableBuilder<String>(
              valueListenable: employeeId,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Unique Id" : employeeId.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (employeeId.value == "Select Unique Id") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildEmployeeDetailDialog(List<EmployeeBasicDetailModel> employeeDetail) {
    final employeeDetailListNotifier = EmployeeDetailListNotifier(employeeDetail);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Location",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: employeeDetailListNotifier.filterBasedOn,
                  decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      )),
                )
              ],
            ),
            content: SizedBox(
                width: 210,
                height: 800,
                child:ValueListenableBuilder<List<EmployeeBasicDetailModel>>(
                    valueListenable: employeeDetailListNotifier,
                    builder: (context, list, widget){
                      return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    employeeId.value = list[index].empCode;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].empName,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.8,
                                    thickness: 1,
                                    color: kcDarkGreyColor,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                )
            ),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  /// Injury Type

  Widget _buildInjuryType(){
    return  BlocConsumer<AllNatureInjuryBloc, AllNatureInjuryState>(
      bloc: allNatureInjuryBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildInjuryTypeLoding,
            content: _buildInjuryTypeDropdown,
            success: _buildInjuryTypeDropdown,
            failed: (form, __) => _buildInjuryTypeDropdown(form));
      },
    );
  }

  Widget _buildInjuryTypeLoding(List<AllNatureInjuryModel> allNatureInjury){
    return const CircularProgressIndicator();
  }


  Widget _buildInjuryTypeDropdown(List<AllNatureInjuryModel> allNatureInjury) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildInjuryTypeDialog(allNatureInjury);
        },
        child: SizedBox(
          width: 200,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: kcWhite,
            ),
            child:  ValueListenableBuilder<String>(
              valueListenable: injuryType,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Injury Type" : injuryType.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (injuryType.value == "Select Injury Type") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildInjuryTypeDialog(List<AllNatureInjuryModel> allNatureInjury) {
    final allInjuryTypeList = InjuryTypeListNotifier(allNatureInjury);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Location",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: allInjuryTypeList.filterBasedOn,
                  decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      )),
                )
              ],
            ),
            content: SizedBox(
                width: 210,
                height: 800,
                child:ValueListenableBuilder<List<AllNatureInjuryModel>>(
                    valueListenable: allInjuryTypeList,
                    builder: (context, list, widget){
                      return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    injuryType.value = list[index].description;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].description,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.8,
                                    thickness: 1,
                                    color: kcDarkGreyColor,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                )
            ),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  /// Body Part

  Widget _buildBodyPart(){
    return  BlocConsumer<AllBodyPartsBloc, AllBodyPartsState>(
      bloc: allBodyPartsBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildBodyPartLoading,
            content: _buildBodyPartDropdown,
            success: _buildBodyPartDropdown,
            failed: (form, __) => _buildBodyPartDropdown(form));
      },
    );
  }

  Widget _buildBodyPartLoading(List<AllBodyPartsModel> allBodyPart){
    return const CircularProgressIndicator();
  }


  Widget _buildBodyPartDropdown(List<AllBodyPartsModel> allBodyPart) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildBodyPartDialog(allBodyPart);
        },
        child: SizedBox(
          width: 200,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: kcWhite,
            ),
            child:  ValueListenableBuilder<String>(
              valueListenable: bodyPart,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Body Part" : bodyPart.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (bodyPart.value == "Select Body Part") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildBodyPartDialog(List<AllBodyPartsModel> allBodyPart) {
    final allBodyPartList = BodyPartListNotifier(allBodyPart);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Location",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: allBodyPartList.filterBasedOn,
                  decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      )),
                )
              ],
            ),
            content: SizedBox(
                width: 210,
                height: 800,
                child:ValueListenableBuilder<List<AllBodyPartsModel>>(
                    valueListenable: allBodyPartList,
                    builder: (context, list, widget){
                      return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    bodyPart.value = list[index].description;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].description,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.8,
                                    thickness: 1,
                                    color: kcDarkGreyColor,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                )
            ),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

/// Nature Of Injury

  Widget _buildNatureOfInjury(){
    return  BlocConsumer<AllTypeIncidentBloc, AllTypeIncidentState>(
      bloc: allTypeIncidentBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildNatureOfInjuryLoading,
            content: _buildNatureOfInjuryDropdown,
            success: _buildNatureOfInjuryDropdown,
            failed: (form, __) => _buildNatureOfInjuryDropdown(form));
      },
    );
  }

  Widget _buildNatureOfInjuryLoading(List<AllTypeIncidentModel> allTypeIncident){
    return const CircularProgressIndicator();
  }

  Widget _buildNatureOfInjuryDropdown(List<AllTypeIncidentModel> allTypeIncident) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildNatureOfInjuryDialog(allTypeIncident);
        },
        child: SizedBox(
          width: 200,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: kcWhite,
            ),
            child:  ValueListenableBuilder<String>(
              valueListenable: natureOfInjury,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Injury Nature" : natureOfInjury.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (natureOfInjury.value == "Select Injury Nature") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildNatureOfInjuryDialog(List<AllTypeIncidentModel> allTypeIncident) {
    final allTypeIncidentList = IncidentTypeNotifier(allTypeIncident);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Location",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: allTypeIncidentList.filterBasedOn,
                  decoration: const InputDecoration(
                      hintText: "search here...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcLightGrey,
                      )),
                )
              ],
            ),
            content: SizedBox(
                width: 210,
                height: 800,
                child:ValueListenableBuilder<List<AllTypeIncidentModel>>(
                    valueListenable: allTypeIncidentList,
                    builder: (context, list, widget){
                      return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    natureOfInjury.value = list[index].description;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].description,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.8,
                                    thickness: 1,
                                    color: kcDarkGreyColor,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                )
            ),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        }
    );
  }


  Widget _buildDateTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        height: 30,
        child: TextField(
          controller: dateController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: "Select date",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onTap: _pickDate,
        ),
      ),
    );
  }
}


class EmployeeDetailListNotifier extends ValueNotifier<List<EmployeeBasicDetailModel>> {

  EmployeeDetailListNotifier(super.value) {
    initialValue = value;
  }

  late List<EmployeeBasicDetailModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.empName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}


class InjuryTypeListNotifier extends ValueNotifier<List<AllNatureInjuryModel>> {

  InjuryTypeListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllNatureInjuryModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.description.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}


class BodyPartListNotifier extends ValueNotifier<List<AllBodyPartsModel>> {

  BodyPartListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllBodyPartsModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.description.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}


class IncidentTypeNotifier extends ValueNotifier<List<AllTypeIncidentModel>> {

  IncidentTypeNotifier(super.value) {
    initialValue = value;
  }

  late List<AllTypeIncidentModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.description.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}