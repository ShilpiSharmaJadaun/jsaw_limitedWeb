import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/allDepart_bloc.dart';
import 'package:jsaw_limited/bloc/allplant_bloc.dart';
import 'package:jsaw_limited/bloc/changeobservationimage_bloc.dart';
import 'package:jsaw_limited/bloc/employeeResponsibility_bloc.dart';
import 'package:jsaw_limited/bloc/observationby_uni_bloc.dart';
import 'package:jsaw_limited/bloc/priority_bloc.dart';
import 'package:jsaw_limited/bloc/update_observation_bloc.dart';
import 'package:jsaw_limited/utils/progressive_image.dart';
import 'package:jsaw_limited/model/allplant_model.dart';
import 'package:jsaw_limited/model/employeeResponsibility_model.dart';
import 'package:jsaw_limited/model/filterObservation_model.dart';
import 'package:jsaw_limited/model/observationby_uni_model.dart';
import 'package:jsaw_limited/state/allDepart_state.dart';
import 'package:jsaw_limited/state/allplant_state.dart';
import 'package:jsaw_limited/state/changeobservationimage_state.dart';
import 'package:jsaw_limited/state/employeeResponsibility_state.dart';
import 'package:jsaw_limited/state/observationby_uni_state.dart';
import 'package:jsaw_limited/state/update_observation_state.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../bloc/allhazard_cat_bloc.dart';
import '../bloc/location_bloc.dart';
import '../bloc/responsibleHod_bloc.dart';
import '../model/allDepartment_model.dart';
import '../model/allhazard_cat_model.dart';
import '../model/location_model.dart';
import '../model/priority_model.dart';
import '../service/dashboard_service.dart';
import '../service/observation_service.dart';
import '../state/allhazard_cat_state.dart';
import '../state/location_state.dart';
import '../state/priority_state.dart';
import '../state/responsibleHOD_state.dart';
import '../utils/app_color.dart';
import '../utils/page_header.dart';
import 'package:web/web.dart' show window;
import 'dart:typed_data';

import 'image_picker.dart';

class EditRaisedObservationsPage extends StatefulWidget {
   EditRaisedObservationsPage({super.key,  required this.filterObservationModel
   });

   FilterObservationModel filterObservationModel;
  @override
  State<EditRaisedObservationsPage> createState() => _EditRaisedObservationsPageState();
}

class _EditRaisedObservationsPageState extends State<EditRaisedObservationsPage> {


  late final ObservationbyUniBloc observationbyUniBloc;

  late final AllPlantBloc allPlantBloc;

  late final AllDepartBloc allDepartBloc;

  late final EmployeeResponsibilityBloc employeeResponsibilityBloc;

  late final LocationBloc locationBloc;

  late final UpdateObservationBloc updateObservationBloc;
  
  late final PriorityBloc priorityBloc;

  late final AllHazardCatBloc allHazardCatBloc;

  late ChangeObservationImageBloc changeObservationImageBloc;

  late final ResponsibleHODBloc responsibleHODBloc;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late ObservationService observationService = ObservationService();

  late final TextEditingController correctiveMeasureController;

  late final TextEditingController observationTextController;

  ValueNotifier<String> plant = ValueNotifier("Select Plant");
  ValueNotifier<String> department = ValueNotifier("Select Department");
  ValueNotifier<String> responsibility = ValueNotifier("Select Responsibility");
  ValueNotifier<String> location = ValueNotifier("Select Location");
  ValueNotifier<String> responsibleHOD = ValueNotifier("Select Responsible HOD");
  ValueNotifier<String> priority = ValueNotifier("Select Priority");
  ValueNotifier<String> priorityDesc = ValueNotifier("Select Priority");
  ValueNotifier<String> hazard = ValueNotifier("Select Hazard");

  late var workGroup ="";
  late var plantCode ="";
  late var departCode = "";
  late var stateCode = "";
  late String statCode;
  late var responsibleEnggCode= "";
  late var responsibleHODCode= "";
  late String priorityColor ="";
  late String responsibleEnggDesignationCode = "";


