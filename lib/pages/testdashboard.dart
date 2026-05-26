import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/allhazard_cat_bloc.dart';
import 'package:jsaw_limited/bloc/alltoday_observation_bloc.dart';
import 'package:jsaw_limited/bloc/observationstatus_bloc.dart';
import 'package:jsaw_limited/bloc/top3hazard_bloc.dart';
import 'package:jsaw_limited/bloc/update_password_bloc.dart';
import 'package:jsaw_limited/utils/progressive_image.dart';
import 'package:jsaw_limited/model/allhazard_cat_model.dart';
import 'package:jsaw_limited/model/alltoday_observation_model.dart';
import 'package:jsaw_limited/model/observationstatus_model.dart';
import 'package:jsaw_limited/model/top3hazard_model.dart';
import 'package:jsaw_limited/pages/suggestion_page.dart';
import 'package:jsaw_limited/routes/app_routes.dart';
import 'package:jsaw_limited/service/dashboard_service.dart';
import 'package:jsaw_limited/service/password_service.dart';
import 'package:jsaw_limited/state/allhazard_cat_state.dart';
import 'package:jsaw_limited/state/alltoday_observation_state.dart';
import 'package:jsaw_limited/state/observationStatus_state.dart';
import 'package:jsaw_limited/state/top3hazard_state.dart';
import 'package:jsaw_limited/state/update_password_state.dart';
import 'package:jsaw_limited/utils/app_color.dart';
import 'package:jsaw_limited/utils/app_drawer.dart';
import 'package:jsaw_limited/utils/page_header.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web/web.dart' as html;

class TestDashboardPage extends StatefulWidget {
  const TestDashboardPage({super.key});

  @override
  State<TestDashboardPage> createState() => _TestDashboardPageState();
}

class _TestDashboardPageState extends State<TestDashboardPage> {

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController plantTypeInput = TextEditingController();
  final now = DateTime.now();
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // Currently selected drawer index
  int _selectedDrawerIndex = 0;

  late AllTodayObservationBloc allTodayObservationBloc;
  late AllHazardCatBloc allHazardCatBloc;
  late ObservationStatusBloc observationStatusBloc;
  late Top3HazardBloc top3hazardBloc;
  late UpdatePasswordBloc updatePasswordBloc;

  ValueNotifier<String> hazardCategory = ValueNotifier("Select hazard Category");

