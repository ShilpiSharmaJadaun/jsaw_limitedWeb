import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/suggestion_bloc.dart';
import 'package:jsaw_limited/bloc/suggestion_feedback_bloc.dart';
import 'package:jsaw_limited/model/raised_feedback_model.dart';
import 'package:jsaw_limited/state/suggestion_feedback_state.dart';
import 'package:jsaw_limited/state/suggestion_state.dart';
import 'package:jsaw_limited/utils/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../bloc/allobservation_bloc.dart';
import '../bloc/priority_bloc.dart';
import '../model/priority_model.dart';
import '../service/observation_service.dart';
import '../state/priority_state.dart';
import '../utils/app_color.dart';
import '../utils/app_drawer.dart';
import '../utils/page_header.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'image_picker.dart';
import 'package:web/web.dart' as html;
import 'dart:io' as io;


class SuggestionFeedbackPage extends StatefulWidget {
  const SuggestionFeedbackPage({super.key});

  @override
  State<SuggestionFeedbackPage> createState() => _SuggestionFeedbackPageState();
}

class _SuggestionFeedbackPageState extends State<SuggestionFeedbackPage> with SingleTickerProviderStateMixin{



  // Currently selected drawer index
  int _selectedDrawerIndex = 1;

  // late final AllObservationBloc allObservationBloc;

  late TabController tabController;

