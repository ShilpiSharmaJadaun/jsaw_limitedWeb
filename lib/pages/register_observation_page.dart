import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/allhazard_cat_bloc.dart';
import 'package:jsaw_limited/bloc/alltype_hazard_bloc.dart';
import 'package:jsaw_limited/bloc/location_bloc.dart';
import 'package:jsaw_limited/bloc/planthead_bloc.dart';
import 'package:jsaw_limited/bloc/priority_bloc.dart';
import 'package:jsaw_limited/bloc/responsibleHod_bloc.dart';
import 'package:jsaw_limited/bloc/save_observation_bloc.dart';
import 'package:jsaw_limited/model/allhazard_cat_model.dart';
import 'package:jsaw_limited/model/alltype_hazard_model.dart';
import 'package:jsaw_limited/model/allwork_group_model.dart';
import 'package:jsaw_limited/model/location_model.dart';
import 'package:jsaw_limited/model/plantHead_model.dart';
import 'package:jsaw_limited/model/priority_model.dart';
import 'package:jsaw_limited/model/unithead_model.dart';
import 'package:jsaw_limited/pages/image_picker.dart';
import 'package:jsaw_limited/service/dashboard_service.dart';
import 'package:jsaw_limited/state/allhazard_cat_state.dart';
import 'package:jsaw_limited/state/alltype_hazard_state.dart';
import 'package:jsaw_limited/state/location_state.dart';
import 'package:jsaw_limited/state/plantHead_state.dart';
import 'package:jsaw_limited/state/priority_state.dart';
import 'package:jsaw_limited/state/responsibleHOD_state.dart';
import 'package:jsaw_limited/state/save_observation_state.dart';
import 'package:provider/provider.dart';
import '../bloc/allDepart_bloc.dart';
import '../bloc/allplant_bloc.dart';
import '../bloc/employeeResponsibility_bloc.dart';
import '../bloc/observationby_uni_bloc.dart';
import '../model/allDepartment_model.dart';
import '../model/allplant_model.dart';
import '../model/employeeResponsibility_model.dart';
import '../service/observation_service.dart';
import '../state/allDepart_state.dart';
import '../state/allplant_state.dart';
import '../state/employeeResponsibility_state.dart';
import '../utils/app_color.dart';
import 'dart:html';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'dart:html' as html;

class RegisterObservationPage extends StatefulWidget {
  const RegisterObservationPage({super.key});

  @override
  State<RegisterObservationPage> createState() => _RegisterObservationPageState();
}

class _RegisterObservationPageState extends State<RegisterObservationPage> {


  late final ObservationbyUniBloc observationbyUniBloc;

  late final AllPlantBloc allPlantBloc;

  late final AllDepartBloc allDepartBloc;

  late final EmployeeResponsibilityBloc employeeResponsibilityBloc;

  late final PriorityBloc priorityBloc;

  late final LocationBloc locationBloc;

  late final AllHazardCatBloc allHazardCatBloc;

  late final SaveObservationBloc saveObservationBloc;

  late final AllTypeHazardBloc allTypeHazardBloc;

  late final ResponsibleHODBloc responsibleHODBloc;

  late final PlantHeadBloc plantHeadBloc;

  // late final UnitHeadBloc unitHeadBloc;


  ValueNotifier<String> workGroup = ValueNotifier("Select Work Group");
  ValueNotifier<String> plant = ValueNotifier("Select Plant");
  ValueNotifier<String> plantHeadName = ValueNotifier("");
  // ValueNotifier<String> unitHeadName = ValueNotifier("");
  ValueNotifier<String> stat = ValueNotifier("Select Department");
  ValueNotifier<String> responsibility = ValueNotifier("");
  ValueNotifier<String> responsibleHOD = ValueNotifier("");
  ValueNotifier<String> priority = ValueNotifier("Select Priority");
  ValueNotifier<String> priorityDesc = ValueNotifier("Deadline");
  ValueNotifier<String> location = ValueNotifier("");
  ValueNotifier<String> hazard = ValueNotifier("");
  ValueNotifier<String> hazardType = ValueNotifier("");
  ValueNotifier<String> unitEmpName = ValueNotifier("");

  TextEditingController observationController = TextEditingController();
  TextEditingController correctiveMeasureController = TextEditingController();
  TextEditingController rootCauseController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();

  late String employeeName;
  late String employeeCode;
  late String statCode;
  late String departCode;
  late String responsibleCode;
  late String responsibleEnggCode;
  late String responsibleHODCode = "";
  late String priorityColor = "";
  late String plantHeadCode = "";
  late String plantHeadEmail ="";
  late String responsibleEnggDesignationCode = "";
  // late String unitHeadCode = "";
  late String unitPlantName = "";
  late String unitEmpUnqId = "";
  late String unitEmpEmail = "";

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

