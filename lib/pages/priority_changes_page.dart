import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/priorityUpdate_bloc.dart';
import 'package:jsaw_limited/state/priorityUpdate_state.dart';
import 'package:provider/provider.dart';

import '../bloc/priority_bloc.dart';
import '../bloc/suggestion_bloc.dart';
import '../model/priority_model.dart';
import '../service/observation_service.dart';
import '../state/priority_state.dart';
import '../state/suggestion_state.dart';
import '../utils/app_color.dart';

class PriorityChangesPage extends StatefulWidget {
  const PriorityChangesPage({super.key});

  @override
  State<PriorityChangesPage> createState() => _PriorityChangesPageState();
}

class _PriorityChangesPageState extends State<PriorityChangesPage> {

  late String priorityColor = "";

  late final PriorityBloc priorityBloc;


  late final PriorityUpdateBloc priorityUpdateBloc;

  ValueNotifier<String> priority = ValueNotifier("Select Priority");

  TextEditingController lowController = TextEditingController();
  TextEditingController highController = TextEditingController();
  TextEditingController mediumController = TextEditingController();

  @override
  void initState(){
    super.initState();
    final observationService = Provider.of<ObservationService>(context, listen: false);
    priorityBloc = PriorityBloc(observationService);
    priorityUpdateBloc = PriorityUpdateBloc(observationService);
    priorityBloc.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Text("Priority", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildPriority(),
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      //   child: Text("Description", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      // ),
                      // _buildTextFiled(suggestionController,"Description", 6),
                      //_buildSubmit()
                    ],
                  )

                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  // Submit Button

  _buildSubmit(String priorityName, TextEditingController description){
    return BlocConsumer<PriorityUpdateBloc, PriorityUpdateState>(
      bloc: priorityUpdateBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message ?? "Sent Successfully"),
            ));
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
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: ElevatedButton(
                  onPressed: () async {
                    final data = {
                      "priorityStatusName": priorityName,
                      "priorityStatusDeadline": description.text,
                    };
                    await priorityUpdateBloc.initState(data);
                    priorityBloc.initState();
                    description.clear();

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kcvoilet,
                      fixedSize: const Size(200, 40)
                  ), child: const Text("Update",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kcWhite),
                ),),
              ),
            );


            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {

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
      child: Container(
        width: 1000,
        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 1000,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(color: hexToColor(priorityModel[0].priorityStatusColour), borderRadius: BorderRadius.circular(5) ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(priorityModel[0].priorityStatusName,
                            style: TextStyle(color: kcWhite),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(priorityModel[0].priorityStatusDeadline,
                      style: TextStyle(color: hexToColor(priorityModel[0].priorityStatusColour)),
                    ),
                  ),
                  _buildTextFiled(highController, "Update Description", 1),
                  _buildSubmit(priorityModel[0].priorityStatusName, highController)

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
            SizedBox(
              width: 1000,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(color: hexToColor(priorityModel[1].priorityStatusColour), borderRadius: BorderRadius.circular(5) ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(priorityModel[1].priorityStatusName,
                            style: TextStyle(color: kcWhite),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(priorityModel[1].priorityStatusDeadline,
                      style: TextStyle(color: hexToColor(priorityModel[1].priorityStatusColour)),
                    ),
                  ),
                  _buildTextFiled(lowController, "Update Description", 1),
                  _buildSubmit(priorityModel[1].priorityStatusName, lowController)

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
            SizedBox(
              width: 1000,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(color: hexToColor(priorityModel[2].priorityStatusColour), borderRadius: BorderRadius.circular(5) ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(priorityModel[2].priorityStatusName,
                            style: TextStyle(color: kcWhite),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(priorityModel[2].priorityStatusDeadline,
                      style: TextStyle(color: hexToColor(priorityModel[2].priorityStatusColour)),
                    ),
                  ),
                  _buildTextFiled(mediumController, "Update Description", 1),
                  _buildSubmit(priorityModel[2].priorityStatusName, mediumController)

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
        )
      ),
    );

  }

  // Future<void> _buildPriorityDialog(List<PriorityModel> priorityModel) {
  //   final priorityListNotifier = PrioritySearchableListNotifier(priorityModel);
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
  //           title: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const Text(
  //                 "Select or search Department",
  //                 style:
  //                 TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //               ),
  //               TextFormField(
  //                 onChanged: priorityListNotifier.filterBasedOn,
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
  //               child:ValueListenableBuilder<List<PriorityModel>>(
  //                   valueListenable: priorityListNotifier,
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
  //                                   priority.value = list[index].priorityStatusName;
  //                                   priorityColor = list[index].priorityStatusColour;
  //                                   Navigator.pop(context);
  //                                 },
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.all(2.0),
  //                                   child: Text(list[index].priorityStatusName,
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

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }

  _buildTextFiled(TextEditingController controller, String title, int lines){
    return SizedBox(
      width: 300,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.start,
        maxLines: null,
        minLines: lines,
        style: const TextStyle(
            fontSize:  18,
            fontWeight: FontWeight.bold,
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

