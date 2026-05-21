import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/allhazard_cat_bloc.dart';
import 'package:jsaw_limited/bloc/alltoday_observation_bloc.dart';
import 'package:jsaw_limited/bloc/observationstatus_bloc.dart';
import 'package:jsaw_limited/bloc/top3hazard_bloc.dart';
import 'package:jsaw_limited/bloc/update_password_bloc.dart';
import 'package:jsaw_limited/model/allhazard_cat_model.dart';
import 'package:jsaw_limited/model/alltoday_observation_model.dart';
import 'package:jsaw_limited/model/observationstatus_model.dart';
import 'package:jsaw_limited/model/top3hazard_model.dart';
import 'package:jsaw_limited/pages/login.dart';
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
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web/web.dart' as html;

class LargeDashboardPage extends StatefulWidget {
  const LargeDashboardPage({super.key});

  @override
  State<LargeDashboardPage> createState() => _LargeDashboardPageState();
}

class _LargeDashboardPageState extends State<LargeDashboardPage> {

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController plantTypeInput = TextEditingController();
  final now = DateTime.now();
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  late AllTodayObservationBloc allTodayObservationBloc;

  late AllHazardCatBloc allHazardCatBloc;

  late ObservationStatusBloc observationStatusBloc;

  late Top3HazardBloc top3hazardBloc;

  late UpdatePasswordBloc updatePasswordBloc;

  ValueNotifier<String> hazardCategory = ValueNotifier("Select hazard Category");


