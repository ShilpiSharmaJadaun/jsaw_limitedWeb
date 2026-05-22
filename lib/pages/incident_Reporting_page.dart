import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/employeeBasicDetail_bloc.dart';
import 'package:jsaw_limited/bloc/employeeShift_bloc.dart';
import 'package:jsaw_limited/bloc/saveIncidentReport_bloc.dart';
import 'package:jsaw_limited/model/allContractor_model.dart';
import 'package:jsaw_limited/model/employeeBasicDetail_model.dart';
import 'package:jsaw_limited/model/employeeShift_model.dart';
import 'package:jsaw_limited/service/incident_service.dart';
import 'package:jsaw_limited/state/employeeBasicDetail_state.dart';
import 'package:jsaw_limited/state/employeeShift_state.dart';
import 'package:jsaw_limited/state/saveIncidentReport_state.dart';
import 'package:provider/provider.dart';
import '../bloc/allTypeIncident_bloc.dart';
import '../bloc/employeeResponsibility_bloc.dart';
import '../bloc/location_bloc.dart';
import '../bloc/responsibleHod_bloc.dart';
import '../bloc/save_observation_bloc.dart';
import '../model/allTypeIncident_model.dart';
import '../model/employeeResponsibility_model.dart';
import '../model/location_model.dart';
import '../service/observation_service.dart';
import '../state/allTypeIncident_state.dart';
import '../state/location_state.dart';
import '../state/responsibleHOD_state.dart';
import '../utils/app_color.dart';
import 'approve_reject_table_page.dart';
import 'image_picker.dart';
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:web/web.dart' show window;
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;

import 'package:flutter/services.dart';

class IncidentReportingPage extends StatefulWidget {
  const IncidentReportingPage({super.key});

  @override
  State<IncidentReportingPage> createState() => _IncidentReportingPageState();
}

class _IncidentReportingPageState extends State<IncidentReportingPage> {

  String selectedPlant = "Select Unique Id";

  late final TextEditingController dateController;

  late final TextEditingController mobileController = TextEditingController();

  DateTime? selectedDate;

  late final TextEditingController timeController;

  TimeOfDay? selectedTime;

  late final TextEditingController detailsController;