  late String _imageUrl;


  @override
  void initState(){
    super.initState();
    final observationService = Provider.of<ObservationService>(context, listen: false);
    final dashboardService = Provider.of<DashboardService>(context, listen: false);
    observationbyUniBloc = ObservationbyUniBloc(observationService);
    observationbyUniBloc.initState(widget.filterObservationModel.uniqueIdentificationNumber.toString(), widget.filterObservationModel.observationRaisedBy.toString());
    allPlantBloc = AllPlantBloc(observationService);
    allPlantBloc.initState();
    allDepartBloc = AllDepartBloc(observationService);
    responsibleHODBloc = ResponsibleHODBloc(observationService);
    workGroup = widget.filterObservationModel.wrkGrp.toString();
    employeeResponsibilityBloc = EmployeeResponsibilityBloc(observationService);
    locationBloc = LocationBloc(observationService);
    locationBloc.initState(widget.filterObservationModel.plantDeptCode.toString());
    updateObservationBloc = UpdateObservationBloc(observationService);
    allHazardCatBloc = AllHazardCatBloc(dashboardService);
    allHazardCatBloc.initState();
    priorityBloc = PriorityBloc(observationService);
    priorityBloc.initState();
    plant = ValueNotifier<String>(widget.filterObservationModel.plantDept.toString());
    department = ValueNotifier<String>(widget.filterObservationModel.stationName.toString());
    responsibility =  ValueNotifier<String> (widget.filterObservationModel.responsibility.toString());
    location = ValueNotifier<String>(widget.filterObservationModel.location.toString());
    responsibleHOD = ValueNotifier<String>(widget.filterObservationModel.responsibilityHODName.toString());
    priority = ValueNotifier<String> (widget.filterObservationModel.priorityStatusName.toString());
    priorityDesc = ValueNotifier<String> (widget.filterObservationModel.priorityStatusName.toString());
    hazard = ValueNotifier<String>(widget.filterObservationModel.hazardCategory.toString());
    changeObservationImageBloc = ChangeObservationImageBloc(observationService);

    // Initialize _imageUrl with the initial image URL from the model
    _imageUrl = widget.filterObservationModel.imageNumber;

    correctiveMeasureController = TextEditingController(
      text: widget.filterObservationModel.correctiveMeasure?.toString() ?? "",
    );

    observationTextController = TextEditingController(
      text: widget.filterObservationModel.observationText?.toString() ?? "",
    );
  }

  Uint8List? _selectedImage;
  Uint8List? _webImageBytes;