  @override
  void initState() {
    // TODO: implement initState
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
    // Check the employee password status in local storage
    var empPassStatus = html.window.localStorage.getItem('kEmployeePassStatus').toString();

    if (empPassStatus == '0') {
      // If the status is 0, show the password change dialog
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showPasswordChangeDialog(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildObservation()
    );
  }

  _buildObservation() {
    return BlocConsumer<AllTodayObservationBloc, AllTodayObservationState>(
      bloc: allTodayObservationBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: (_){return Center(child: Lottie.asset("assets/lottie/loading.json",height: 80, width: 80 ));},
            content: _buildContent,
            success: _buildContent,
            failed: (form, __) => _buildContent(form));
      },
    );
  }

  Widget _buildContent(List<AllTodayObservationModel> model){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTodayCategoryList(model),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.5.screenHeight),
                _buildGridBody(),
                _buildHeadingText3("Top Categories"),
                _buildTop3HazardBody(),
                _buildInfoCard()
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildTodayCategoryList(List<AllTodayObservationModel> model){
    return SizedBox(
      height: 50.screenHeight,
      width: 90.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHazardContainer(),
          if(model == null)const Center(child: Text("No Data")),
          Expanded(
              child: ListView.builder(
                  itemCount: model.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index){
                    return  Card(
                      color: kcWhite,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: 20.screenWidth,
                              height: 10.screenHeight,
                              child: Image.network(
                                alignment: Alignment.center,
                                model[index].imageNumber,
                                fit: BoxFit.cover,
                                scale: 2,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 50.screenWidth,
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircleAvatar(backgroundImage: AssetImage("assets/images/jindal-saw-logo.png"),radius: 12,),
                                        ),
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
                                width: 60.screenWidth,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    model[index].observationText,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 1.5.screenWidth,color: kcvoilet),
                                  ),
                                ),
                              ),
                              Container(height: 2,color: kcVeryLightGrey,width: 40.screenWidth,),
                              SizedBox(
                                width: 60.screenWidth,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildLightText("Assignee"),
                                        _buildHeadingText(model[index].responsibility),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildLightText("Status"),
                                        _buildHeadingText(model[index].status),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildLightText("Complaint Date"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          const Padding(
                                              padding: EdgeInsets.all(1.0), child: Icon(Icons.calendar_month)),
                                          _buildHeadingText(model[index].raisedDate),
                                        ],)

                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  })),
        ],
      ),
    );
  }

  // Hazard List Api Implementation

  _buildHazardContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //_buildHeadingText3("Observations"),
        _buildHazardBody(),
        Row(
          children: [
            const Icon(Icons.refresh),
            TextButton(onPressed: (){
              allTodayObservationBloc.initState();
            }, child: const Text("Refresh", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),)),
          ],
        )
      ],
    );
  }

  _buildHazardBody(){
    return BlocConsumer<AllHazardCatBloc, AllHazardCatState>(
      bloc: allHazardCatBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: (_){return Lottie.asset("assets/lottie/loading.json");},
            content: _buildhazardContent,
            success: _buildhazardContent,
            failed: (form, __) => _buildhazardContent(form));
      },
    );
  }

  Widget _buildhazardContent(List<AllHazardCatModel> model){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: (){
          _buildhazardListDialog(model);
        },
        child: SizedBox(
          width: 70.screenWidth,
          height: 2.5.screenHeight,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
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
                      style: TextStyle(color: (hazardCategory.value == "Select Hazard") ? kcDarkGreyColor : kcLightGrey),
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
            // actionsPadding: EdgeInsets.all(5.dw),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            // contentPadding: EdgeInsets.all(10.dw),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or search division",
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                height: 240,
                child:ValueListenableBuilder<List<AllHazardCatModel>>(
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
                                    hazardCategory.value = list[index].hazardCategoryName;
                                    allTodayObservationBloc.initState(hazardCategory.value);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(list[index].hazardCategoryName,),
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

  //Observation Status Api Implementation

  _buildGridBody() {
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

  Widget _buildErrorState(String error) {
    return Center(child: Text('Error: $error'));
  }

  Widget _buildGridViewContent(ObservationStatusModel observationModel) {
    return SizedBox(
      width: 60.screenWidth,
      child: GridView(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 6.screenWidth / 2.screenHeight),
        children: [
          Card(
            color: kcBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Image.asset("assets/images/ticket.png", scale: 14, color: kcBlack,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("All Observations", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 1.5.screenWidth, color: kcBlack),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 5),
                  child: Text("${observationModel.alls}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 2.screenWidth, color: kcBlack),),
                ),
              ],
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
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("Pending Observations", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 1.5.screenWidth, color: kcBlack),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 5),
                  child: Text("${observationModel.pending}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 1.5.screenWidth, color: kcBlack),),
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
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("Closed Observations", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 1.5.screenWidth, color: kcBlack),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 10),
                  child: Text("${observationModel.closed}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 1.5.screenWidth, color: kcBlack),),
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
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("In Progress ", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 1.5.screenWidth, color: kcBlack),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 5),
                  child: Text("${observationModel.inProgress}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 1.5.screenWidth, color: kcBlack),),
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
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("Compliance ", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 1.5.screenWidth, color: kcBlack),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 5),
                  child: Text("${observationModel.compliance}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 1.5.screenWidth, color: kcBlack),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Top Categories Api Implementation

  _buildTop3HazardBody() {
    return BlocConsumer<Top3HazardBloc, Top3HazardState>(
      bloc: top3hazardBloc,
      listener: (_, state) {
        // Handle any side effects if needed
      },
      builder: (_, state) {
        return state.when(
          loading: (_){return Lottie.asset("assets/lottie/loading.json");},
          content: (top3HazardModel) => _buildtop3HazardContent(top3HazardModel),
          success: (top3HazardModel) => _buildtop3HazardContent(top3HazardModel),
          failed: (form, error) => _buildErrorState(error),
        );
      },
    );
  }

  Widget _buildtop3HazardContent(List<Top3HazardModel> top3HazardModel){
    return SizedBox(
      width: 65.screenWidth,
      height: 4.screenHeight,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: top3HazardModel.length,
          itemBuilder: (BuildContext context, int index){
            return _buildTopCategories(top3HazardModel[index].hazardCategory, kcvoilet, top3HazardModel[index].count.toString());
          }),
    );
  }

  _buildTopCategories(String title, Color color, String title2){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 20.screenWidth,
        decoration:  BoxDecoration(color: kcWhite, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: 8.screenWidth,
                child: Text(title,
                  maxLines: 2,
                  style: TextStyle(fontSize: 1.2.screenWidth, fontWeight: FontWeight.w500),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                width: 8.screenWidth,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
                child: Center(child: Text(title2, style: TextStyle(color: kcWhite, fontSize: 2.screenWidth),)),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildInfoCard(){
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
              width: 35.screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text("Hello", style: TextStyle(fontSize: 2.screenWidth, fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text("Facing any difficulty while using the Safety Portal app or any Suggetions? Write Us.", style: TextStyle(fontSize: 2.screenWidth, fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        decoration: BoxDecoration(gradient: const LinearGradient(colors: [navyBlue,cream, golden]),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: ElevatedButton(onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const SuggestionFeedbackPage(),
                                fullscreenDialog: true),
                          );
                        }, style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent), child: const Text("Write Us", style: TextStyle(color: kcWhite, fontWeight: FontWeight.w600),),)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10  ),
              child: Image.asset("assets/images/adhyamLogo.png",scale: 0.8.screenWidth,),
            )
          ],
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

  _buildHeadingText(String title) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: 15.screenWidth,
        child: Text(
          title,
          maxLines: 2,
          style:
          TextStyle(fontWeight: FontWeight.w500, fontSize: 1.5.screenWidth),
        ),
      ),
    );
  }

  _buildHeadingText2(String title) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        title,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
      ),
    );
  }

  _buildNameText2(String title) {
    return SizedBox(
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

  _buildHeadingText3(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 2.5.screenWidth),
      ),
    );
  }

  _buildLightText(String title) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: 10.screenWidth,
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 1.2.screenWidth,
              color: kcLightGrey),
        ),
      ),
    );
  }

  _buildLightText2(String title) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        title,
        style:  TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 2.screenWidth,
            color: kcOrange),
      ),
    );
  }

  _buildHighlowContainer(String title, Color color) {
    return Container(
      width: 10.screenWidth,
      decoration: BoxDecoration(color: color,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(color: kcWhite, fontSize:2.screenWidth,fontWeight: FontWeight.w500),),
      ),
    );
  }

  Future<void> _showPasswordChangeDialog(BuildContext context) async {
    // Controllers for the TextFormField
    final TextEditingController newPasswordController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by tapping outside or pressing the back button
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Prevents closing the dialog with the back button
          child: AlertDialog(
              contentPadding: EdgeInsets.zero, // Removes default padding
              content: BlocConsumer<UpdatePasswordBloc, UpdatePasswordState>(
                bloc: updatePasswordBloc,
                listener: (_, state){
                  state.maybeWhen(
                      success: (_, message){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message??"Something")));
                        Navigator.pop(context);
                      },
                      failed: (_, message){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                      }, orElse:(){});
                },
                builder: (context, state) {
                  return state.maybeWhen(
                      loading: (_){
                        return const CircularProgressIndicator();
                      },
                      orElse: (){
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 500,
                            height: 200, // Adjust height as needed
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(gradient: LinearGradient(colors: [navyBlue,cream, golden])),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      child: Text("Change Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: kcWhite),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      controller: newPasswordController,
                                      decoration: const InputDecoration(
                                        hintText: "Enter New Password",
                                        border: OutlineInputBorder(), // Define your border here
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red), // Error border color
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Logic to save password
                                      String newPassword = newPasswordController.text;
                                      if (newPassword.isNotEmpty) {
                                        _updatepassword(
                                            html.window.localStorage.getItem('kEmployeeCode').toString(),
                                            html.window.localStorage.getItem('kEmployeePassStatus').toString(),
                                            newPasswordController.text);
                                        // Add your password saving logic here
                                        // After saving, close the dialog
                                        Navigator.pop(context);
                                        Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Password cannot be empty")),
                                        );
                                        // Show error if the password field is empty
                                        // You can display a message or shake the text field as feedback
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue, // Change the color as per your theme
                                    ),
                                    child: const Text(
                                      "Save Password",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });

                },

              )
          ),
        );
      },
    );
  }

  void _updatepassword(String empUnqId, String empPassStatus, String empNewPass) async {
    final data = {
      'empUnqId': empUnqId,
      'empPassStatus' : "1",
      'empNewPass': empNewPass
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