        dateTimeController.text = DateFormat('yyyy-MM-dd HH:mm:ss').format(fullDateTime);
      }
    }
  }

  @override
  void initState(){
    super.initState();
    final observationService = Provider.of<ObservationService>(context, listen: false);
    final dashboardService = Provider.of<DashboardService>(context, listen: false);
    allPlantBloc = AllPlantBloc(observationService);
    allPlantBloc.initState();
    allDepartBloc = AllDepartBloc(observationService);
    employeeResponsibilityBloc = EmployeeResponsibilityBloc(observationService);
    employeeName = window.localStorage['kEmployeename'] ?? "";
    employeeCode = window.localStorage['kEmployeeCode'] ?? "";
    priorityBloc = PriorityBloc(observationService);
    priorityBloc.initState();
    locationBloc = LocationBloc(observationService);
    allHazardCatBloc = AllHazardCatBloc(dashboardService);
    allHazardCatBloc.initState();
    allTypeHazardBloc = AllTypeHazardBloc(observationService);
    allTypeHazardBloc.initState();
    saveObservationBloc = SaveObservationBloc(observationService);
    responsibleHODBloc = ResponsibleHODBloc(observationService);
    plantHeadBloc = PlantHeadBloc(observationService);
    // unitHeadBloc = UnitHeadBloc(observationService);
  }

  Uint8List? _selectedImage;
  Uint8List? _webImageBytes;

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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildObservation()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObservation() {
    return Card(
      color: kcWhite,
      margin:  const EdgeInsets.all(50),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/plant.png",
                          scale: 20,
                        ),
                        const Text(
                          " *", // The red star
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        _buildHeadingText("Plant :"),

                        Container(
                            width: 250,
                            decoration: BoxDecoration(border:Border.all(color: kcDarkGreyColor), borderRadius: BorderRadius.circular(5)),
                            child: _buildPlant()
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/responsibility.png",
                          scale: 20,
                        ),
                        Text(
                          " *", // The red star
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        _buildHeadingText("Resp. By Engineer"),
                        Container(
                          width: 250,
                          decoration: BoxDecoration(border:Border.all(color: kcDarkGreyColor), borderRadius: BorderRadius.circular(5)),
                          child: _buildResponsibility(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/observation.png",
                          scale: 20,
                        ),
                        Text(
                          " *", // The red star
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        _buildHeadingText("Priority :"),
                        Container(
                          width: 250,
                          decoration: BoxDecoration(border:Border.all(color: kcDarkGreyColor), borderRadius: BorderRadius.circular(5)),
                          child:  _buildPriority(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/location.png",
                          scale: 20,
                        ),
                        Text(
                          " *", // The red star
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        _buildHeadingText("Location :"),
                        Container(
                          width: 250,
                          decoration: BoxDecoration(border:Border.all(color: kcDarkGreyColor), borderRadius: BorderRadius.circular(5)),
                          child: _buildLocation(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/hazard.png",
                          scale: 20,
                        ),
                        Text(
                          " *", // The red star
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        _buildHeadingText("Hazard  Category :"),
                        Container(
                          width: 250,
                          decoration: BoxDecoration(border:Border.all(color: kcDarkGreyColor), borderRadius: BorderRadius.circular(5)),
                          child: _buildHazard(),
                        )
                      ],
                    ),
                  ),
                  if (html.window.localStorage['khseCode'] == '1' || html.window.localStorage['kempAuthPlantHead'] == '1')
                    Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/plant.png",
                          scale: 20,
                        ),
                        _buildHeadingText("Plant Head :"),
                        Container(
                            width: 250,
                            decoration: BoxDecoration(border:Border.all(color: kcDarkGreyColor), borderRadius: BorderRadius.circular(5)),
                            child: _buildPlantHead()
                        )
                      ],
                    ),
                  ),

                  if(hazardType.value == "Near Miss")
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/plant.png",
                            scale: 20,
                          ),
                          Text(
                            " *", // The red star
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                          _buildHeadingText("Root Cause"),
                          _buildRootCauseTextFiled()
                        ],
                      ),
                    ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/uniqueid.png",
                          scale: 20,
                        ),
                        Text(
                          " *", // The red star
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        _buildHeadingText("Department : "),
                        Container(
                          width: 250,
                          decoration: BoxDecoration(border:Border.all(color: kcDarkGreyColor), borderRadius: BorderRadius.circular(5)),
                          child: _buildDepartment(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/responsibility.png",
                          scale: 20,
                        ),
                        Text(
                          " *", // The red star
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        _buildHeadingText("Resp. By HOD"),
                        Container(
                            width: 250,
                            decoration: BoxDecoration(border:Border.all(color: kcDarkGreyColor), borderRadius: BorderRadius.circular(5)),
                            child: _buildResponsibleHOD()
                        )

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/hazard.png",
                          scale: 20,
                        ),
                        Text(
                          " *", // The red star
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        _buildHeadingText("Hazard Type"),
                        Container(
                            width: 250,
                            decoration: BoxDecoration(border:Border.all(color: kcDarkGreyColor), borderRadius: BorderRadius.circular(5)),
                            child: _buildAllTypeHazard()
                        )

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/responsibility.png",
                          scale: 20,
                        ),
                        Text(
                          " *", // The red star
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        _buildHeadingText("Observation"),
                        _buildTextFiled()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/responsibility.png",
                          scale: 20,
                        ),
                        Text(
                          " *", // The red star
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        _buildHeadingText("Corrective Measure"),
                        _buildCorrectiveMeasureTextFiled()
                      ],
                    ),
                  ),
                  // if (html.window.localStorage['khseCode'] == '1' || html.window.localStorage['kempAuthPlantHead'] == '1')
                  //   Padding(
                  //     padding: const EdgeInsets.all(20.0),
                  //     child: Row(
                  //       children: [
                  //         Image.asset(
                  //           "assets/images/plant.png",
                  //           scale: 20,
                  //         ),
                  //         _buildHeadingText("Unit Head :"),
                  //         Container(
                  //             width: 250,
                  //             decoration: BoxDecoration(border:Border.all(color: kcDarkGreyColor), borderRadius: BorderRadius.circular(5)),
                  //             child: _buildUnitHead()
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/calendar-3.png",
                          scale: 20,
                        ),
                        Text(
                          " *", // The red star
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        _buildHeadingText("Date & Time of Occurrence"),
                        _buildTime()
                      ],
                    ),
                  ),

                ],
              )
            ],
          ),
          _buildSubmitButton()
        ],
      ),
    );
  }

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }

  //time of occurrence

  _buildTime(){
    return SizedBox(
      width: 250,
      child: GestureDetector(
        onTap: () => _selectDateTime(context),
        child: AbsorbPointer(
          child: TextField(
            controller: dateTimeController,
            textAlign: TextAlign.start,
            minLines: 1,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: kcvoilet,
            ),
            decoration: InputDecoration(
              hintText: "Time of Occurrence",
              contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
              hintStyle: const TextStyle(
                fontSize: 12,
                color: kcMediumGrey,
              ),
              fillColor: Colors.transparent,
              filled: true,
              border: _border(),
              focusedBorder: _border(),
              enabledBorder: _border(),
            ),
          ),
        ),
      ),
    );
  }

  _buildSubmitButton() {
    return BlocConsumer<SaveObservationBloc, SaveObservationState>(
      bloc: saveObservationBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message ?? "Data Saved Successfully")
            ));
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
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // Group all validation checks in one block
                    if (priority.value == "Select Priority") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select Priority")),
                      );
                    } else if (_selectedImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select an image")),
                      );
                    } else if (responsibility.value == "Select Responsibility") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select Responsible Engineer.")),
                      );
                    } else if (employeeCode.isEmpty || employeeName.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please try after Re-Login")),
                      );
                    } else if (plant.value.isEmpty || departCode.isEmpty || location.value.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please ensure all plant details are provided")),
                      );
                    } else if (observationController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please provide observation details")),
                      );
                    } else if (responsibleCode.isEmpty || responsibleHOD.value.isEmpty || responsibleHODCode.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please ensure responsible engineer details are provided")),
                      );
                    } else if (stat.value.isEmpty || statCode.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please ensure status details are provided")),
                      );
                    } else if (hazard.value.isEmpty || hazardType.value.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please ensure hazard details are provided")),
                      );
                    } else if (workGroup.value.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select a work group")),
                      );
                    } else if (correctiveMeasureController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please provide corrective measures")),
                      );
                    }
                    else if (dateTimeController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please provide a date and time of Observation")),
                      );
                    } else if (hazardType.value == "Near Miss" && rootCauseController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill the root cause")),
                      );
                    } else {
                      // Call the API function only if all fields are valid
                      await saveObservationBloc.saveObservation(
                          _selectedImage!,
                          employeeName,
                          employeeCode,
                          plant.value,
                          departCode,
                          location.value,
                          observationController.text,
                          responsibility.value,
                          responsibleCode,
                          responsibleHOD.value,
                          responsibleHODCode,
                          stat.value,
                          statCode,
                          priority.value,
                          "",
                          hazard.value,
                          "PENDING",
                          workGroup.value,
                          priorityColor,
                          "",
                          "",
                          hazardType.value,
                          correctiveMeasureController.text,
                          plantHeadCode,
                          plantHeadName.value,
                          plantHeadEmail,
                          dateTimeController.text,
                          "",
                          "",
                          unitEmpName.value,
                          unitEmpUnqId,
                          unitEmpEmail,
                        rootCauseController.text
                      );

                      // Clear the image and form values after the submission
                      _clearImage();
                      clearFormValues();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: kcobservationgreen),
                  child: const Text(
                    "Raise Observation",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


  void clearFormValues() {
    // Reset ValueNotifier values
    workGroup.value = "";
    plant.value = "";
    stat.value = "";
    responsibility.value = "";
    responsibleHOD.value = "";
    priority.value = "Select Priority";
    priorityDesc.value = "Deadline";
    location.value = "";
    hazard.value = "";
    hazardType.value = "";
    unitEmpName.value = "";


    // Clear TextEditingControllers
    observationController.clear();
    correctiveMeasureController.clear();

    // Reset late-initialized String values

    statCode = "";
    departCode = "";
    responsibleCode = "";
    responsibleHODCode = "";
    priorityColor = "";
    plantHeadName.value="";
    // unitHeadName.value = "";
    dateTimeController.clear();
  }

  _buildTextFiled(){
    return SizedBox(
      width: 250,
      child: TextField(
        controller: observationController,
        textAlign: TextAlign.start,
        maxLines: null,
        minLines: 1,
        style: const TextStyle(
            fontSize:  18,
            fontWeight: FontWeight.w500,
            color: kcvoilet
        ),
        decoration: InputDecoration(
            hintText: "Write Observation",
            contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
            hintStyle:  const TextStyle(
                fontSize: 12,
                color: kcMediumGrey
            ),
            fillColor: Colors.transparent,
            filled: true,
            border: _border(),
            focusedBorder: _border(),
            enabledBorder: _border()
        ),
      ),
    );
  }

  _buildCorrectiveMeasureTextFiled(){
    return SizedBox(
      width: 250,
      child: TextField(
        controller: correctiveMeasureController,
        textAlign: TextAlign.start,
        maxLines: null,
        minLines: 1,
        style: const TextStyle(
            fontSize:  18,
            fontWeight: FontWeight.w500,
            color: kcvoilet
        ),
        decoration: InputDecoration(
            hintText: "Write Corrective Measure Taken",
            contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
            hintStyle:  const TextStyle(
                fontSize: 12,
                color: kcMediumGrey
            ),
            fillColor: Colors.transparent,
            filled: true,
            border: _border(),
            focusedBorder: _border(),
            enabledBorder: _border()
        ),
      ),
    );
  }


  _buildRootCauseTextFiled(){
    return SizedBox(
      width: 250,
      child: TextField(
        controller: rootCauseController,
        textAlign: TextAlign.start,
        maxLines: null,
        minLines: 1,
        style: const TextStyle(
            fontSize:  18,
            fontWeight: FontWeight.w500,
            color: kcvoilet
        ),
        decoration: InputDecoration(
            hintText: "Write  Root Cause",
            contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
            hintStyle:  const TextStyle(
                fontSize: 12,
                color: kcMediumGrey
            ),
            fillColor: Colors.transparent,
            filled: true,
            border: _border(),
            focusedBorder: _border(),
            enabledBorder: _border()
        ),
      ),
    );
  }

  _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide:   const BorderSide(color: kcDarkGreyColor,width: 1.5)
  );

  // All Plant APi Implementation

  Widget _buildPlant(){
    return  BlocConsumer<AllPlantBloc, AllPlantState>(
      bloc: allPlantBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading1,
            content: _buildContent1,
            success: _buildContent1,
            failed: (form, __) => _buildContent1(form));
      },
    );
  }

  Widget _buildLoading1(List<AllPlantModel> model){
    return const CircularProgressIndicator();
  }

  Widget _buildContent1(List<AllPlantModel> model){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: (){
          _buildallPlantListDialog(model);
        },
        child: SizedBox(
          width: 150,
          height: 30,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: plant,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        plant.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (plant.value == "Select Plant") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildallPlantListDialog(List<AllPlantModel> model) {
    final listNotifier = SearchableListNotifier(model);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // actionsPadding: EdgeInsets.all(5.dw),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            // contentPadding: EdgeInsets.all(10.dw),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search plant",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: listNotifier.filterBasedOn,
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
                width: 200,
                height: 800,
                child:ValueListenableBuilder<List<AllPlantModel>>(
                    valueListenable: listNotifier,
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
                                    clearFormValues();
                                    plant.value = list[index].deptName;
                                    departCode = list[index].deptCode;
                                    allDepartBloc.initState(departCode);
                                    locationBloc.initState(departCode);
                                    plantHeadBloc.initState(departCode);
                                    // unitHeadBloc.initState(departCode);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].deptName,),
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

  //plant Head

  Widget _buildPlantHead(){
    return  BlocConsumer<PlantHeadBloc, PlantHeadState>(
      bloc: plantHeadBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading9,
            content: _buildContent9,
            success: _buildContent9,
            failed: (form, __) => _buildContent9(form));
      },
    );
  }

  Widget _buildLoading9(List<PlantHeadModel> model){
    return const CircularProgressIndicator();
  }

  Widget _buildContent9(List<PlantHeadModel> model){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: (){
          _buildallPlantHeadListDialog(model);
        },
        child: SizedBox(
          width: 150,
          height: 30,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: plantHeadName,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 140,
                      child: Text(
                        value.isEmpty ?  "Select Plant Head" : plantHeadName.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (plantHeadName.value == "Select Plant Head") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildallPlantHeadListDialog(List<PlantHeadModel> plantHeadModel) {
    final listNotifier = PlantHeadSearchableListNotifier(plantHeadModel);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          content: SizedBox(
            width: 200,
            height: 800,
            child: ValueListenableBuilder<List<PlantHeadModel>>(
                valueListenable: listNotifier,
                builder: (context, list, widget){
                  return ListView.builder(
                      itemCount: list.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                // You can handle the tap here, e.g., update ValueNotifier
                                plantHeadName.value = plantHeadModel[index].empName;
                                plantHeadCode = plantHeadModel[index].empUnqId;
                                plantHeadEmail = plantHeadModel[index].empEmail;// Update the selected plant
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  plantHeadModel[index].empName,  // Show plant name
                                  style: const TextStyle(fontSize: 16),
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
                  "Close",
                  style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  // //unit Head
  //
  // Widget _buildUnitHead(){
  //   return  BlocConsumer<UnitHeadBloc, UnitHeadState>(
  //     bloc: unitHeadBloc,
  //     listener: (_, state){},
  //     builder: (_, state){
  //       return state.when(
  //           loading: _buildLoading10,
  //           content: _buildContent10,
  //           success: _buildContent10,
  //           failed: (form, __) => _buildContent10(form));
  //     },
  //   );
  // }
  //
  // Widget _buildLoading10(List<UnitHeadModel> model){
  //   return const CircularProgressIndicator();
  // }
  //
  // Widget _buildContent10(List<UnitHeadModel> model){
  //   return Padding(
  //     padding: const EdgeInsets.all(5),
  //     child: InkWell(
  //       onTap: (){
  //         _buildallUnitHeadListDialog(model);
  //       },
  //       child: SizedBox(
  //         width: 150,
  //         height: 30,
  //         child: Container(
  //           width: 80,
  //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
  //           child: ValueListenableBuilder<String>(
  //             valueListenable: unitEmpName,
  //             builder: (context, value, child) => Padding(
  //               padding: const EdgeInsets.all(2.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   SizedBox(
  //                     width: 140,
  //                     child: Text(
  //                       value.isEmpty ?  "Select Unit Head" : unitEmpName.value,
  //                       textAlign: TextAlign.center,
  //                       maxLines: 4,
  //                       style: TextStyle(color: (unitEmpName.value == "Select Unit Head") ? kcDarkGreyColor : kcLightGrey),
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
  //
  // }
  //
  // Future<void> _buildallUnitHeadListDialog(List<UnitHeadModel> plantHeadModel) {
  //   final listNotifier = UnitHeadSearchableListNotifier(plantHeadModel);
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(5)),
  //         ),
  //         content: SizedBox(
  //             width: 200,
  //             height: 800,
  //             child: ValueListenableBuilder<List<UnitHeadModel>>(
  //                 valueListenable: listNotifier,
  //                 builder: (context, list, widget){
  //                   return ListView.builder(
  //                       itemCount: list.length,
  //                       shrinkWrap: true,
  //                       itemBuilder: (context, index) {
  //                         return
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               InkWell(
  //                                 onTap: () {
  //                                   // You can handle the tap here, e.g., update ValueNotifier
  //                                   unitHeadName.value = plantHeadModel[index].unitPlantName;
  //                                   unitHeadCode = plantHeadModel[index].unitPlantCode;
  //                                   unitEmpName.value = plantHeadModel[index].unitEmpName;// Update the selected plant
  //                                   unitEmpUnqId = plantHeadModel[index].unitEmpUnqId;// Update the selected plant
  //                                   unitEmpEmail = plantHeadModel[index].unitEmpEmail;// Update the selected plant
  //                                   Navigator.pop(context);
  //                                 },
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.all(2.0),
  //                                   child: Text(
  //                                     plantHeadModel[index].unitEmpName,  // Show plant name
  //                                     style: const TextStyle(fontSize: 16),
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
  //                       });
  //                 }
  //             )
  //
  //
  //         ),
  //         actions: [
  //           Align(
  //             alignment: Alignment.centerRight,
  //             child: TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text(
  //                 "Close",
  //                 style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


  // //ALl Work Group
  //
  // Widget _buildWorkGroup(){
  //   return  BlocConsumer<AllWorkGroupBloc, AllWorkGroupState>(
  //     bloc: allWorkGroupBloc,
  //     listener: (_, state){},
  //     builder: (_, state){
  //       return state.when(
  //           loading: _buildLoading2,
  //           content: _buildContent2,
  //           success: _buildContent2,
  //           failed: (form, __) => _buildContent2(form));
  //     },
  //   );
  // }
  //
  // Widget _buildLoading2(List<AllWorkGroupModel> model){
  //   return const CircularProgressIndicator();
  // }
  //
  // Widget _buildContent2(List<AllWorkGroupModel> workModel){
  //   return Padding(
  //     padding: const EdgeInsets.all(5),
  //     child: InkWell(
  //       onTap: (){
  //         _buildallWorkGroupListDialog(workModel);
  //       },
  //       child: SizedBox(
  //         width: 150,
  //         height: 30,
  //         child: Container(
  //           width: 80,
  //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
  //           child: ValueListenableBuilder<String>(
  //             valueListenable: workGroup,
  //             builder: (context, value, child) => Padding(
  //               padding: const EdgeInsets.all(2.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   SizedBox(
  //                     width: 100,
  //                     child: Text(
  //                       workGroup.value,
  //                       textAlign: TextAlign.center,
  //                       maxLines: 4,
  //                       style: TextStyle(color: (workGroup.value == "Select Work Group") ? kcDarkGreyColor : kcLightGrey),
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
  //
  // }
  //
  // Future<void> _buildallWorkGroupListDialog(List<AllWorkGroupModel> workModel) {
  //   final listNotifier = WorkGroupSearchableListNotifier(workModel);
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           // actionsPadding: EdgeInsets.all(5.dw),
  //           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
  //           // contentPadding: EdgeInsets.all(10.dw),
  //           title: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const Text(
  //                 "Select or search Work Group",
  //                 style:
  //                 TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //               ),
  //               TextFormField(
  //                 onChanged: listNotifier.filterBasedOn,
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
  //               width: 200,
  //               height: 800,
  //               child:ValueListenableBuilder<List<AllWorkGroupModel>>(
  //                   valueListenable: listNotifier,
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
  //
  //                                   allPlantBloc.initState();
  //                                   Navigator.pop(context);
  //                                 },
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.all(2.0),
  //                                   child: Text(list[index].wrkGrp,),
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

  // _buildObservationCard() {
  //   return Card(
  //     elevation: 2,
  //     color: kcWhite,
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Column(
  //                 // mainAxisAlignment: MainAxisAlignment.start,
  //                 // crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.all(1.screenWidth),
  //                     child: Image.asset(
  //                       alignment: Alignment.center,
  //                       "assets/images/peopleimage.jpg",
  //                       //fit: BoxFit.cover,
  //                       scale: 1.5.screenWidth,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           _buildHeadingText("Raised By"),
  //                           _buildHeadingText("-"),
  //                           _buildRaisedByTypeDropDown()
  //                         ],
  //                       ),
  //                       SizedBox(width: 200),
  //                       Row(
  //                         children: [
  //                           _buildHeadingText("Unique Identification no."),
  //                           _buildHeadingText("-"),
  //                           _buildTextBox("HSM/SO/3/2024", Colors.black),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           _buildHeadingText("Date"),
  //                           _buildHeadingText("-"),
  //                           _buildTextBox("04.03.2024", kcRed),
  //                         ],
  //                       ),
  //                       SizedBox(width: 260),
  //                       Row(
  //                         children: [
  //                           _buildHeadingText("Responsibility"),
  //                           _buildHeadingText("-"),
  //                           _buildTextBox("Mr. M Narayana", kcmegenta),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                   Row(
  //                     children: [
  //                       _buildHeadingText("Location"),
  //                       _buildHeadingText("-"),
  //                       _buildLocationTypeDropDown(),
  //                       SizedBox(width: 205),
  //                       Row(
  //                         children: [
  //                           _buildHeadingText("Plant / Dept"),
  //                           _buildHeadingText("-"),
  //                           _buildPlantTypeDropDown(),
  //
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                   Row(
  //                     children: [
  //                       _buildHeadingText("Category"),
  //                       _buildHeadingText("-"),
  //                       _buildCategoryTypeDropDown(),
  //                     ],
  //                   ),
  //                   Center(child: Container(height: 0.1.screenHeight,alignment: Alignment.center,color: kcVeryLightGrey,width: 140.screenWidth,)),
  //
  //                 ],
  //               ),
  //
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               _buildHeadingText("Observation"),
  //               SizedBox(
  //                 width: 100.screenWidth,
  //                 child: Padding(
  //                   padding: EdgeInsets.all(1.0.screenWidth),
  //                   child: Text(
  //                     "Oil spillage was found at gas regulating valve 1 area, at BF stove",
  //                     maxLines: 3,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 1.8.screenWidth,color: kcvoilet),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               _buildHeadingText("Corrective Action Taken/Suggested"),
  //               SizedBox(
  //                 width: 100.screenWidth,
  //                 child: Padding(
  //                   padding: EdgeInsets.all(1.0.screenWidth),
  //                   child: Text(
  //                     "it should be cleaned, to avoid slip & trip hazard",
  //                     maxLines: 3,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 1.8.screenWidth,color: kcvoilet),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Department APi Implementation

  //All Department

  Widget _buildDepartment(){
    return  BlocConsumer<AllDepartBloc, AllDepartState>(
      bloc: allDepartBloc,
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

  Widget _buildLoading4(List<AllDepartmentModel> departModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent4(List<AllDepartmentModel> departModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          if(departCode.isEmpty){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Select Plant")));
          }else{
            _buildallDepartDialog(departModel);
          }

        },
        child: SizedBox(
          width: 200,
          height: 40,
          child: Container(
            width: 80,
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
                        stat.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (stat.value == "Select Department") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildallDepartDialog(List<AllDepartmentModel> departModel) {
    final departListNotifier = departmentSearchableListNotifier(departModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // actionsPadding: EdgeInsets.all(5.dw),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            // contentPadding: EdgeInsets.all(10.dw),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Department",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: departListNotifier.filterBasedOn,
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
                child:ValueListenableBuilder<List<AllDepartmentModel>>(
                    valueListenable: departListNotifier,
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
                                    responsibility.value = "";
                                    responsibleCode = "";
                                    responsibleHOD.value = "";
                                    responsibleHODCode = "";
                                    stat.value = list[index].statName;
                                    statCode = list[index].statCode;
                                    employeeResponsibilityBloc.initState(departCode, statCode,window.localStorage['kGradeCode']!);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].statName,
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

  Widget _buildResponsibility(){
    return  BlocConsumer<EmployeeResponsibilityBloc, EmployeeResponsibilityState>(
      bloc: employeeResponsibilityBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading3,
            content: _buildContent3,
            success: _buildContent3,
            failed: (form, __) => _buildContent3(form));
      },
    );
  }

  Widget _buildLoading3(List<EmployeeResponsibilityModel> responsibilityModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent3(List<EmployeeResponsibilityModel> responsibilityModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildResponsibilityDialog(responsibilityModel);

        },
        child: SizedBox(
          width: 180,
          height: 40,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: responsibility,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        value.isEmpty ?  "Select Responsible Person" : responsibility.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (responsibility.value == "Select Responsibility") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildResponsibilityDialog(List<EmployeeResponsibilityModel> responsibilityModel) {
    final responsibilityListNotifier = responsibilitySearchableListNotifier(responsibilityModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Responsibility",
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
                                    responsibleHOD.value = "";
                                    responsibleHODCode = "";
                                    responsibility.value = list[index].empName;
                                    responsibleCode = list[index].empUnqId;
                                    workGroup.value = list[index].wrkGrp;
                                    responsibleEnggDesignationCode = list[index].gradeCode;
                                    responsibleHODBloc.initState(departCode, statCode, responsibleEnggDesignationCode, responsibleCode);
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

  //Responsible HOD

  Widget _buildResponsibleHOD(){
    return  BlocConsumer<ResponsibleHODBloc, ResponsibleHODState>(
      bloc: responsibleHODBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading5,
            content: _buildContent5,
            success: _buildContent5,
            failed: (form, __) => _buildContent3(form));
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

  //Priority

  Widget _buildPriority(){
    return  BlocConsumer<PriorityBloc, PriorityState>(
      bloc: priorityBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading6,
            content: _buildContent6,
            success: _buildContent6,
            failed: (form, __) => _buildContent6(form));
      },
    );
  }

  Widget _buildLoading6(List<PriorityModel> priorityModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent6(List<PriorityModel> priorityModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildPriorityDialog(priorityModel);
        },
        child: SizedBox(
          width: 180,
          height: 50,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: priority,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Column(
                        children: [
                          Text(
                            priority.value,
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            style: TextStyle(color: (priority.value == "Select Priority") ? kcDarkGreyColor : hexToColor(priorityColor)),
                          ),
                          Text(
                            priorityDesc.value,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(color: (priorityDesc.value == "Deadline") ? kcDarkGreyColor : kcRed,fontSize: 12),
                          ),
                        ],
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

  Future<void> _buildPriorityDialog(List<PriorityModel> priorityModel) {
    final priorityListNotifier = PrioritySearchableListNotifier(priorityModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Prioroty",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: priorityListNotifier.filterBasedOn,
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
                child:ValueListenableBuilder<List<PriorityModel>>(
                    valueListenable: priorityListNotifier,
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
                                    priority.value = list[index].priorityStatusName;
                                    priorityDesc.value = list[index].priorityStatusDeadline;
                                    priorityColor = list[index].priorityStatusColour;
                                    Navigator.pop(context);
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(list[index].priorityStatusName,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(list[index].priorityStatusDeadline,
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

  //Hazard

  Widget _buildHazard(){
    return  BlocConsumer<AllHazardCatBloc, AllHazardCatState>(
      bloc: allHazardCatBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading8,
            content: _buildContent8,
            success: _buildContent8,
            failed: (form, __) => _buildContent8(form));
      },
    );
  }

  Widget _buildLoading8(List<AllHazardCatModel> hazardModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent8(List<AllHazardCatModel> hazardModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildHazardDialog(hazardModel);
        },
        child: SizedBox(
          width: 180,
          height: 40,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: hazard,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        value.isEmpty ?  "Select Hazard Category" : hazard.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (hazard.value == "Select Hazard Category") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildHazardDialog(List<AllHazardCatModel> hazardModel) {
    final hazardListNotifier = HazardSearchableListNotifier(hazardModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Hazard Category",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: hazardListNotifier.filterBasedOn,
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
                child:ValueListenableBuilder<List<AllHazardCatModel>>(
                    valueListenable: hazardListNotifier,
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
                                    hazard.value = list[index].hazardCategoryName;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].hazardCategoryName,
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

  //All Type Hazard

  Widget _buildAllTypeHazard(){
    return  BlocConsumer<AllTypeHazardBloc, AllTypeHazardState>(
      bloc: allTypeHazardBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildAllTypeLoading,
            content: _buildAllTypeContent,
            success: _buildAllTypeContent,
            failed: (form, __) => _buildAllTypeContent(form));
      },
    );
  }

  Widget _buildAllTypeLoading(List<AllTypeHazardModel> allHazardModel){
    return const CircularProgressIndicator();
  }

  Widget _buildAllTypeContent(List<AllTypeHazardModel> allHazardModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildAllTypeHazardDialog(allHazardModel);
        },
        child: SizedBox(
          width: 180,
          height: 40,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: hazardType,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        value.isEmpty ?  "Select Hazard Type" : hazardType.value,

                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (hazardType.value == "Select Hazard Type") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildAllTypeHazardDialog(List<AllTypeHazardModel> allHazardModel) {
    final hazardTypeListNotifier = HazardTypeSearchableListNotifier(allHazardModel);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search Hazard Type",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  onChanged: hazardTypeListNotifier.filterBasedOn,
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
                child:ValueListenableBuilder<List<AllTypeHazardModel>>(
                    valueListenable: hazardTypeListNotifier,
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
                                    hazardType.value = list[index].categoryName;
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].categoryName,
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

  _buildHeadingText(String title){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 100,
        child: Text(title, style: const TextStyle( fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black),),
      ),
    );
  }

}

class SearchableListNotifier extends ValueNotifier<List<AllPlantModel>> {
  SearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllPlantModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.deptName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class departmentSearchableListNotifier extends ValueNotifier<List<AllDepartmentModel>> {

  departmentSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllDepartmentModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.statName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }

}

class responsibilitySearchableListNotifier extends ValueNotifier<List<EmployeeResponsibilityModel>> {

  responsibilitySearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<EmployeeResponsibilityModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.empName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class responsibleHODySearchableListNotifier extends ValueNotifier<List<EmployeeResponsibilityModel>> {

  responsibleHODySearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<EmployeeResponsibilityModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.empName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class WorkGroupSearchableListNotifier extends ValueNotifier<List<AllWorkGroupModel>> {

  WorkGroupSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllWorkGroupModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.wrkGrp.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class PrioritySearchableListNotifier extends ValueNotifier<List<PriorityModel>> {

  PrioritySearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<PriorityModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.priorityStatusName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class LocationSearchableListNotifier extends ValueNotifier<List<LocationModel>> {

  LocationSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<LocationModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.locations.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class HazardSearchableListNotifier extends ValueNotifier<List<AllHazardCatModel>> {

  HazardSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllHazardCatModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.hazardCategoryName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class HazardTypeSearchableListNotifier extends ValueNotifier<List<AllTypeHazardModel>> {

  HazardTypeSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllTypeHazardModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.categoryName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

class PlantHeadSearchableListNotifier extends ValueNotifier<List<PlantHeadModel>> {

  PlantHeadSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<PlantHeadModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.plantName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}


class UnitHeadSearchableListNotifier extends ValueNotifier<List<UnitHeadModel>> {

  UnitHeadSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<UnitHeadModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.unitPlantName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