  TextEditingController dateTimeController = TextEditingController();

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 2)),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime fullDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // 👇 only this line changes
        dateTimeController.text = DateFormat('dd-MMMM-yyyy hh:mm:ss a').format(fullDateTime);
      }
    }
  }

  late EmployeeBasicDetailBloc employeeBasicDetailBloc;

  late EmployeeShiftBloc employeeShiftBloc;

  late final LocationBloc locationBloc;

  late final EmployeeResponsibilityBloc employeeResponsibilityBloc;

  late final ResponsibleHODBloc responsibleHODBloc;

  late final SaveIncidentReportingBloc saveIncidentReportingBloc;


  late String responsibleCode;
  late String responsibleEnggDesignationCode;
  late String responsibleHODCode;


  ValueNotifier<String> employeeName = ValueNotifier("");
  ValueNotifier<String> employeeCode = ValueNotifier("");
  ValueNotifier<String> age = ValueNotifier("");
  ValueNotifier<String> plant = ValueNotifier("");
  ValueNotifier<String> plantCode = ValueNotifier("");
  ValueNotifier<String> department = ValueNotifier("");
  ValueNotifier<String> departmentId = ValueNotifier("");
  // ValueNotifier<String> responsibleEngg = ValueNotifier("");
  ValueNotifier<String> responsibleHOD = ValueNotifier("");

  ValueNotifier<String> contractorName = ValueNotifier("");

  ValueNotifier<String> contractorID = ValueNotifier("");
  ValueNotifier<String> employeeShiftDetail = ValueNotifier("");

  ValueNotifier<String> wrkGrp = ValueNotifier("");
  ValueNotifier<String> gender = ValueNotifier("");

  ValueNotifier<String> location = ValueNotifier("");

  String responsibleEngg = window.localStorage.getItem('kEmployeename') ?? "";

  late AllTypeIncidentBloc allTypeIncidentBloc;

  ValueNotifier<String> typeOfIncident = ValueNotifier("");


  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    timeController = TextEditingController();
    detailsController = TextEditingController();

    final observationService = Provider.of<ObservationService>(context, listen: false);
    final incidentService = Provider.of<IncidentService>(context, listen: false);

    employeeBasicDetailBloc = EmployeeBasicDetailBloc(incidentService);
    employeeBasicDetailBloc.initState();

    employeeShiftBloc = EmployeeShiftBloc(incidentService);
    employeeShiftBloc.initState();

    locationBloc = LocationBloc(observationService);

    employeeResponsibilityBloc = EmployeeResponsibilityBloc(observationService);

    responsibleHODBloc = ResponsibleHODBloc(observationService);
    responsibleHODBloc.initState(window.localStorage.getItem('kdepart')??"", window.localStorage.getItem('kstatCode')??"", window.localStorage.getItem('kGradeCode')??"", window.localStorage.getItem('kEmployeeCode')??"");

    String responsibleEngg = window.localStorage.getItem('kEmployeename') ?? "";

    allTypeIncidentBloc = AllTypeIncidentBloc(incidentService);
    allTypeIncidentBloc.initState();



    saveIncidentReportingBloc = SaveIncidentReportingBloc(incidentService);
  }

  Uint8List? _selectedImage;
  // Uint8List? _webImageBytes;

  final GlobalKey<ImagePickerPageState> _imagePickerKey = GlobalKey<ImagePickerPageState>();

  void _onImagePicked(dynamic image, [Uint8List? webImageBytes]) {
    setState(() {
      _selectedImage = webImageBytes;
    });
  }

  void _clearImage() {
    _imagePickerKey.currentState?.clearImage();
    // setState(() {
    //   _selectedImage = null;
    //   _webImageBytes = null;
    // });

    // Force a rebuild after a very short delay to ensure the UI updates
    Future.delayed(Duration.zero, () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: SizedBox(
                        width: 400,
                        height: 400,
                        child: ImagePickerPage(
                            key: _imagePickerKey,
                            onImagePicked: _onImagePicked)),
                  ),
                ),

                /// 🔹 Row 1 : employee name + Date (parallel)
                Row(
                  children: [

                    /// Employee
                    Expanded(
                      child: Row(
                        children: [
                          _fieldIcon(Icons.person_outline, const Color(0xFF10B981), const Color(0xFFD1FAE5)),
                          // const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Employee Name"),
                          // const SizedBox(width: 10),

                          /// IMPORTANT: wrap dropdown with Expanded
                          Expanded(child: _buildEmployeeDetail()),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: Row(
                        children: [
                          _fieldIcon(Icons.person_outline, const Color(0xFF10B981), const Color(0xFFD1FAE5)),
                          // const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Employee Code"),
                          // const SizedBox(width: 10),
                          Expanded(
                            child: ValueListenableBuilder<String>(
                              valueListenable: employeeCode, // you're storing empName here
                              builder: (_, v, __) => _buildInfoText(v.isEmpty ? "-" : v),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 20),

                /// 🔹 Row 2 : Time + Shift
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    /// Date
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _fieldIcon(Icons.calendar_today, const Color(0xFFEC4899), const Color(0xFFFCE7F3)),
                          // const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Date & Time"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildDateTime()),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    ///Contractor Name
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _fieldIcon(Icons.business_center, const Color(0xFF8B5CF6), const Color(0xFFEDE9FE)),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          _buildHeadingText("Contractor Name"),
                          Expanded(
                            child: ValueListenableBuilder<String>(
                              valueListenable: contractorName, // you're storing empName here
                              builder: (_, v, __) => _buildInfoText(v.isEmpty ? "-" : v),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 20),

                /// 🔹 Row 3 : Shift + Employee Name

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    ///shift
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _fieldIcon(Icons.filter_tilt_shift, const Color(0xFFF97316), const Color(0xFFFFEDD5)),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          _buildHeadingText("Shift"),
                          Expanded(child: _buildEmployeeShift()),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: Row(
                        children: [
                          _fieldIcon(Icons.person_outline, const Color(0xFFEAB308), const Color(0xFFFEF3C7)),
                          // const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Age"),
                          // const SizedBox(width: 10),
                          Expanded(
                            child: ValueListenableBuilder<String>(
                              valueListenable: age, // you're storing empName here
                              builder: (_, v, __) => _buildInfoText(v.isEmpty ? "-" : v),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// 🔹 Gender (dropdown) + Work Group (auto from employee)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          _fieldIcon(Icons.wc, const Color(0xFFEC4899), const Color(0xFFFCE7F3)),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          _buildHeadingText("Gender"),
                          Expanded(child: _buildGenderDropdown()),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        children: [
                          _fieldIcon(Icons.groups, const Color(0xFF6366F1), const Color(0xFFE0E7FF)),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          _buildHeadingText("Work Group"),
                          Expanded(
                            child: ValueListenableBuilder<String>(
                              valueListenable: wrkGrp,
                              builder: (_, v, __) => _buildInfoText(v.isEmpty ? "-" : v),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// Row 5 : Plant + Dept
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _fieldIcon(Icons.apartment, const Color(0xFF6366F1), const Color(0xFFE0E7FF)),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          _buildHeadingText("Plant"),
                          Expanded(
                            child: ValueListenableBuilder<String>(
                              valueListenable: department, // you're storing empName here
                              builder: (_, v, __) => _buildInfoText(v.isEmpty ? "-" : v),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        children: [
                          _fieldIcon(Icons.factory, const Color(0xFFEC4899), const Color(0xFFFCE7F3)),
                          // const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Department Name"),
                          // const SizedBox(width: 10),
                          Expanded(
                            child: ValueListenableBuilder<String>(
                              valueListenable: plant, // you're storing empName here
                              builder: (_, v, __) => _buildInfoText(v.isEmpty ? "-" : v),
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),

                const SizedBox(height: 20),

                ///Row 6 :  Location+ Responsible Shit Engg

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          _fieldIcon(Icons.location_on_outlined, const Color(0xFFEF4444), const Color(0xFFFEE2E2)),
                          // const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Location "),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildLocation()),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _fieldIcon(Icons.eco_outlined, const Color(0xFF10B981), const Color(0xFFD1FAE5)),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          _buildHeadingText("Responsible Shift Engg"),
                          Expanded(child: _buildInfoText(responsibleEngg)),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// ROw 7 : Responsible HOD + Contact Num

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          _fieldIcon(Icons.groups_outlined, const Color(0xFF06B6D4), const Color(0xFFCFFAFE)),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Responsible HOD "),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildResponsibleHOD()),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _fieldIcon(Icons.phone_outlined, const Color(0xFFF97316), const Color(0xFFFFEDD5)),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          _buildHeadingText("Contact Number"),
                          Expanded(child: _buildContactTextField()),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Row 9 : incident Details and FIR date and time

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          _fieldIcon(Icons.groups_outlined, const Color(0xFF06B6D4), const Color(0xFFCFFAFE)),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Type of Incident "),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildAllTypeOfIncident()),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          _fieldIcon(Icons.description_outlined, const Color(0xFFEC4899), const Color(0xFFFCE7F3)),
                          // const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Descp. of Incident"),
                          // const SizedBox(width: 10),
                          Expanded(child:  _buildDetailsTextField()),
                        ],
                      ),
                    ),
                  ],
                ),



                const SizedBox(height: 20),

                _buildSaveIncident(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _fieldIcon(IconData icon, Color fg, Color bg) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, color: fg, size: 20),
    );
  }

  /// clean values

  void _resetForm() {
    // Text controllers — clear form inputs only
    dateController.clear();
    timeController.clear();
    detailsController.clear();
    mobileController.clear();
    dateTimeController.clear();

    // ValueNotifiers (dropdowns & info fields from employee selection)
    employeeName.value = "";
    employeeCode.value = "";
    age.value = "";
    plant.value = "";
    plantCode.value = "";
    department.value = "";
    departmentId.value = "";
    contractorName.value = "";
    contractorID.value = "";
    employeeShiftDetail.value = "";
    location.value = "";
    typeOfIncident.value = "";
    responsibleHOD.value = "";
    wrkGrp.value = "";
    gender.value = "";

    // NOTE: responsibleEngg is NOT cleared — it comes from localStorage (logged-in user)
    // NOTE: responsibleHODCode is tied to the HOD dropdown selection, so clear it
    responsibleHODCode = "";

    // Image
    _clearImage();
    _selectedImage = null;

    // Reset date/time picker state
    selectedDate = null;
    selectedTime = null;

    setState(() {});
  }

  ///Submit

  _buildSaveIncident(){
    return BlocConsumer<SaveIncidentReportingBloc, SaveIncidentReportingState>(
      bloc: saveIncidentReportingBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message ?? "Data Saved Successfully")
            ));
            _resetForm();
            //context.go('/register_observation_page');
          },
          failed: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: (_) {
            return const Center(child: CircularProgressIndicator());
          },
          orElse: () {
            return Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEC4899), Color(0xFFF97316)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEC4899).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    if (_selectedImage == null || _selectedImage!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select the incident image first."),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }
                    await saveIncidentReportingBloc.saveObservation(
                       _selectedImage ?? Uint8List(0),
                      dateTimeController.text,
                      employeeShiftDetail.value,
                      employeeCode.value,
                      employeeName.value,
                      age.value,
                      gender.value,
                      wrkGrp.value,
                      contractorName.value,
                      contractorID.value,
                      department.value,
                      departmentId.value,
                      plant.value,
                      plantCode.value,
                      location.value,
                      responsibleEngg,
                      responsibleHOD.value,
                      mobileController.text,
                      typeOfIncident.value,
                      detailsController.text
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.save_outlined, color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        Text("Save Incident",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
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
              valueListenable: employeeName,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Employee ID" : employeeName.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (employeeName.value == "Select Employee ID") ? kcDarkGreyColor : kcLightGrey),
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
                                    employeeName.value = list[index].empName;
                                    employeeCode.value = list[index].empCode;
                                    age.value = list[index].age.toString();
                                    contractorName.value = list[index].contName;
                                    contractorID.value = list[index].contCode;
                                    plant.value = list[index].statName;
                                    plantCode.value = list[index].statCode;
                                    department.value = list[index].deptName;
                                    departmentId.value = list[index].deptCode;
                                    wrkGrp.value = list[index].wrkGrp;
                                    locationBloc.initState(departmentId.value);

                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].empName +" ("+ list[index].empCode +")"),
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


  /// Employee Shift

  Widget _buildEmployeeShift(){
    return  BlocConsumer<EmployeeShiftBloc, EmployeeShiftState>(
      bloc: employeeShiftBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildEmployeeShiftLaoding,
            content: _buildEmployeeShiftDropdown,
            success: _buildEmployeeShiftDropdown,
            failed: (form, __) => _buildEmployeeShiftDropdown(form));
      },
    );
  }

  Widget _buildEmployeeShiftLaoding(List<EmployeeShiftModel> employeeShift){
    return const CircularProgressIndicator();
  }


  Widget _buildEmployeeShiftDropdown(List<EmployeeShiftModel> employeeShift) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildEmployeeShiftDialog(employeeShift);
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
              valueListenable: employeeShiftDetail,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Employee Shift" : employeeShiftDetail.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (employeeName.value == "Select Employee Shift") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildEmployeeShiftDialog(List<EmployeeShiftModel> employeeShift) {
    final employeeShiftNotifier = EmployeeShiftListNotifier(employeeShift);
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
                  onChanged: employeeShiftNotifier.filterBasedOn,
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
                child:ValueListenableBuilder<List<EmployeeShiftModel>>(
                    valueListenable: employeeShiftNotifier,
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
                                    employeeShiftDetail.value = list[index].shiftDesc;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].shiftDesc,
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

///Location

  //location

  Widget _buildLocation(){
    return  BlocConsumer<LocationBloc, LocationState>(
      bloc: locationBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading7,
            content: _buildContent7,
            success: _buildContent7,
            failed: (form, __) => _buildContent7(form));
      },
    );
  }

  Widget _buildLoading7(List<LocationModel> locationModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent7(List<LocationModel> locationModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildLocationDialog(locationModel);
        },
        child: SizedBox(
          width: 180,
          height: 40,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: location,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        value.isEmpty ?  "Select Location" : location.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (location.value == "Select Location") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildLocationDialog(List<LocationModel> locationModel) {
    final locationListNotifier = LocationSearchableListNotifier(locationModel);
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
                  onChanged: locationListNotifier.filterBasedOn,
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
                child:ValueListenableBuilder<List<LocationModel>>(
                    valueListenable: locationListNotifier,
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
                                    location.value = list[index].locations;
                                    employeeResponsibilityBloc.initState(window.localStorage.getItem('kdeptCode') ?? "", window.localStorage.getItem('kstatCode')?? "",window.localStorage.getItem('kGradeCode') ?? "");

                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].locations,
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

  // Responsibility

  // Widget _buildResponsibility(){
  //   return  BlocConsumer<EmployeeResponsibilityBloc, EmployeeResponsibilityState>(
  //     bloc: employeeResponsibilityBloc,
  //     listener: (_, state){},
  //     builder: (_, state){
  //       return state.when(
  //           loading: _buildLoading3,
  //           content: _buildContent3,
  //           success: _buildContent3,
  //           failed: (form, __) => _buildContent3(form));
  //     },
  //   );
  // }
  //
  // Widget _buildLoading3(List<EmployeeResponsibilityModel> responsibilityModel){
  //   return const CircularProgressIndicator();
  // }
  //
  // Widget _buildContent3(List<EmployeeResponsibilityModel> responsibilityModel){
  //   return Padding(
  //     padding: const EdgeInsets.all(2),
  //     child: InkWell(
  //       onTap: (){
  //         _buildResponsibilityDialog(responsibilityModel);
  //
  //       },
  //       child: SizedBox(
  //         width: 180,
  //         height: 40,
  //         child: Container(
  //           width: 80,
  //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
  //           child: ValueListenableBuilder<String>(
  //             valueListenable: responsibleEngg,
  //             builder: (context, value, child) => Padding(
  //               padding: const EdgeInsets.all(2.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   SizedBox(
  //                     width: 100,
  //                     child: Text(
  //                       value.isEmpty ?  "Select Responsible Person" : responsibleEngg.value,
  //                       textAlign: TextAlign.center,
  //                       maxLines: 4,
  //                       style: TextStyle(color: (responsibleEngg.value == "Select Responsible Engg") ? kcDarkGreyColor : kcLightGrey),
  //                     ),
  //                   ),
  //                   const Icon(Icons.arrow_drop_down_sharp)
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Future<void> _buildResponsibilityDialog(List<EmployeeResponsibilityModel> responsibilityModel) {
  //   final responsibilityListNotifier = responsibilitySearchableListNotifier(responsibilityModel);
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
  //           title: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const Text(
  //                 "Select or search Responsibility",
  //                 style:
  //                 TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //               ),
  //               TextFormField(
  //                 onChanged: responsibilityListNotifier.filterBasedOn,
  //                 decoration: const InputDecoration(
  //                     hintText: "search here...",
  //                     prefixIcon: Icon(
  //                       Icons.search,
  //                       color: kcLightGrey,
  //                     )),
  //               )
  //             ],
  //           ),
  //           content: SizedBox(
  //               width: 210,
  //               height: 800,
  //               child:ValueListenableBuilder<List<EmployeeResponsibilityModel>>(
  //                   valueListenable: responsibilityListNotifier,
  //                   builder: (context, list, widget){
  //                     return ListView.builder(
  //                         itemCount: list.length,
  //                         shrinkWrap: true,
  //                         itemBuilder: (context, index) {
  //                           return Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               InkWell(
  //                                 onTap: () {
  //                                   responsibleHOD.value = "";
  //                                   responsibleCode = list[index].empUnqId;
  //                                   responsibleEnggDesignationCode = list[index].gradeCode;
  //                                   responsibleHODBloc.initState(window.localStorage.getItem('kdepart')??"", window.localStorage.getItem('kstatCode')??"", responsibleEnggDesignationCode, responsibleCode);
  //                                   Navigator.pop(context);
  //                                 },
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.all(2.0),
  //                                   child: Text(list[index].empName,
  //                                   ),
  //                                 ),
  //                               ),
  //                               const Padding(
  //                                 padding: EdgeInsets.all(8.0),
  //                                 child: Divider(
  //                                   height: 0.8,
  //                                   thickness: 1,
  //                                   color: kcDarkGreyColor,
  //                                 ),
  //                               )
  //                             ],
  //                           );
  //                         });
  //                   }
  //               )
  //           ),
  //           actions: [
  //             Align(
  //               alignment: Alignment.centerRight,
  //               child: TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text(
  //                   "close",
  //                   style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
  //                 ),
  //               ),
  //             )
  //           ],
  //         );
  //       }
  //   );
  // }

  //Responsible HOD


  /// Responsible HOD

  Widget _buildResponsibleHOD(){
    return  BlocConsumer<ResponsibleHODBloc, ResponsibleHODState>(
      bloc: responsibleHODBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading5,
            content: _buildContent5,
            success: _buildContent5,
            failed: (form, __) => _buildContent5(form));
      },
    );
  }

  Widget _buildLoading5(List<EmployeeResponsibilityModel> responsibilityModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent5(List<EmployeeResponsibilityModel> responsibilityModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildResponsibilityBYHODDialog(responsibilityModel);
        },
        child: SizedBox(
          width: 180,
          height: 40,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: responsibleHOD,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        value.isEmpty ?  "Select Responsible HOD" : responsibleHOD.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (responsibleHOD.value == "Select Responsible HOD") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildResponsibilityBYHODDialog(List<EmployeeResponsibilityModel> responsibleHodModel) {
    final responsibilityListNotifier = responsibleHODySearchableListNotifier(responsibleHodModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Responsible HOD",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: responsibilityListNotifier.filterBasedOn,
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
                child:ValueListenableBuilder<List<EmployeeResponsibilityModel>>(
                    valueListenable: responsibilityListNotifier,
                    builder: (context, responsibleList, widget){
                      return ListView.builder(
                          itemCount: responsibleList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    responsibleHOD.value = responsibleList[index].empName;
                                    responsibleHODCode = responsibleList[index].empUnqId;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(responsibleList[index].empName,
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

  Widget _buildAllTypeOfIncident(){
    return  BlocConsumer<AllTypeIncidentBloc, AllTypeIncidentState>(
      bloc: allTypeIncidentBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildAllTypeOfIncidentLoading,
            content: _buildAllTypeOfIncidentDropdown,
            success: _buildAllTypeOfIncidentDropdown,
            failed: (form, __) => _buildAllTypeOfIncidentDropdown(form));
      },
    );
  }

  Widget _buildAllTypeOfIncidentLoading(List<AllTypeIncidentModel> allTypeIncident){
    return const CircularProgressIndicator();
  }

  Widget _buildAllTypeOfIncidentDropdown(List<AllTypeIncidentModel> allTypeIncident) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildAllTypeOfIncidentDialog(allTypeIncident);
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
              valueListenable: typeOfIncident,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Type of Incident" : typeOfIncident.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (typeOfIncident.value == "Select Type of Incident") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildAllTypeOfIncidentDialog(List<AllTypeIncidentModel> allTypeIncident) {
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
                                    typeOfIncident.value = list[index].description;
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


  _buildDateTime(){
    return SizedBox(
      height: 36,
      child: GestureDetector(
        onTap: () => _selectDateTime(context),
        child: AbsorbPointer(
          child: TextField(
            controller: dateTimeController,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: kcvoilet,
            ),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              hintText: "Select Date & Time",
              hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kcVeryLightGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kcVeryLightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color:kcVeryLightGrey),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildHeadingText(String title){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 120,
        child: Text(title, style: const TextStyle( fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black),),
      ),
    );
  }

  Widget _buildInfoText(String title) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: kcWhite,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        title,
        maxLines: 2,
        style: const TextStyle(fontSize: 13, color: Colors.black),
        overflow: TextOverflow.ellipsis,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  Widget _buildContactTextField() {
    return TextFormField(
      controller: mobileController,
      maxLines: 10,
      minLines: 1,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),   // adjust as needed
      ],
      decoration: InputDecoration(
        hintText: "Enter details",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }



  Widget _buildGenderDropdown() {
    const options = ["Male", "Female"];
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () async {
          final selected = await showDialog<String>(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                title: const Text(
                  "Select Gender",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                content: SizedBox(
                  width: 210,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: options.map((opt) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context, opt),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(opt),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Divider(
                              height: 0.8,
                              thickness: 1,
                              color: kcDarkGreyColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "close",
                      style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                    ),
                  ),
                ],
              );
            },
          );
          if (selected != null) {
            gender.value = selected;
          }
        },
        child: SizedBox(
          width: 200,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: kcWhite,
            ),
            child: ValueListenableBuilder<String>(
              valueListenable: gender,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        value.isEmpty ? "Select Gender" : value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(
                          color: value.isEmpty ? kcDarkGreyColor : kcLightGrey,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down_sharp),
                  ],
                ),
              ),
            ),
          ),
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
      final q = query.toLowerCase();
      value = initialValue.where((e) =>
          e.empName.toLowerCase().contains(q) ||
          e.empCode.toLowerCase().contains(q)).toList();
    }
    notifyListeners();
  }
}

class AllContractorListNotifier extends ValueNotifier<List<AllContractorModel>> {

  AllContractorListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllContractorModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.contName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class EmployeeShiftListNotifier extends ValueNotifier<List<EmployeeShiftModel>> {

  EmployeeShiftListNotifier(super.value) {
    initialValue = value;
  }

  late List<EmployeeShiftModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.shiftDesc.toLowerCase().contains(query.toLowerCase())).toList();
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