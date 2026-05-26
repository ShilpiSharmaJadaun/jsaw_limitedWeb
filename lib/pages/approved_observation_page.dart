import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/approve_compliance_bloc.dart';
import 'package:jsaw_limited/utils/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../bloc/allDepart_bloc.dart';
import '../bloc/all_filter_observation_bloc.dart';
import '../bloc/allhazard_cat_bloc.dart';
import '../bloc/allobservation_bloc.dart';
import '../bloc/allplant_bloc.dart';
import '../bloc/alltype_hazard_bloc.dart';
import '../bloc/employeeResponsibility_bloc.dart';
import '../bloc/location_bloc.dart';
import '../bloc/priority_bloc.dart';
import '../bloc/responsibleHod_bloc.dart';
import '../bloc/save_observation_bloc.dart';
import '../bloc/uniqueId_bloc.dart';
import '../model/allDepartment_model.dart';
import '../model/all_filter_observation_model.dart';
import '../model/allhazard_cat_model.dart';
import '../model/allplant_model.dart';
import '../model/alltype_hazard_model.dart';
import '../model/allwork_group_model.dart';
import '../model/employeeResponsibility_model.dart';
import '../model/filterObservation_model.dart';
import '../model/location_model.dart';
import '../model/priority_model.dart';
import '../model/uniqueId_model.dart';
import '../service/dashboard_service.dart';
import '../service/observation_service.dart';
import '../state/allDepart_state.dart';
import '../state/all_filter_observation_state.dart';
import '../state/allhazard_cat_state.dart';
import '../state/allplant_state.dart';
import '../state/employeeResponsibility_state.dart';
import '../state/location_state.dart';
import '../state/priority_state.dart';
import '../state/responsibleHOD_state.dart';
import '../state/uniqueId_state.dart';
import '../utils/app_color.dart';
import 'package:web/web.dart' as html;
import 'approve_observation_Detail_page.dart';
import 'package:web/web.dart' show window;


class ApprovedObservationPage extends StatefulWidget {
  const ApprovedObservationPage({super.key});

  @override
  State<ApprovedObservationPage> createState() => _ApprovedObservationPageState();
}

class _ApprovedObservationPageState extends State<ApprovedObservationPage> {


  late final ApproveComplianceBloc approveComplianceBloc;

  late final AllPlantBloc allPlantBloc;

  late final AllDepartBloc allDepartBloc;

  late final EmployeeResponsibilityBloc employeeResponsibilityBloc;

  late final PriorityBloc priorityBloc;

  late final LocationBloc locationBloc;

  late final AllHazardCatBloc allHazardCatBloc;

  late final SaveObservationBloc saveObservationBloc;

  late final AllTypeHazardBloc allTypeHazardBloc;

  late final ResponsibleHODBloc responsibleHODBloc;

  // late final AllObservationBloc allObservationBloc;

  late final AllFilterObservationBloc allFilterObservationBloc;

  late final UniqueIdBloc uniqueIdBloc;

  late AllFilterObservationModel allFilterObservationModel = AllFilterObservationModel();

  ValueNotifier<String> workGroup = ValueNotifier("Select Work Group");
  ValueNotifier<String> plant = ValueNotifier("Filter Plant");
  ValueNotifier<String> stat = ValueNotifier("Filter Department");
  ValueNotifier<String> responsibility = ValueNotifier("Filter Responsibility");
  ValueNotifier<String> responsibleHOD = ValueNotifier("Filter Responsible HOD");
  ValueNotifier<String> priority = ValueNotifier("");
  ValueNotifier<String> priorityDesc = ValueNotifier("Deadline");
  ValueNotifier<String> location = ValueNotifier("");
  ValueNotifier<String> uniqueId = ValueNotifier("");
  ValueNotifier<String> hazard = ValueNotifier("");
  ValueNotifier<String> hazardType = ValueNotifier("Select Hazard Type");
  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController fromDateInput = TextEditingController();