  void initState() {
    super.initState();
    // final observationService = Provider.of<ObservationService>(context, listen: false);
    // allObservationBloc = AllObservationBloc(observationService);
    // allObservationBloc.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }


  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: kcDashboardBg1,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [kcDashboardBg1, kcDashboardBg2],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: kcWhite,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: tabController,
                  labelColor: kcOrange,
                  unselectedLabelColor: kcLabelGrey,
                  indicatorColor: kcOrange,
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.feedback_outlined),
                      text: 'Create Complaint',
                    ),
                    Tab(
                      icon: Icon(Icons.list_alt_outlined),
                      text: 'Raised Complaints',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  decoration: BoxDecoration(
                    color: kcWhite,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      SuggestionPage(),
                      RaisedSuggestionPage(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // Titles for each drawer item
  static const drawerTitles = <String>[
    'Dashboard',
    'Observation',
  ];

}


class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController suggestionController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  // Titles for each drawer item
  static const drawerTitles = <String>['Dashboard', 'Observation', 'Graph',' Register Observation', "Any Suggestion"];

  // Currently selected drawer index
  final int _selectedDrawerIndex = 4;

  late String priorityColor = "";

  late final PriorityBloc priorityBloc;

  late final SaveSuggestionBloc saveSuggestionBloc;

  ValueNotifier<String> priority = ValueNotifier("Select Priority");

  Uint8List? _selectedImage;

  void _onImagePicked(dynamic image, [Uint8List? webImageBytes]) {
    setState(() {
      _selectedImage = webImageBytes;
    });
  }

  @override
  void initState(){
    super.initState();
    final observationService = Provider.of<ObservationService>(context, listen: false);
    priorityBloc = PriorityBloc(observationService);
    saveSuggestionBloc = SaveSuggestionBloc(observationService);
    priorityBloc.initState();
  }

  String determineOperatingSystem() {
    if (kIsWeb) {
      // Web platform
      return html.window.navigator.userAgent.contains('Mobi') ? 'Mobile Web' : 'Desktop Web';
    } else if (io.Platform.isAndroid) {
      return 'Android';
    } else if (io.Platform.isIOS) {
      return 'iOS';
    } else if (io.Platform.isWindows) {
      return 'Windows';
    } else if (io.Platform.isMacOS) {
      return 'macOS';
    } else if (io.Platform.isLinux) {
      return 'Linux';
    } else {
      return 'Unknown';
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: SizedBox(
                            width: 400,
                            height: 400,
                            child: ImagePickerPage(onImagePicked: _onImagePicked)),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: Text("Title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        ),
                        _buildTextFiled(titleController,"Title", 1),
                        const SizedBox(
                          width: 400,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                child: Text("Time of Occurance", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                child: Text("Priority", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildTime(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 220,
                                  child:  _buildPriority(),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: Text("Description", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        ),
                        _buildTextFiled(suggestionController,"Description", 6),
                        _buildSubmit()
                      ],
                    )

                  ],
                )

              ],
            ),
          ) ),
    );
  }

  //time of occurrence

  _buildTime(){
    return SizedBox(
      width: 180,
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
          width: 200,
          height: 50,
          child: Container(
            width: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: priority,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        priority.value,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(color: (priority.value == "Select Priority") ? kcDarkGreyColor : hexToColor(priorityColor)),
                      ),
                    ),
                    // const Icon(Icons.arrow_drop_down_sharp)
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
                  "Select or search Department",
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
                                    priorityColor = list[index].priorityStatusColour;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].priorityStatusName,
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

  // Submit Button

  _buildSubmit(){
    return BlocConsumer<SaveSuggestionBloc, SaveSuggestionState>(
      bloc: saveSuggestionBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message ?? "Complaint submitted successfully"),
              backgroundColor: kcobservationgreen,
            ));
            titleController.clear();
            suggestionController.clear();
            dateTimeController.clear();
            priority.value = "Select Priority";
            priorityColor = "";
            setState(() => _selectedImage = null);
            RaisedSuggestionPage.refresh?.call();
          },
          failed: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
              backgroundColor: kcRed,
            ));
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: (_) => true,
          orElse: () => false,
        );
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 400,
            child: ElevatedButton.icon(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (_selectedImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please pick an image first.'),
                            backgroundColor: kcRed,
                          ),
                        );
                        return;
                      }
                      await saveSuggestionBloc.saveSuggestion(
                          _selectedImage!,
                          titleController.text,
                          suggestionController.text,
                          dateTimeController.text,
                          "1.1",
                          determineOperatingSystem(),
                          priority.value,
                          html.window.localStorage.getItem('kEmployeeCode') ?? "",
                          html.window.localStorage.getItem('kEmployeename') ?? "",
                          "pending");
                    },
              icon: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(kcWhite),
                      ),
                    )
                  : const Icon(Icons.send_outlined, size: 18, color: kcWhite),
              label: const Text(
                "Submit Complaint",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: kcWhite),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kcobservationgreen,
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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

  _buildTextFiled(TextEditingController controller, String title, int lines){
    return SizedBox(
      width: 400,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.start,
        maxLines: null,
        minLines: lines,
        style: const TextStyle(
            fontSize:  18,
            fontWeight: FontWeight.w500,
            color: kcvoilet
        ),
        decoration: InputDecoration(
            hintText: title,
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

class RaisedSuggestionPage extends StatefulWidget {
  const RaisedSuggestionPage({super.key});

  /// Called by SuggestionPage after a successful submit to refresh the list
  /// from the sibling tab without sharing a bloc.
  static void Function()? refresh;

  @override
  State<RaisedSuggestionPage> createState() => _RaisedSuggestionPageState();
}

class _RaisedSuggestionPageState extends State<RaisedSuggestionPage> {

  late final SuggestionFeedbackBloc suggestionFeedbackBloc;

  @override
  void initState() {
    super.initState();
    final observationService = Provider.of<ObservationService>(context, listen: false);
    suggestionFeedbackBloc = SuggestionFeedbackBloc(observationService);
    suggestionFeedbackBloc.initState();
    RaisedSuggestionPage.refresh = () {
      if (mounted) suggestionFeedbackBloc.initState();
    };
  }

  @override
  void dispose() {
    RaisedSuggestionPage.refresh = null;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcDashboardBg1,
      body: _buildObservation(),
    );
  }

  _buildObservation() {
    return BlocConsumer<SuggestionFeedbackBloc, SuggestionFeedbackState>(
      bloc: suggestionFeedbackBloc,
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

  Widget _buildLoading(List<SuggestionFeedbackModel> model) {
    return const CircularProgressIndicator();
  }

  Widget _buildContent(List<SuggestionFeedbackModel> model){
    return ListView.builder(
      itemCount: model.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return  Card(
            color: kcWhite,
            elevation: 20,
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
                        highUrl: model[index].attachments,
                        lowUrl: model[index].lowQualityImageUrl,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 1000,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 500,
                              child: Row(
                                children: [
                                  _buildHeadingText("Date of Occurance:"),
                                  _buildTextBox(model[index].dateTimeOfOccurrence, kcRed),
                                ],
                              ),
                            ),
                            Container(
                              width: 400,
                              child: Row(
                                children: [
                                  _buildHeadingText("Status :"),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 2.0, right: 8),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 2.0,
                                              spreadRadius: 0.0,
                                              offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                            )
                                          ],
                                          color: kcRed),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 1.screenWidth,
                                            right: 1.screenWidth),
                                        child: Text(
                                          model[index].status,
                                          style:  const TextStyle(
                                              color: kcWhite,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )


                            // _buildHeadingText("Action Taken By :"),
                            // _buildTextBox("responsibility", kcRed),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 1000,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 500,
                              child: Row(
                                children: [
                                  _buildHeadingText("Software Version:"),
                                  _buildTextBox(model[index].softwareVersion, kcRed),
                                ],
                              ),
                            ),
                            Container(
                              width: 500,
                              child: Row(
                                children: [
                                  _buildHeadingText("Operating System:"),
                                  _buildTextBox(model[index].operatingSystem, kcRed),
                                ],
                              ),
                            ),


                            // _buildHeadingText("Action Taken By :"),
                            // _buildTextBox("responsibility", kcRed),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/observation.png",
                                scale: 18,
                              ),
                              _buildHeadingText("Issue Title :"),
                            ],
                          ),
                          SizedBox(
                            width: 1000,
                            child: Padding(
                              padding:
                              const EdgeInsets.all(1.0),
                              child: Text(
                                model[index].issueTitle,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
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
                              _buildHeadingText(
                                  "Issue Description:"),
                            ],
                          ),
                          SizedBox(
                            width: 1000,
                            child: Padding(
                              padding:
                              const EdgeInsets.all(10),
                              child: Text(model[index].issueDescription,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ));},);
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
      child: Padding(
        padding: const EdgeInsets.only(left: 3, right: 3),
        child: Text(title,
          maxLines: 4,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: color),),
      ),
    );
  }
}
