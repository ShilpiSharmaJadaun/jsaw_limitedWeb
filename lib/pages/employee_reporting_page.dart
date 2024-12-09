import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/allHod_bloc.dart';
import 'package:jsaw_limited/bloc/allemployee_bloc.dart';
import 'package:jsaw_limited/bloc/deleteHod_bloc.dart';
import 'package:jsaw_limited/bloc/employeeAppReporting_bloc.dart';
import 'package:jsaw_limited/bloc/insertHODEmployee_bloc.dart';
import 'package:jsaw_limited/bloc/updateHod_bloc.dart';
import 'package:jsaw_limited/model/allHod_model.dart';
import 'package:jsaw_limited/model/allemployee_model.dart';
import 'package:jsaw_limited/model/employeefromAppReporting_model.dart';
import 'package:jsaw_limited/service/employee_reporting_service.dart';
import 'package:jsaw_limited/state/allHod_state.dart';
import 'package:jsaw_limited/state/allemployee_state.dart';
import 'package:jsaw_limited/state/deleteHOD_state.dart';
import 'package:jsaw_limited/state/employeeAppReporting_state.dart';
import 'package:jsaw_limited/state/insertHODEmployee_state.dart';
import 'package:jsaw_limited/state/updateHod_state.dart';
import 'package:provider/provider.dart';
import '../utils/app_color.dart';

class EmployeeReportingPage extends StatefulWidget {
  const EmployeeReportingPage({super.key});

  @override
  State<EmployeeReportingPage> createState() => _EmployeeReportingPageState();
}

class _EmployeeReportingPageState extends State<EmployeeReportingPage> {

  late AllEmployeeBloc allEmployeeBloc;
  late EmployeeFromAppReportingBloc employeeFromAppReportingBloc;
  late AllHodBloc allHodBloc;
  late UpdateHodBloc updateHodBloc;
  late InsertHODEMPloyeeBloc insertHODEMPloyeeBloc;
  late DeleteHODBloc deleteHODBloc;

  ValueNotifier<String> reportingEmployeeName = ValueNotifier("");
  ValueNotifier<String> deleteReportingEmployeeName = ValueNotifier("");
  ValueNotifier<String> hodName = ValueNotifier("");
  ValueNotifier<String> deleteHodName = ValueNotifier("");
  ValueNotifier<String> employeeName = ValueNotifier("");
  ValueNotifier<String> insertEmployeeName = ValueNotifier("");
  ValueNotifier<String> NewHodName = ValueNotifier("");