  late String employeeName;
  late String employeeCode;
  late String sessionID = window.localStorage.getItem('ksessionID') ?? "";
  late String statCode = "";
  late String departCode = "";
  late String responsibleCode;
  late String responsibleHODCode;
  late String priorityColor = "";
  late String status = "";
  late String responsibleEnggDesignationCode = "";


  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<String> statusList = ['PENDING', 'CLOSED', 'IN PROGRESS', 'COMPLIANCE'];

  int currentPage = 0;
  final int itemsPerPage = 10;

  void _nextPage() {
    setState(() {
      currentPage++;
      allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", "", "",sessionID,"");
    });
  }

  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
        allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", "", "",sessionID,"");
      });
    }
  }

  void initState() {
    super.initState();
    final observationService = Provider.of<ObservationService>(context, listen: false);
    final dashboardService = Provider.of<DashboardService>(context, listen: false);

    approveComplianceBloc = ApproveComplianceBloc(observationService);
    String? employeeCode = html.window.localStorage.getItem('kEmployeeCode');
    approveComplianceBloc.initState();

    allPlantBloc = AllPlantBloc(observationService);
    allPlantBloc.initState();
    allDepartBloc = AllDepartBloc(observationService);
    employeeResponsibilityBloc = EmployeeResponsibilityBloc(observationService);
    employeeName = window.localStorage.getItem('kEmployeename') ?? "";
    employeeCode = window.localStorage.getItem('kEmployeeCode') ?? "";
    // sessionID = window.localStorage.getItem('ksessionID') ?? "";
    priorityBloc = PriorityBloc(observationService);
    priorityBloc.initState();
    locationBloc = LocationBloc(observationService);
    allHazardCatBloc = AllHazardCatBloc(dashboardService);
    allHazardCatBloc.initState();
    allTypeHazardBloc = AllTypeHazardBloc(observationService);
    allTypeHazardBloc.initState();
    saveObservationBloc = SaveObservationBloc(observationService);
    responsibleHODBloc = ResponsibleHODBloc(observationService);
    uniqueIdBloc = UniqueIdBloc(observationService);
    allFilterObservationBloc = AllFilterObservationBloc(observationService);
    allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "COMPLIANCE", "", "", "","","");

    startDateInput.text = "";
    endDateInput.text = "";
    fromDateInput.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildObservation()
    );
  }

  _buildObservation() {
    return BlocConsumer<AllFilterObservationBloc, AllFilterObservationState>(
      bloc: allFilterObservationBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: _buildLoading,
            content: _buildContent,
            success: _buildContent,
            failed: (form, __) => _buildContent(form));
      },
    );
  }

  Widget _buildLoading(AllFilterObservationModel model) {
    return const CircularProgressIndicator();
  }

  Widget _buildContent(AllFilterObservationModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTopBar(model),
        const Divider(height: 1, color: kcVeryLightGrey),
        Expanded(child: _buildList(model)),
      ],
    );
  }

  Widget _buildTopBar(AllFilterObservationModel model) {
    final hasPrev = model.totalItems != 0 && currentPage > 0;
    final hasNext = model.totalItems != 0 && currentPage < model.totalPages;
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: kcWhite,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _pageButton(
            icon: Icons.chevron_left_rounded,
            label: 'Prev',
            enabled: hasPrev,
            onPressed: _previousPage,
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: kcvoilet.withOpacity(0.06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: kcvoilet.withOpacity(0.15), width: 1),
            ),
            child: Text(
              model.totalItems == 0
                  ? 'No records'
                  : 'Page ${currentPage + 1} of ${model.totalPages}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: kcvoilet,
              ),
            ),
          ),
          Row(
            children: [
              _toolbarIconButton(
                icon: Icons.refresh_rounded,
                tooltip: 'Refresh',
                color: kcStatGreen,
                onPressed: () {
                  setState(() => currentPage = 0);
                  allFilterObservationBloc.initState(
                      0, '', '', '', '', '', 'COMPLIANCE', '', '', '', '', '');
                },
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  uniqueIdBloc.initState();
                  openFilterDialog();
                },
                icon: const Icon(Icons.filter_alt_outlined, size: 16),
                label: const Text('Filter',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcvoilet,
                  foregroundColor: kcWhite,
                  fixedSize: const Size(120, 38),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
              ),
              const SizedBox(width: 10),
              _pageButton(
                icon: Icons.chevron_right_rounded,
                label: 'Next',
                enabled: hasNext,
                onPressed: _nextPage,
                iconAfter: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _toolbarIconButton({
    required IconData icon,
    required String tooltip,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.3), width: 1),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
      ),
    );
  }

  Widget _pageButton({
    required IconData icon,
    required String label,
    required bool enabled,
    required VoidCallback onPressed,
    bool iconAfter = false,
  }) {
    return AnimatedOpacity(
      opacity: enabled ? 1.0 : 0.35,
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: kcvoilet,
          foregroundColor: kcWhite,
          disabledBackgroundColor: kcLightGrey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: iconAfter
              ? [
                  Text(label,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(width: 4),
                  Icon(icon, size: 18),
                ]
              : [
                  Icon(icon, size: 18),
                  const SizedBox(width: 4),
                  Text(label,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13)),
                ],
        ),
      ),
    );
  }
  
  Widget _buildList(AllFilterObservationModel model) {
    if (model.model.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, color: kcLightGrey.withOpacity(0.6), size: 64),
            const SizedBox(height: 12),
            const Text(
              'No records pending approval',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kcLabelGrey,
              ),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: model.model.length,
      itemBuilder: (BuildContext context, int index) {
        final item = model.model[index];
        return _ApprovedObservationCard(
          item: item,
          onOpen: () async {
            final shouldInit = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ApproveObservationDetailPage(model: item),
                fullscreenDialog: true,
              ),
            );
            if (shouldInit != null && shouldInit) {
              allFilterObservationBloc.initState(
                  currentPage, '', '', '', '', '', 'COMPLIANCE', '', '', '', '', '');
            }
          },
        );
      },
    );
  }

  Widget _buildList_OLD_UNUSED(AllFilterObservationModel model){
    return  Expanded(
      child: ListView.builder(
          itemCount: model.model.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                color: kcWhite,
                elevation: 8,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: ProgressiveImage(
                            highUrl: model.model[index].imageCompliance,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 800,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/raisedby.png",
                                          scale: 20,
                                        ),
                                        _buildHeadingText(
                                            "Observation Raised By :"),
                                      ],
                                    ),
                                    _buildTextBox(
                                        model.model[index].observationRaisedBy,
                                        kcDarkGreyColor),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/uniqueid.png",
                                          scale: 20,
                                        ),
                                        _buildHeadingText(
                                            "Unique ID No. :"),
                                      ],
                                    ),
                                    _buildTextBox(
                                        model.model[index]
                                            .uniqueIdentificationNumber,
                                        kcDarkGreyColor),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/date.png",
                                          scale: 20,
                                        ),
                                        _buildHeadingText("Date :"),
                                      ],
                                    ),
                                    _buildTextBox(
                                        model.model[index].raisedDate, kcRed)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 800,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/plant.png",
                                          scale: 20,
                                        ),
                                        _buildHeadingText(
                                            "Plant / Dept :"),
                                      ],
                                    ),
                                    _buildTextBox(model.model[index].plantDept,
                                        Colors.black)
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/location.png",
                                          scale: 20,
                                        ),
                                        _buildHeadingText("Location :"),
                                      ],
                                    ),
                                    _buildTextBox(model.model[index].location,
                                        Colors.black)
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/responsibility.png",
                                          scale: 20,
                                        ),
                                        _buildHeadingText(
                                            "Responsibility"),
                                      ],
                                    ),
                                    _buildTextBox(
                                        model.model[index].responsibility,
                                        kcmegenta)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Center(
                              child: Container(
                                height: 2,
                                alignment: Alignment.center,
                                color: kcVeryLightGrey,
                                width: 800,
                              )),
                          SizedBox(
                            width: 800,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/tagetdate.png",
                                          scale: 20,
                                        ),
                                        _buildHeadingText("Target Date :"),
                                      ],
                                    ),
                                    Container(

                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 1,
                                            right: 1),
                                        child: Text(
                                          model.model[index].observationCompletionTargetDate,
                                          style:  const TextStyle(
                                              color: kcBlack,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/tagetdate.png",
                                          scale: 20,
                                        ),
                                        _buildHeadingText("Compliance Date :"),
                                      ],
                                    ),
                                    Container(

                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 1,
                                            right: 1),
                                        child: Text(
                                          model.model[index].complianceDate,
                                          style:  const TextStyle(
                                              color: kcBlack,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Row(
                          //       children: [
                          //         Image.asset(
                          //           "assets/images/tagetdate.png",
                          //           scale: 20,
                          //         ),
                          //         _buildHeadingText("Target Date :"),
                          //       ],
                          //     ),
                          //     Container(
                          //
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(
                          //             left: 1,
                          //             right: 1),
                          //         child: Text(
                          //           model.model[index].observationCompletionTargetDate,
                          //           style:  const TextStyle(
                          //               color: kcBlack,
                          //               fontWeight: FontWeight.w500),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/observation.png",
                                    scale: 20,
                                  ),
                                  _buildHeadingText("Observations :"),
                                ],
                              ),
                              SizedBox(
                                width: 500,
                                child: Padding(
                                  padding:
                                  EdgeInsets.all(1.0.screenWidth),
                                  child: Text(
                                    model.model[index].observationText,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 2.screenWidth,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/suggestions.png",
                                    scale: 20,
                                  ),
                                  _buildHeadingText("Action Taken"),
                                ],
                              ),
                              SizedBox(
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    model.model[index].actionTaken,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: ()async {

                                    ///autoRoute
                                     final shouldInit = await Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => ApproveObservationDetailPage(model: model.model[index],
                                      ), fullscreenDialog: true),
                                     );
                                        // .then((_) => setState(() {
                                    //   approveComplianceBloc.initState();
                                    // }
                                    // )
                                    // );
                                    if(shouldInit != null && shouldInit) {
                                      allFilterObservationBloc.initState(currentPage,"", "", "", "", "", "COMPLIANCE", "", "", "","","");  }},
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_sharp)),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 2.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                        )
                                      ],
                                      color: hexToColor(model.model[index].priorityStatusColour,
                                      )),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 1.screenWidth,
                                        right: 1.screenWidth),
                                    child: Text(
                                      model.model[index].priorityStatusName,
                                      style: const TextStyle(
                                          color: kcWhite,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          }),
    );
  }

  _buildHeadingText(String title) {
    return Padding(
      padding: EdgeInsets.all(1.screenWidth),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 2.2.screenWidth,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600),
      ),
    );
  }

  _buildTextBox(String title, Color color) {
    return Padding(
      padding: EdgeInsets.all(1.screenWidth),
      child: SizedBox(
        width: 30.screenWidth,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: kcWhite,
          child: Padding(
            padding: EdgeInsets.only(
                left: 3.screenWidth,
                right: 3.screenWidth,
                top: 0.2.screenHeight,
                bottom: 0.2.screenHeight),
            child: Text(
              title,
              maxLines: 4,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 2.screenWidth,
                  color: color),
            ),
          ),
        ),
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

  Future<void> openFilterDialog() async {
    final employeeCode = window.localStorage.getItem('kEmployeeCode') ?? "";  // Retrieve value before dialog
    await _buildFilterDialog(context, employeeCode);  // Pass employeeCode to the dialog
  }

  Future<void> _buildFilterDialog(BuildContext dialogContext, String employeeCode) {
    return showDialog(
        context: dialogContext,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            contentPadding: const EdgeInsets.all(8.0),
            content: SizedBox(
              height: 600,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("SELECT FILTERS", style: TextStyle(fontWeight: FontWeight.bold),),
                  _buildDateRangeContainer("Start Date", startDateInput),
                  _buildDateRangeContainer("End Date", endDateInput),
                  _buildPlant(),
                  _buildDepartment(),
                  _buildStatusContent(statusList),
                  _buildLocation(),
                  _buildHazard(),
                  _buildUniqueId()

                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  clearFormValues();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: kcRed),
                child: const Text("Cancel", style: TextStyle(color: kcWhite),),
              ),
              ElevatedButton(
                onPressed: () {
                  allFilterObservationBloc.initState(0,statCode, fromDateInput.text, endDateInput.text, location.value, departCode, "COMPLIANCE", hazard.value, "", '',"",uniqueId.value);
                  html.window.localStorage.removeItem('ksessionID');
                  startDateInput.clear();
                  endDateInput.clear();
                  clearFormValues();
                  Navigator.of(dialogContext).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: kcobservationgreen),
                child: const Text("Apply Filters", style: TextStyle(color: kcWhite),),
              ),
            ],
          );
        });
  }

  void clearFormValues() {
    // Reset ValueNotifier values
    workGroup.value = "";
    plant.value = "";
    stat.value = "";
    responsibility.value = "";
    responsibleHOD.value = "";
    priority.value = "";
    priorityDesc.value = "";
    location.value = "";
    hazard.value = "";
    hazardType.value = "";

    // Clear TextEditingControllers
    startDateInput.clear();
    endDateInput.clear();
    fromDateInput.clear();

    // Reset late-initialized String values
    employeeName = "";
    employeeCode = "";
    statCode = "";
    departCode = "";
    responsibleCode = "";
    responsibleHODCode = "";
    priorityColor = "";
    status="";
  }

  //date

  _buildDateRangeContainer(String hintText, TextEditingController controller,) {
    return SizedBox(
      width: 300,
      height: 40,
      child: TextFormField(
        controller: controller,  // Use the existing startController
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          hintText: hintText, // Hint text to show before selection
          fillColor: kcWhite,
          suffixIcon: const Icon(
            Icons.calendar_month, size: 20.0,
          ),
          filled: true,
          enabledBorder: _border(),
          focusedBorder: _border(),
        ),
        readOnly: true,
        onTap: () async {
          // Open a date range picker for selecting the start and end dates
          DateTimeRange? pickedDateRange = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            initialDateRange: startDateInput.text.isNotEmpty && endDateInput.text.isNotEmpty
                ? DateTimeRange(
              start: DateTime.parse(startDateInput.text),
              end: DateTime.parse(endDateInput.text),
            )
                : DateTimeRange(
              start: DateTime.now().subtract(const Duration(days: 7)),
              end: DateTime.now(),
            ),
          );

          if (pickedDateRange != null) {
            String formattedStartDate = DateFormat('yyyy-MM-dd').format(pickedDateRange.start);
            String formattedEndDate = DateFormat('yyyy-MM-dd').format(pickedDateRange.end);

            setState(() {
              // Set the start and end date inputs
              startDateInput.text = formattedStartDate;
              fromDateInput.text = formattedStartDate;// Display as "start to end"
              endDateInput.text = formattedEndDate; // Optionally, save end date separately if needed
            });
          }
        },
      ),
    );
  } _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 2, color: kcWhite));

  //status

  Widget _buildStatusContent(List<String> statusList) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildStatusDialog(statusList);  // Call the status dialog
        },
        child: SizedBox(
          width: 180,
          height: 40,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: priority, // Assuming priority stores the selected status
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        value.isEmpty ? "Filter Status" : priority.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (priority.value == "Filter Status") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildStatusDialog(List<String> statusList) {
    final statusListNotifier = ValueNotifier<List<String>>(statusList);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select or search Status",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                onChanged: (value) {
                  // Filter the list based on user input
                  List<String> filteredList = statusList.where((status) => status.toLowerCase().contains(value.toLowerCase())).toList();
                  statusListNotifier.value = filteredList;
                },
                decoration: const InputDecoration(
                  hintText: "Search here...",
                  prefixIcon: Icon(Icons.search, color: kcLightGrey),
                ),
              )
            ],
          ),
          content: SizedBox(
            width: 210,
            height: 300,
            child: ValueListenableBuilder<List<String>>(
              valueListenable: statusListNotifier,
              builder: (context, list, widget) {
                return ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            priority.value = list[index]; // Update selected status
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(list[index]),
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
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(color: kcDarkGreyColor, fontSize: 18),
                ),
              ),
            )
          ],
        );
      },
    );
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
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: (){
          _buildallPlantListDialog(model);
        },
        child: SizedBox(
          width: 200,
          height: 40,
          child: Container(
            // width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: plant,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 100,
                      child: Text(
                        value.isEmpty ? "Select Plant" : plant.value,
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
                                    plant.value = list[index].deptName;
                                    departCode = list[index].deptCode;
                                    allDepartBloc.initState(departCode);
                                    locationBloc.initState(departCode);
                                    // filterObservationBloc.initState("", "", "", "", departCode, "", "", "", "");
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


  // Unique Id
  Widget _buildUniqueId(){
    return  BlocConsumer<UniqueIdBloc, UniqueIdState>(
      bloc: uniqueIdBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildUniqueIDLoding,
            content: _buildUNiqueIdContent,
            success: _buildUNiqueIdContent,
            failed: (form, __) => _buildUNiqueIdContent(form));
      },
    );
  }

  Widget _buildUniqueIDLoding(List<UniqueIdModel> uniqueIdModel){
    return const CircularProgressIndicator();
  }

  Widget _buildUNiqueIdContent(List<UniqueIdModel> uniqueIdModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          uniqueIdBloc.initState();
          _buildUniqueIdDialog(uniqueIdModel);
        },
        child: SizedBox(
          width: 200,
          height: 40,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: uniqueId,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Unique Id" : uniqueId.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (uniqueId.value == "Select Unique Id") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildUniqueIdDialog(List<UniqueIdModel> uniqueIdModel) {
    final uniqueIdListNotifier = UniqueIdSearchableListNotifier(uniqueIdModel);
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
                  onChanged: uniqueIdListNotifier.filterBasedOn,
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
                child:ValueListenableBuilder<List<UniqueIdModel>>(
                    valueListenable: uniqueIdListNotifier,
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
                                    uniqueId.value = list[index].uniqueIdentificationNumber;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].uniqueIdentificationNumber,
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
                      // width: 100,
                      child: Text(
                        value.isEmpty ? "Select Department" : stat.value,
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
                                    stat.value = list[index].statName;
                                    statCode = list[index].statCode;
                                    employeeResponsibilityBloc.initState(departCode, statCode, window.localStorage.getItem('kDesgnCode')!);
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
                                    responsibleCode = list[index].empUnqId;
                                    workGroup.value = list[index].wrkGrp;
                                    responsibleHODBloc.initState(departCode, statCode, responsibleEnggDesignationCode, responsibleCode);
                                    //filterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", responsibleCode, "");
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
                                    //filterObservationBloc.initState(currentPage,"", "", "", "", "", "", "", responsibleHODCode, "");
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
          height: 40,
          child: Container(
            //width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: priority,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Filter Priority" : priority.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (priority.value == "Filter Priority") ? kcDarkGreyColor : kcLightGrey),
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
          width: 200,
          height: 40,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: location,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Location" : location.value,
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
          width: 200,
          height: 40,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: hazard,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: 150,
                      // height: 20,
                      child: Text(
                        value.isEmpty ? "Select Hazard" : hazard.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (hazard.value == "Select Hazard") ? kcDarkGreyColor : kcLightGrey),
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

class UniqueIdSearchableListNotifier extends ValueNotifier<List<UniqueIdModel>> {

  UniqueIdSearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<UniqueIdModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.uniqueIdentificationNumber.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Approval Queue Card — mirrors Observation page card styling
// ────────────────────────────────────────────────────────────────────────────
class _ApprovedObservationCard extends StatelessWidget {
  final dynamic item;
  final VoidCallback onOpen;

  const _ApprovedObservationCard({
    required this.item,
    required this.onOpen,
  });

  Color _statusColor(String s) {
    switch (s.trim().toUpperCase()) {
      case 'CLOSED':
      case 'COMPLIANCE':
        return kcStatGreen;
      case 'PENDING':
        return kcStatAmber;
      case 'IN PROGRESS':
        return kcStatPurple;
      case 'REJECTED':
        return kcRed;
      default:
        return kcLightGrey;
    }
  }

  Color _hex(String h) {
    h = h.replaceFirst('#', '');
    if (h.length == 6) h = 'FF$h';
    return Color(int.parse(h, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kcVeryLightGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
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
            // ----- Image -----
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 220,
                height: 200,
                child: ProgressiveImage(
                  highUrl: item.imageCompliance,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // ----- Content -----
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 3-column info grid
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoSection(Icons.person_outline_rounded,
                                kcStatBlue, 'Raised By', item.observationRaisedBy, kcValueDark),
                            _infoSection(Icons.factory_outlined,
                                kcStatGreen, 'Plant / Dept', item.plantDept, kcValueDark),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoSection(Icons.qr_code_2_outlined,
                                kcvoilet, 'Unique ID', item.uniqueIdentificationNumber, kcValueDark),
                            _infoSection(Icons.location_on_outlined,
                                kcStatRed, 'Location', item.location, kcValueDark),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoSection(Icons.assignment_ind_outlined,
                                kcStatPurple, 'Responsibility', item.responsibility, kcmegenta),
                            _infoSection(Icons.workspace_premium_outlined,
                                _statusColor(item.status), 'Status', item.status, _statusColor(item.status)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Gradient divider
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
                  // Date pills row: Raised + Target
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _iconBadge(Icons.event_note_outlined, kcStatAmber),
                            const SizedBox(width: 8),
                            _label('Raised Date :'),
                            const SizedBox(width: 6),
                            Flexible(child: _pillBadge(item.raisedDate, kcStatAmber)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            _iconBadge(Icons.event_outlined, kcvoilet),
                            const SizedBox(width: 8),
                            _label('Target Date :'),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _pillBadge(item.observationCompletionTargetDate, kcvoilet),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Compliance + Priority row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _iconBadge(Icons.event_available_outlined, kcStatGreen),
                            const SizedBox(width: 8),
                            _label('Compliance Date :'),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _pillBadge(
                                item.complianceDate.toString().trim().isEmpty
                                    ? '—'
                                    : item.complianceDate,
                                item.complianceDate.toString().trim().isEmpty
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
                            _iconBadge(Icons.flag_outlined,
                                _hex(item.priorityStatusColour)),
                            const SizedBox(width: 8),
                            _label('Priority :'),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _pillBadge(
                                item.priorityStatusName,
                                _hex(item.priorityStatusColour),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Observation
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _iconBadge(Icons.visibility_outlined, kcObservationCyan),
                      const SizedBox(width: 8),
                      _label('Observation :'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.observationText,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: kcValueDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Action Taken + open button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _iconBadge(Icons.lightbulb_outline, kcInfoResponsibility),
                      const SizedBox(width: 8),
                      _label('Action Taken :'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.actionTaken.toString().trim().isEmpty
                              ? '—'
                              : item.actionTaken,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: kcValueDark,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: onOpen,
                        icon: const Icon(Icons.arrow_forward_ios,
                            size: 14, color: kcWhite),
                        label: const Text(
                          'Review',
                          style: TextStyle(
                            color: kcWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kcvoilet,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----- Reusable building blocks -----

  Widget _infoSection(IconData icon, Color iconColor, String label,
      String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _iconBadge(icon, iconColor),
              const SizedBox(width: 6),
              _label('$label :'),
            ],
          ),
          _valueBox(value, valueColor, accent: iconColor),
        ],
      ),
    );
  }

  Widget _iconBadge(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }

  Widget _pillBadge(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Text(
          text,
          style: const TextStyle(
            color: kcWhite,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _label(String t) => Text(
        t,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: kcLabelGrey,
        ),
      );

  Widget _valueBox(String value, Color color, {Color? accent}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 30),
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: (accent ?? Colors.black).withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (accent != null)
                Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text(
                    value.isEmpty ? '—' : value,
                    maxLines: 3,
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