  @override
  void initState() {
    super.initState();
    final dashboardServices = Provider.of<DashboardService>(context, listen: false);
    final passwordService = Provider.of<PasswordService>(context, listen: false);
    allTodayObservationBloc = AllTodayObservationBloc(dashboardServices);
    allTodayObservationBloc.initState();
    allHazardCatBloc = AllHazardCatBloc(dashboardServices);
    allHazardCatBloc.initState();
    observationStatusBloc = ObservationStatusBloc(dashboardServices);
    observationStatusBloc.initState();
    top3hazardBloc = Top3HazardBloc(dashboardServices);
    top3hazardBloc.initState();
    updatePasswordBloc = UpdatePasswordBloc(passwordService);

    var empPassStatus = html.window.localStorage.getItem('kEmployeePassStatus').toString();
    if (empPassStatus == '0') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showPasswordChangeDialog(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return _buildMobileLayout();
          } else if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
            return _buildTabletLayout();
          } else {
            return _buildDesktopLayout();
          }
        },
      ),
    );
  }

  // Mobile Layout
  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildObservationList(300, 350),
          _buildGridBody(100),
          _buildTopCategories(100),
          _buildInfoCard(),
        ],
      ),
    );
  }

  // Tablet Layout
  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildObservationList(400, 450)),
              Expanded(flex: 1, child: _buildTopCategories(250)),
            ],
          ),
          _buildInfoCard(),
        ],
      ),
    );
  }

  // Desktop Layout
  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: _buildObservationList(500, 600)),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                _buildGridBody(800),
                _buildTopCategories(100),
                SizedBox(height: 16),
                _buildInfoCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObservationList(double height, double width) {
    return BlocConsumer<AllTodayObservationBloc, AllTodayObservationState>(
      bloc: allTodayObservationBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
          loading: (_) => Center(child: Lottie.asset("assets/lottie/loading.json", height: 80, width: 80)),
          content: (model) => _buildContent(model, height, width),
          success: (model) => _buildContent(model, height, width),
          failed: (form, __) => _buildContent(form, height, width),
        );
      },
    );
  }

  Widget _buildContent(List<AllTodayObservationModel> model, double height, double width) {
    return Container(
      height: height,
      width: width,
      child: Column(
        children: [
          _buildHazardContainer(),
          if (model.isEmpty) Center(child: Text("No Data")),
          Expanded(
            child: ListView.builder(
              itemCount: model.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: kcWhite,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          width: 100,
                          height: 150,
                          child: ProgressiveImage(
                            highUrl: model[index].imageNumber,
                            lowUrl: model[index].lowQualityImageUrl,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 350,
                                child: Row(
                                  children: [
                                    CircleAvatar(backgroundImage: AssetImage("assets/images/jindal-saw-logo.png"), radius: 12),
                                    _buildNameText2(model[index].observationRaisedBy),
                                    _buildHeadingText2("-"),
                                    _buildHeadingText2(model[index].uniqueIdentificationNumber),
                                  ],
                                ),
                              ),
                              _buildHighlowContainer(model[index].priorityStatusName, hexToColor(model[index].priorityStatusColour)),
                            ],
                          ),
                          _buildLightText2("Hazard : ${model[index].hazardCategory}"),
                          SizedBox(
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                model[index].observationText,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: kcvoilet),
                              ),
                            ),
                          ),
                          Divider(color: kcVeryLightGrey, thickness: 2, height: 20),
                          _buildObservationDetails(model[index]),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObservationDetails(AllTodayObservationModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            _buildLightText("Assignee"),
            Row(children: [
              CircleAvatar(backgroundImage: AssetImage("assets/images/jindal-saw-logo.png"), radius: 16),
              _buildHeadingText(model.responsibility),
            ]),
          ],
        ),
        Column(
          children: [
            _buildLightText("Status"),
            _buildHeadingText(model.status),
          ],
        ),
        Column(
          children: [
            _buildLightText("Complaint Date"),
            Row(children: [
              Icon(Icons.calendar_month),
              _buildHeadingText(model.raisedDate),
            ]),
          ],
        ),
      ],
    );
  }

  _buildHazardContainer() {
    return Container(
      width: 800,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHazardBody(),
          Row(
            children: [
              const Icon(Icons.refresh),
              TextButton(onPressed: () {
                allTodayObservationBloc.initState();
              }, child: const Text("Refresh", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
            ],
          )
        ],
      ),
    );
  }

  _buildHazardBody() {
    return BlocConsumer<AllHazardCatBloc, AllHazardCatState>(
      bloc: allHazardCatBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
          loading: (_) => Lottie.asset("assets/lottie/loading.json"),
          content: _buildhazardContent,
          success: _buildhazardContent,
          failed: (form, __) => _buildhazardContent(form),
        );
      },
    );
  }

  Widget _buildhazardContent(List<AllHazardCatModel> model) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          _buildhazardListDialog(model);
        },
        child: SizedBox(
          width: 600,
          height: 40,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: hazardCategory,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hazardCategory.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: (hazardCategory.value == "Select Division") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildhazardListDialog(List<AllHazardCatModel> model) {
    final listNotifier = SearchableListNotifier(model);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select or search division", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                onChanged: listNotifier.filterBasedOn,
                decoration: const InputDecoration(
                  hintText: "search here...",
                  prefixIcon: Icon(Icons.search, color: kcLightGrey),
                ),
              )
            ],
          ),
          content: SizedBox(
            width: 200,
            height: 240,
            child: ValueListenableBuilder<List<AllHazardCatModel>>(
              valueListenable: listNotifier,
              builder: (context, list, widget) {
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        hazardCategory.value = list[index].hazardCategoryName;
                        allTodayObservationBloc.initState(hazardCategory.value);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(list[index].hazardCategoryName),
                      ),
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
                child: const Text("close", style: TextStyle(color: kcDarkGreyColor, fontSize: 18)),
              ),
            )
          ],
        );
      },
    );
  }

  //Observation Status Api Implementation

  _buildGridBody(double height) {
    return BlocConsumer<ObservationStatusBloc, ObservationStatusState>(
      bloc: observationStatusBloc,
      listener: (_, state) {
        // Handle any side effects if needed
      },
      builder: (_, state) {
        return state.when(
          loading: (_){return Lottie.asset("assets/lottie/loading.json");},
          content: (observationModel) => _buildGridViewContent(observationModel),
          success: (observationModel) => _buildGridViewContent(observationModel),
          failed: (form, error) => _buildErrorState(error),
        );
      },
    );
  }

  Widget _buildGridViewContent(ObservationStatusModel observationModel) {
    return SizedBox(
      width: 800,
      child: GridView(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 5/ 3),
        children: [
          Container(
            height: 100,
            child: Card(
              color: kcBlue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset("assets/images/ticket.png", scale: 14, color: kcBlack,),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("All Observations", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: kcBlack),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 5),
                    child: Text("${observationModel.alls}", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: kcBlack),),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: kclightRed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 4),
                  child: Image.asset("assets/images/pendingticket.png", scale: 14, color: kcBlack,),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("Pending Observations", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: kcBlack),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 5),
                  child: Text("${observationModel.pending}", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: kcBlack),),
                ),
              ],
            ),
          ),
          Card(
            color: kcgreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 4),
                  child: Image.asset("assets/images/ticketcomplete.png", scale: 14, color: kcBlack,),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("Closed Observations", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: kcBlack),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 10),
                  child: Text("${observationModel.closed}", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: kcBlack),),
                ),
              ],
            ),
          ),
          Card(
            color: kclightpink,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 4),
                  child: Image.asset("assets/images/cancelticket.png", scale: 14, color: kcBlack,),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("In Progress ", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: kcBlack),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 5),
                  child: Text("${observationModel.inProgress}", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: kcBlack),),
                ),
              ],
            ),
          ),
          Card(
            color: kcYellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 4),
                  child: Image.asset("assets/images/complince.png", scale: 16, color: kcBlack,),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("Compliance ", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: kcBlack),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 5),
                  child: Text("${observationModel.compliance}", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: kcBlack),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCategories(double height) {
    return BlocConsumer<Top3HazardBloc, Top3HazardState>(
      bloc: top3hazardBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
          loading: (_) => Lottie.asset("assets/lottie/loading.json"),
          content: (top3HazardModel) => _buildTop3HazardContent(top3HazardModel, height),
          success: (top3HazardModel) => _buildTop3HazardContent(top3HazardModel, height),
          failed: (form, error) => _buildErrorState(error),
        );
      },
    );
  }

  Widget _buildTop3HazardContent(List<Top3HazardModel> top3HazardModel, double height) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: top3HazardModel.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildTopCategoriesItem(top3HazardModel[index].hazardCategory, kcvoilet, top3HazardModel[index].count.toString());
        },
      ),
    );
  }

  Widget _buildTopCategoriesItem(String title, Color color, String title2) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 160,
        decoration: BoxDecoration(color: kcWhite, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: 100,
                child: Text(
                  title,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              width: 40,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  title2,
                  style: const TextStyle(color: kcWhite, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: kcWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text("Hello", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text("Facing any difficulty while using the Safety Portal app or any Suggestions? Write Us.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [navyBlue, cream, golden]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SuggestionFeedbackPage(),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                        child: const Text("Write Us", style: TextStyle(color: kcWhite, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset("assets/images/adhyamLogo.png", scale: 5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(child: Text('Error: $error'));
  }

  Widget _buildHeadingText(String title) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: 100,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
        ),
      ),
    );
  }

  Widget _buildHeadingText2(String title) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        title,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
      ),
    );
  }

  Widget _buildNameText2(String title) {
    return Container(
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          title,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildHeadingText3(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
      ),
    );
  }

  Widget _buildLightText(String title) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: 100,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: kcLightGrey),
        ),
      ),
    );
  }

  Widget _buildLightText2(String title) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: kcOrange),
      ),
    );
  }

  Widget _buildHighlowContainer(String title, Color color) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: kcWhite, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Future<void> _showPasswordChangeDialog(BuildContext context) async {
    final TextEditingController newPasswordController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: BlocConsumer<UpdatePasswordBloc, UpdatePasswordState>(
              bloc: updatePasswordBloc,
              listener: (_, state) {
                state.maybeWhen(
                  success: (_, message) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message ?? "Something")));
                    Navigator.pop(context);
                  },
                  failed: (_, message) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loading: (_) => const CircularProgressIndicator(),
                  orElse: () {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 500,
                        height: 200,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(gradient: LinearGradient(colors: [navyBlue, cream, golden])),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  child: Text("Change Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kcWhite)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: newPasswordController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter New Password",
                                    border: OutlineInputBorder(),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  String newPassword = newPasswordController.text;
                                  if (newPassword.isNotEmpty) {
                                    _updatepassword(
                                      html.window.localStorage.getItem('kEmployeeCode').toString(),
                                      html.window.localStorage.getItem('kEmployeePassStatus').toString(),
                                      newPasswordController.text,
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    // Handle empty password case
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                child: const Text("Save Password", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }


  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }
  
  void _updatepassword(String empUnqId, String empPassStatus, String empNewPass) async {
    final data = {
      'empUnqId': empUnqId,
      'empPassStatus': "1",
      'empNewPass': empNewPass,
    };
    await updatePasswordBloc.forgetPassword(data);
  }
}

class SearchableListNotifier extends ValueNotifier<List<AllHazardCatModel>> {
  SearchableListNotifier(super.value) {
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