  late String employeeCode;
  late String reportEmployeeCode;
  late String hodCode;
  late String newHodCode;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final employeeReportingService = Provider.of<EmployeeReportingService>(context, listen: false);
    allEmployeeBloc = AllEmployeeBloc(employeeReportingService);
    employeeFromAppReportingBloc = EmployeeFromAppReportingBloc(employeeReportingService);
    allHodBloc = AllHodBloc(employeeReportingService);
    updateHodBloc = UpdateHodBloc(employeeReportingService);
    insertHODEMPloyeeBloc = InsertHODEMPloyeeBloc(employeeReportingService);
    deleteHODBloc = DeleteHODBloc(employeeReportingService);
    employeeFromAppReportingBloc.initState();
    allEmployeeBloc.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeadingText("Change HOD"),
            Container(
              width: 1000,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildALlReportingEmp(),
                  _buildAllHod(),
                  _buildAllEmployee(),
                  _buildSubmit()
                ],
              ),
            ),
            _buildHeadingText("Insert New HOD /  Employee"),
            Container(
              width: 1000,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildInsertAllEmployee(),
                  _buildNewHODEmployee(),
                  _buildSubmitNewHOD()
                ],
              ),
            ),
            _buildHeadingText("Delete HOD /  Employee"),
            Container(
              width: 1000,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildDeleteReportingEmp(),
                  _buildDeletedAllHod(),
                  _buildDeleteHOD()
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  _buildSubmit(){
    return BlocConsumer<UpdateHodBloc, UpdateHodState>(
      bloc: updateHodBloc,
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
                      "reportResEmpCode": reportEmployeeCode,
                      "reportingToEmpCode": employeeCode,
                      "oldReportingToEmpCode": hodCode,
                    };
                    await updateHodBloc.forgetPassword(data);
                    reportingEmployeeName.value = "";
                    hodName.value = "";
                    employeeName.value = "";
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kcvoilet,
                      fixedSize: const Size(200, 40)
                  ), child: const Text("Update",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kcWhite),
                ),),
              ),
            );

          },
        );
      },
    );
  }

  _buildSubmitNewHOD(){
    return BlocConsumer<InsertHODEMPloyeeBloc, InsertNewHodState>(
      bloc: insertHODEMPloyeeBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            employeeFromAppReportingBloc.initState();
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
                      "reportResEmpCode": employeeCode,
                      "reportingToEmpCode": newHodCode,
                    };
                    await insertHODEMPloyeeBloc.insertHod(data);
                    reportingEmployeeName.value = "";
                    hodName.value = "";
                    employeeName.value = "";
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kcvoilet,
                      fixedSize: const Size(200, 40)
                  ), child: const Text("Insert",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kcWhite),
                ),),
              ),
            );

          },
        );
      },
    );
  }

  _buildDeleteHOD(){
    return BlocConsumer<DeleteHODBloc, DeleteHODState>(
      bloc: deleteHODBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            employeeFromAppReportingBloc.initState();
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
                      "reportResEmpCode": reportEmployeeCode,
                      "reportingToEmpCode": hodCode,
                    };
                    await deleteHODBloc.forgetPassword(data);
                    reportingEmployeeName.value = "";
                    hodName.value = "";
                    employeeName.value = "";
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kcvoilet,
                      fixedSize: const Size(200, 40)
                  ), child: const Text("Delete",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kcWhite),
                ),),
              ),
            );

          },
        );
      },
    );
  }

  _buildHeadingText(String title){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 400,
        child: Text(title, style: const TextStyle( fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black),),
      ),
    );
  }

  Widget _buildALlReportingEmp(){
    return  BlocConsumer<EmployeeFromAppReportingBloc, EmployeeFromAppReportingState>(
      bloc: employeeFromAppReportingBloc,
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

  Widget _buildLoading(List<EmployeeFromAppReportingModel> departModel){
    return const CircularProgressIndicator();
  }

  Widget _buildContent(List<EmployeeFromAppReportingModel> responsibilityModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildResponsibilityDialog(responsibilityModel);
        },
        child: SizedBox(
          width: 200,
          height: 50,
          child: Container(
            width: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: reportingEmployeeName,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Text(
                        value.isEmpty ?  "Select Reporting Employee" : reportingEmployeeName.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (reportingEmployeeName.value == "Select Reporting Employee") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildResponsibilityDialog(List<EmployeeFromAppReportingModel> responsibilityModel) {
    final responsibilityListNotifier = allEmployeeAppReportingListNotifier(responsibilityModel);
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
                child:ValueListenableBuilder<List<EmployeeFromAppReportingModel>>(
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
                                    reportingEmployeeName.value = list[index].empName;
                                    reportEmployeeCode = list[index].empUnqId;
                                    allHodBloc.initState(reportEmployeeCode);

                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].empName +"( "+ list[index].empUnqId+ ")" ,
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

  ///Delete Reporting Employee
  Widget _buildDeleteReportingEmp(){
    return  BlocConsumer<EmployeeFromAppReportingBloc, EmployeeFromAppReportingState>(
      bloc: employeeFromAppReportingBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildDeleteLoading,
            content: _buildDeleteContent,
            success: _buildDeleteContent,
            failed: (form, __) => _buildDeleteContent(form));
      },
    );
  }

  Widget _buildDeleteLoading(List<EmployeeFromAppReportingModel> departModel){
    return const CircularProgressIndicator();
  }

  Widget _buildDeleteContent(List<EmployeeFromAppReportingModel> responsibilityModel){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildDeleteResponsibilityDialog(responsibilityModel);
        },
        child: SizedBox(
          width: 200,
          height: 50,
          child: Container(
            width: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: deleteReportingEmployeeName,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Text(
                        value.isEmpty ?  "Select Reporting Employee" : deleteReportingEmployeeName.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (reportingEmployeeName.value == "Select Reporting Employee") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildDeleteResponsibilityDialog(List<EmployeeFromAppReportingModel> responsibilityModel) {
    final responsibilityListNotifier = allEmployeeAppReportingListNotifier(responsibilityModel);
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
                child:ValueListenableBuilder<List<EmployeeFromAppReportingModel>>(
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
                                    deleteReportingEmployeeName.value = list[index].empName;
                                    reportEmployeeCode = list[index].empUnqId;
                                    allHodBloc.initState(reportEmployeeCode);

                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].empName +"( "+ list[index].empUnqId+ ")" ,
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

  //All HOD

  Widget _buildAllHod(){
    return  BlocConsumer<AllHodBloc, AllHodState>(
      bloc: allHodBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildHodLoading,
            content: _buildHodContent,
            success: _buildHodContent,
            failed: (form, __) => _buildHodContent(form));
      },
    );
  }

  Widget _buildHodLoading(List<AllHodModel> departModel){
    return const CircularProgressIndicator();
  }

  Widget _buildHodContent(List<AllHodModel> allHod){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildHodDialog(allHod);
        },
        child: SizedBox(
          width: 180,
          height: 50,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: hodName,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        value.isEmpty ?  "Select HOD" : hodName.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (hodName.value == "Select Employee") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildHodDialog(List<AllHodModel> allHod) {
    final responsibilityListNotifier = allHodListNotifier(allHod);
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
                child:ValueListenableBuilder<List<AllHodModel>>(
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
                                    hodName.value = list[index].empName;
                                    hodCode = list[index].empUnqId;
                                    // allEmployeeBloc.initState();
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].empName +"( "+ list[index].empUnqId+ ")",
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

  /// Delete ALl HOD

  Widget _buildDeletedAllHod(){
    return  BlocConsumer<AllHodBloc, AllHodState>(
      bloc: allHodBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildDeleteHodLoading,
            content: _buildDeleteHodContent,
            success: _buildDeleteHodContent,
            failed: (form, __) => _buildDeleteHodContent(form));
      },
    );
  }

  Widget _buildDeleteHodLoading(List<AllHodModel> departModel){
    return const CircularProgressIndicator();
  }

  Widget _buildDeleteHodContent(List<AllHodModel> allHod){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildDeleteHodDialog(allHod);
        },
        child: SizedBox(
          width: 180,
          height: 50,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: deleteHodName,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        value.isEmpty ?  "Select HOD" : deleteHodName.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (deleteHodName.value == "Select Employee") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildDeleteHodDialog(List<AllHodModel> allHod) {
    final responsibilityListNotifier = allHodListNotifier(allHod);
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
                child:ValueListenableBuilder<List<AllHodModel>>(
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
                                    deleteHodName.value = list[index].empName;
                                    hodCode = list[index].empUnqId;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].empName +"( "+ list[index].empUnqId+ ")",
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

  // ALl Employee

  Widget _buildAllEmployee(){
    return  BlocConsumer<AllEmployeeBloc, AllEmployeeState>(
      bloc: allEmployeeBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildAllEmployeeLoading,
            content: _buildEmployeeContent,
            success: _buildEmployeeContent,
            failed: (form, __) => _buildEmployeeContent(form));
      },
    );
  }

  Widget _buildAllEmployeeLoading(List<AllEmployeeModel> departModel){
    return const CircularProgressIndicator();
  }

  Widget _buildEmployeeContent(List<AllEmployeeModel> allEmployee){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildAllEmployeeDialog(allEmployee);
        },
        child: SizedBox(
          width: 180,
          height: 50,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: employeeName,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        value.isEmpty ?  "Select Employee" : employeeName.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (employeeName.value == "Select Employee") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildAllEmployeeDialog(List<AllEmployeeModel> allEmployee) {
    final responsibilityListNotifier = allEmployeeListNotifier(allEmployee);
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
                child:ValueListenableBuilder<List<AllEmployeeModel>>(
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
                                    employeeName.value = list[index].empName;
                                    employeeCode = list[index].empUnqId;
                                   // allHodBloc.initState(employeeCode);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].empName+"( "+ list[index].empUnqId+ ")",
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

  ///INSERT EMPLOYEE
  Widget _buildInsertAllEmployee(){
    return  BlocConsumer<AllEmployeeBloc, AllEmployeeState>(
      bloc: allEmployeeBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildInsertAllEmployeeLoading,
            content: _buildInsertEmployeeContent,
            success: _buildInsertEmployeeContent,
            failed: (form, __) => _buildInsertEmployeeContent(form));
      },
    );
  }

  Widget _buildInsertAllEmployeeLoading(List<AllEmployeeModel> departModel){
    return const CircularProgressIndicator();
  }

  Widget _buildInsertEmployeeContent(List<AllEmployeeModel> allEmployee){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildInsertAllEmployeeDialog(allEmployee);
        },
        child: SizedBox(
          width: 180,
          height: 50,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: insertEmployeeName,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        value.isEmpty ?  "Select Employee" : insertEmployeeName.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (insertEmployeeName.value == "Select Employee") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildInsertAllEmployeeDialog(List<AllEmployeeModel> allEmployee) {
    final responsibilityListNotifier = allEmployeeListNotifier(allEmployee);
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
                child:ValueListenableBuilder<List<AllEmployeeModel>>(
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
                                    insertEmployeeName.value = list[index].empName;
                                    employeeCode = list[index].empUnqId;
                                    allHodBloc.initState(employeeCode);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].empName+"( "+ list[index].empUnqId+ ")",
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


  //Select New HOD

  // ALl Employee

  Widget _buildNewHODEmployee(){
    return  BlocConsumer<AllEmployeeBloc, AllEmployeeState>(
      bloc: allEmployeeBloc,
      listener: (_, state){},
      builder: (_, state){
        return state.when(
            loading: _buildNewHODEmployeeLoading,
            content: _buildNewHODEmployeeContent,
            success: _buildNewHODEmployeeContent,
            failed: (form, __) => _buildNewHODEmployeeContent(form));
      },
    );
  }

  Widget _buildNewHODEmployeeLoading(List<AllEmployeeModel> departModel){
    return const CircularProgressIndicator();
  }

  Widget _buildNewHODEmployeeContent(List<AllEmployeeModel> allEmployee){
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: (){
          _buildNewHODEmployeeDialog(allEmployee);
        },
        child: SizedBox(
          width: 180,
          height: 50,
          child: Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: kcWhite),
            child: ValueListenableBuilder<String>(
              valueListenable: NewHodName,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        value.isEmpty ?  "Select New HOD / Employee" : NewHodName.value,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(color: (NewHodName.value == "Select New HOD / Employee") ? kcDarkGreyColor : kcLightGrey),
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

  Future<void> _buildNewHODEmployeeDialog(List<AllEmployeeModel> allEmployee) {
    final responsibilityListNotifier = NewHODEmployeeListNotifier(allEmployee);
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
                child:ValueListenableBuilder<List<AllEmployeeModel>>(
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
                                    NewHodName.value = list[index].empName;
                                    newHodCode = list[index].empUnqId;
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(list[index].empName+"( "+ list[index].empUnqId+ ")",
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

class allEmployeeAppReportingListNotifier extends ValueNotifier<List<EmployeeFromAppReportingModel>> {

  allEmployeeAppReportingListNotifier(super.value) {
    initialValue = value;
  }

  late List<EmployeeFromAppReportingModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.empName.toLowerCase().contains(query.toLowerCase()) || e.empUnqId.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

}

class allHodListNotifier extends ValueNotifier<List<AllHodModel>> {

  allHodListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllHodModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.empName.toLowerCase().contains(query.toLowerCase()) || e.empUnqId.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

}

class allEmployeeListNotifier extends ValueNotifier<List<AllEmployeeModel>> {

  allEmployeeListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllEmployeeModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.empName.toLowerCase().contains(query.toLowerCase()) || e.empUnqId.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

}

class NewHODEmployeeListNotifier extends ValueNotifier<List<AllEmployeeModel>> {

  NewHODEmployeeListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllEmployeeModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue.where((e) => e.empName.toLowerCase().contains(query.toLowerCase()) || e.empUnqId.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

}