  dynamic _onImagePicked(dynamic image, [Uint8List? webImageBytes]) {
    setState(() {
      _selectedImage = webImageBytes; // Save the selected image
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SubPageHeader("Edit Observations"),
              _buildObservation(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              ),
              _buildObservationByUni()
            ],
          ),
        ),
      ),
    );
  }

  _buildObservationByUni(){
    return BlocConsumer<ObservationbyUniBloc, ObservationbyUniState>(
      bloc: observationbyUniBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading,
            content: _buildContent,
            success: _buildContent,
            failed: (form, __) => _buildContent(form));
      },
    );
  }

  Widget _buildLoading(List<ObservationbyUniModel> model){
    return const CircularProgressIndicator();
  }

  Widget _buildContent(List<ObservationbyUniModel> model){
    return ListView.builder(
      itemCount: model.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _buildHistoryCard(model[index]);
      },
    );
  }

  Widget _buildHistoryCard(ObservationbyUniModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kcVeryLightGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 180,
                height: 160,
                child: ProgressiveImage(
                  highUrl: item.imageCompliance,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.event_note_outlined, kcStatAmber),
                            const SizedBox(width: 8),
                            _buildLabel("Date :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                  item.updatedDate.isEmpty ? '—' : item.updatedDate,
                                  kcStatAmber),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.person_outline_rounded, kcStatBlue),
                            const SizedBox(width: 8),
                            _buildLabel("Action By :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                  item.updatedByEmpName.isEmpty
                                      ? '—'
                                      : item.updatedByEmpName,
                                  kcStatBlue),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(
                                Icons.workspace_premium_outlined, _statusColor(item.status)),
                            const SizedBox(width: 8),
                            _buildLabel("Status :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                  item.status.isEmpty ? '—' : item.status,
                                  _statusColor(item.status)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.grey.shade300,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildHistoryParagraph(
                    icon: Icons.visibility_outlined,
                    iconColor: kcObservationCyan,
                    label: "Observation",
                    text: item.observationText,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 6),
                  _buildHistoryParagraph(
                    icon: Icons.build_outlined,
                    iconColor: kcStatPurple,
                    label: "Action Taken",
                    text: item.actionTaken,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 6),
                  _buildHistoryParagraph(
                    icon: Icons.sticky_note_2_outlined,
                    iconColor: kcvoilet,
                    label: "Remark",
                    text: item.remarks,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryParagraph({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String text,
    int maxLines = 3,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIconBadge(icon, iconColor),
        const SizedBox(width: 8),
        _buildLabel("$label :"),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              text.isEmpty ? '—' : text,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: kcValueDark,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildHeadingText2(String title){
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

  _buildTextBox2(String title, Color color){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.only(left: 3, right: 3),
        child: SizedBox(
          width: 300,
          child: Text(title,
            maxLines: 4,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: color),),
        ),
      ),
    );
  }

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF' + hexString;
    }
    return Color(int.parse(hexString, radix: 16));
  }

  _buildObservation() {
    final model = widget.filterObservationModel;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kcVeryLightGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 220,
                    height: 200,
                    child: ProgressiveImage(
                      highUrl: model.imageNumber,
                      lowUrl: model.lowQualityImageUrl,
                    ),
                  ),
                ),
                if (model.status != "COMPLIANCE" && model.status != "CLOSED")
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ElevatedButton.icon(
                      onPressed: () => _showChangeImageDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kcRed,
                        foregroundColor: kcWhite,
                        fixedSize: const Size(220, 36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.image_outlined, size: 16),
                      label: const Text(
                        "Change Image",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top: 3 columns × 3 rows grid
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              icon: Icons.person_outline_rounded,
                              iconColor: kcStatBlue,
                              label: "Raised By",
                              value: model.observationRaisedBy.toString(),
                              valueColor: kcValueDark,
                            ),
                            _buildInteractiveSection(
                              icon: Icons.factory_outlined,
                              iconColor: kcStatGreen,
                              label: "Plant / Dept",
                              child: _buildPlant(),
                            ),
                            _buildInteractiveSection(
                              icon: Icons.assignment_ind_outlined,
                              iconColor: kcStatPurple,
                              label: "Responsibility",
                              child: _buildResponsibility(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              icon: Icons.qr_code_2_outlined,
                              iconColor: kcvoilet,
                              label: "Unique ID",
                              value: model.uniqueIdentificationNumber.toString(),
                              valueColor: kcValueDark,
                            ),
                            _buildInteractiveSection(
                              icon: Icons.apartment_outlined,
                              iconColor: kcStatBlue,
                              label: "Department",
                              child: _buildDepartment(),
                            ),
                            _buildInteractiveSection(
                              icon: Icons.supervisor_account_outlined,
                              iconColor: kcvoilet,
                              label: "Res. HOD",
                              child: _buildResponsibleHOD(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              icon: Icons.workspace_premium_outlined,
                              iconColor: _statusColor(model.status.toString()),
                              label: "Status",
                              value: model.status.toString(),
                              valueColor: _statusColor(model.status.toString()),
                            ),
                            _buildInteractiveSection(
                              icon: Icons.location_on_outlined,
                              iconColor: kcStatRed,
                              label: "Location",
                              child: _buildLocation(),
                            ),
                            _buildInteractiveSection(
                              icon: Icons.warning_amber_outlined,
                              iconColor: kcStatAmber,
                              label: "Hazard",
                              child: _buildHazard(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Soft gradient divider
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.grey.shade300,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Date pills
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.event_note_outlined, kcStatAmber),
                            const SizedBox(width: 8),
                            _buildLabel("Raised Date :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                  model.raisedDate.toString(), kcStatAmber),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.event_outlined, kcvoilet),
                            const SizedBox(width: 8),
                            _buildLabel("Target Date :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                model.observationCompletionTargetDate.toString().isEmpty
                                    ? '—'
                                    : model.observationCompletionTargetDate.toString(),
                                kcvoilet,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.event_available_outlined, kcStatGreen),
                            const SizedBox(width: 8),
                            _buildLabel("Compliance Date :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                model.complianceDate.toString().trim().isEmpty
                                    ? '—'
                                    : model.complianceDate.toString(),
                                model.complianceDate.toString().trim().isEmpty
                                    ? kcLightGrey
                                    : kcStatGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.flag_outlined, kcStatAmber),
                            const SizedBox(width: 8),
                            _buildLabel("Priority :"),
                            const SizedBox(width: 6),
                            Flexible(child: _buildPriorityPill()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Observation (editable)
                  _buildEditableTextRow(
                    icon: Icons.visibility_outlined,
                    iconColor: kcObservationCyan,
                    label: "Observation",
                    controller: observationTextController,
                    hint: "Enter observation text",
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  // Corrective Measure (editable)
                  _buildEditableTextRow(
                    icon: Icons.build_outlined,
                    iconColor: kcStatPurple,
                    label: "Corrective Measure",
                    controller: correctiveMeasureController,
                    hint: "Enter corrective measure",
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  // Update button
                  if (model.status != "COMPLIANCE" && model.status != "CLOSED")
                    Align(
                      alignment: Alignment.centerRight,
                      child: _buildUpdate(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangeImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Change Image"),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SizedBox(
                  width: 400,
                  height: 400,
                  child: ImagePickerPage(onImagePicked: _onImagePicked)),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: (){

                  _uploadNewImage();
                },
                style: ElevatedButton.styleFrom(backgroundColor: kcRed),
                child: Text("Upload New Image",style: TextStyle(color: kcWhite),)),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _uploadNewImage() async {
    if (_selectedImage != null) {
      try {
        // Perform the image upload
        await changeObservationImageBloc.saveObservation(
          _selectedImage!,
          widget.filterObservationModel.uniqueIdentificationNumber,
        );

       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image Updated Succcessfully")));
        Navigator.pop(context); // Close the dialog
        Navigator.pop(context, true); // Close the dialog
      } catch (e) {
        print("Error uploading image: $e");
      }
    } else {
      print("Error: _selectedImage is null");
    }
  }





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
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: (){
         _buildallPlantListDialog(model);
        },
        child: SizedBox(
          width: 150,
          height: 40,
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
                        style: TextStyle(color: (plant.value == widget.filterObservationModel.plantDept) ? kcDarkGreyColor : kcLightGrey),
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
                                    plant.value = list[index].deptName;
                                    plantCode = list[index].deptCode;
                                    allDepartBloc.initState(plantCode);
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

  //department

  Widget _buildDepartment(){
    return  BlocConsumer<AllDepartBloc, AllDepartState>(
      bloc: allDepartBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildLoading2,
            content: _buildContent2,
            success: _buildContent2,
            failed: (form, __) => _buildContent2(form));
      },
    );
  }

  Widget _buildLoading2(List<AllDepartmentModel> departModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent2(List<AllDepartmentModel> departModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildallDepartDialog(departModel);
        },
        child: SizedBox(
          width: 100,
          height: 40,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: department,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        department.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (department.value == "Select Department") ? kcDarkGreyColor : kcLightGrey),
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
                                    department.value = list[index].statName;
                                    stateCode = list[index].statCode;
                                    departCode = list[index].deptCode;
                                    employeeResponsibilityBloc.initState(departCode, stateCode,window.localStorage.getItem('kDesgnCode')!);
                                    locationBloc.initState(departCode);
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
          width: 160,
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
                        responsibility.value,
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
                                    responsibility.value = list[index].empName;
                                    responsibleEnggCode = list[index].empUnqId;
                                    responsibleEnggDesignationCode = list[index].gradeCode;
                                    responsibleHODBloc.initState(departCode, stateCode, responsibleEnggDesignationCode, responsibleEnggCode);
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
                        responsibleHOD.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (responsibleHOD.value == widget.filterObservationModel.responsibilityHODName) ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildResponsibilityBYHODDialog(List<EmployeeResponsibilityModel> responsibilityModel) {
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
                                    responsibleHOD.value = list[index].empName;
                                    responsibleHODCode = list[index].empUnqId;
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
                      width: 150,
                      child: Text(
                        priority.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (priority.value == "Select Priority") ? kcDarkGreyColor : kcLightGrey),
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
                  "Select or search Priority",
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

  //Location

  Widget _buildLocation(){
    return  BlocConsumer<LocationBloc, LocationState>(
      bloc: locationBloc,
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

  Widget _buildLoading4(List<LocationModel> locationModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent4(List<LocationModel> locationModel){
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
                      width: 150,
                      child: Text(
                        location.value,
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
                      width: 150,
                      child: Text(
                        hazard.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (hazard.value == "Select Location") ? kcDarkGreyColor : kcLightGrey),
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
                  "Select or search Hazard",
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

  _buildUpdate() {
    return BlocConsumer<UpdateObservationBloc, UpdateObservationState>(
      bloc: updateObservationBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message ?? "Data Saved Successfully"),
            ));
            observationbyUniBloc.initState(widget.filterObservationModel.uniqueIdentificationNumber.toString(), widget.filterObservationModel.observationRaisedBy.toString());
            // context.go('/edit_observation?uniqueId=${widget.filterObservationModel.uniqueIdentificationNumber}'
            //     '&raisedBy=${widget.filterObservationModel.observationRaisedBy}&wrkGrp=${widget.filterObservationModel.wrkGrp}&deptCode=$departCode&stateCode=${widget.filterObservationModel.stationCode}');
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
            final cm = correctiveMeasureController.text.trim().isEmpty
                ? (widget.filterObservationModel.correctiveMeasure?.toString() ?? "")
                : correctiveMeasureController.text.trim();
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final data = {
                      "uniqueIdentificationNumber": widget.filterObservationModel.uniqueIdentificationNumber ??"",
                      "plantDept": plant.value ?? "",
                      "plantDeptCode": departCode,
                      "location": location.value,
                      "observationText": observationTextController.text.trim().isEmpty
                          ? widget.filterObservationModel.observationText
                          : observationTextController.text.trim(),
                      "correctiveMeasure": correctiveMeasureController.text.trim().isEmpty
                          ? widget.filterObservationModel.correctiveMeasure
                          : correctiveMeasureController.text.trim(),
                      "responsibility": responsibility.value,
                      "responsibilityEnggCode": responsibleEnggCode,
                      "hazardCategory": hazard.value,
                      "priorityStatusName": priority.value,
                      "priorityStatusColour": priorityColor,
                      "responsibilityHODName": responsibleHOD.value,
                      "responsibilityHODEmpUnqID": responsibleHODCode,
                      "wrkGrp": widget.filterObservationModel.wrkGrp,
                      "station_Code": departCode,
                      "stationName": department.value,
                    };
                    await updateObservationBloc.updateObservation(data);
                  },
                  child: const Text("Update Changes"),
                ),
              ),
            );
          },
        );
      },
    );
  }

  _buildHeadingText(String title){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(title, style: const TextStyle( fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black),),
    );
  }

  _buildTextBox(String title, Color color){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(width: 20.screenWidth,
        child: Text(title,
          maxLines: 4,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: color),),
      ),
    );
  }

  // ─── Card-style helpers (matches receivedObservation.dart) ───

  Color _statusColor(String status) {
    switch (status.trim().toUpperCase()) {
      case 'CLOSED':
        return kcStatGreen;
      case 'PENDING':
        return kcStatRed;
      case 'IN PROGRESS':
        return kcStatPurple;
      case 'COMPLIANCE':
        return kcStatAmber;
      default:
        return kcLightGrey;
    }
  }

  Widget _buildInfoSection({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4, top: 4),
          child: Row(
            children: [
              _buildIconBadge(icon, iconColor),
              const SizedBox(width: 6),
              Flexible(child: _buildLabel("$label :")),
            ],
          ),
        ),
        _buildAccentTextBox(value, valueColor, accentColor: iconColor),
      ],
    );
  }

  Widget _buildInteractiveSection({
    required IconData icon,
    required Color iconColor,
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4, top: 4),
          child: Row(
            children: [
              _buildIconBadge(icon, iconColor),
              const SizedBox(width: 6),
              Flexible(child: _buildLabel("$label :")),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: kcWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kcVeryLightGrey, width: 1),
            boxShadow: [
              BoxShadow(
                color: iconColor.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                Expanded(child: Center(child: child)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditableTextRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 3,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: _buildIconBadge(icon, iconColor),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: _buildLabel("$label :"),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hint,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: kcVeryLightGrey, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: kcVeryLightGrey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: iconColor, width: 1.5),
                ),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: kcValueDark,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconBadge(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color, size: 16),
    );
  }

  Color _priorityColor(String name) {
    switch (name.trim().toUpperCase()) {
      case 'HIGH':
        return kcStatRed;
      case 'MEDIUM':
        return kcStatAmber;
      case 'LOW':
        return kcStatGreen;
      default:
        return kcLightGrey;
    }
  }

  Widget _buildPriorityPill() {
    return BlocConsumer<PriorityBloc, PriorityState>(
      bloc: priorityBloc,
      listener: (_, __) {},
      builder: (_, state) {
        final priorityModel = state.when(
          loading: (m) => m,
          content: (m) => m,
          success: (m) => m,
          failed: (m, _) => m,
        );
        return ValueListenableBuilder<String>(
          valueListenable: priority,
          builder: (context, value, child) {
            final label = value.isEmpty ? '—' : value;
            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => _buildPriorityDialog(priorityModel),
              child: _buildPillBadge(label, _priorityColor(value)),
            );
          },
        );
      },
    );
  }

  Widget _buildPillBadge(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: kcLabelGrey,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildAccentTextBox(String title, Color color, {Color? accentColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 36),
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kcVeryLightGrey, width: 1),
          boxShadow: [
            BoxShadow(
              color: (accentColor ?? Colors.black).withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (accentColor != null)
                Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Text(
                    title.isEmpty ? '—' : title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class SearchableListNotifier extends ValueNotifier<List<AllPlantModel>> {
  SearchableListNotifier(super.value) {
    initialValue = value;
    print("INITIAL VALUE WAS $value");
  }

  late List<AllPlantModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.deptName.toLowerCase().startsWith(query)).toList();
    }
    notifyListeners();
  }
}

class departmentSearchableListNotifier extends ValueNotifier<List<AllDepartmentModel>> {

  departmentSearchableListNotifier(super.value) {
    initialValue = value;
    print("INITIAL VALUE WAS $value");
  }

  late List<AllDepartmentModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.statName.toLowerCase().startsWith(query)).toList();
    }
    notifyListeners();
  }
}

class responsibilitySearchableListNotifier extends ValueNotifier<List<EmployeeResponsibilityModel>> {

  responsibilitySearchableListNotifier(super.value) {
    initialValue = value;
    print("INITIAL VALUE WAS $value");
  }

  late List<EmployeeResponsibilityModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.wrkGrp.toLowerCase().startsWith(query)).toList();
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
      value = initialValue.where((e) => e.locations.toLowerCase().startsWith(query)).toList();
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
      value = initialValue.where((e) => e.priorityStatusName.toLowerCase().startsWith(query)).toList();
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
      value = initialValue.where((e) => e.hazardCategoryName.toLowerCase().startsWith(query)).toList();
    }
    notifyListeners();
  }
}

class ErrorPage extends StatelessWidget {
  final Exception error;

  ErrorPage({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Error')),
      body: Center(
        child: Text('An error occurred: ${error.toString()}'),
      ),
    );
  }
}