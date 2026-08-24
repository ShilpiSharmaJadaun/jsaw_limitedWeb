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
import 'package:jsaw_limited/utils/employee_picker.dart';

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
      backgroundColor: kcDashboardBg1,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kcDashboardBg1, kcDashboardBg2],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _sectionCard(
                    title: 'Change HOD',
                    subtitle:
                        'Update an existing reporting relationship.',
                    icon: Icons.swap_horiz_outlined,
                    headerColors: const [kcvoilet, kcInfoResponsibility],
                    children: [
                      _dropdownLabel('Reporting Employee',
                          Icons.person_outline, kcStatBlue),
                      _buildALlReportingEmp(),
                      const SizedBox(width: 16),
                      _dropdownLabel('Current HOD',
                          Icons.supervisor_account_outlined, kcStatAmber),
                      _buildAllHod(),
                      const SizedBox(width: 16),
                      _dropdownLabel('New HOD',
                          Icons.person_add_alt_outlined, kcobservationgreen),
                      _buildAllEmployee(),
                      const SizedBox(width: 8),
                      _buildSubmit(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _sectionCard(
                    title: 'Insert New HOD / Employee',
                    subtitle: 'Assign an HOD to an employee.',
                    icon: Icons.person_add_alt_1_outlined,
                    headerColors: const [kcobservationgreen, kcInfoPlant],
                    children: [
                      _dropdownLabel('Employee',
                          Icons.person_outline, kcStatBlue),
                      _buildInsertAllEmployee(),
                      const SizedBox(width: 16),
                      _dropdownLabel('HOD / Reporting To',
                          Icons.supervisor_account_outlined,
                          kcInfoResponsibility),
                      _buildNewHODEmployee(),
                      const SizedBox(width: 8),
                      _buildSubmitNewHOD(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _sectionCard(
                    title: 'Delete HOD / Employee',
                    subtitle: 'Remove an existing HOD assignment.',
                    icon: Icons.person_remove_outlined,
                    headerColors: const [kcmegenta, kcInfoFir],
                    children: [
                      _dropdownLabel('Reporting Employee',
                          Icons.person_outline, kcStatBlue),
                      _buildDeleteReportingEmp(),
                      const SizedBox(width: 16),
                      _dropdownLabel('HOD to Remove',
                          Icons.no_accounts_outlined, kcRed),
                      _buildDeletedAllHod(),
                      const SizedBox(width: 8),
                      _buildDeleteHOD(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _sectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> headerColors,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: headerColors.first.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: headerColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kcWhite.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: kcWhite, size: 18),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: kcWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          color: cream, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 6,
              runSpacing: 12,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdownLabel(String label, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: kcLabelGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  _buildSubmit(){
    return BlocConsumer<UpdateHodBloc, UpdateHodState>(
      bloc: updateHodBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message ?? "Updated Successfully"),
            ));
            employeeFromAppReportingBloc.initState();
            try {
              if (reportEmployeeCode.isNotEmpty) {
                allHodBloc.initState(reportEmployeeCode);
              }
            } catch (_) {}
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
            return ElevatedButton.icon(
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
              icon: const Icon(Icons.save_outlined, size: 18, color: kcWhite),
              label: const Text(
                "Update",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: kcWhite),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kcvoilet,
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
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
            try {
              if (employeeCode.isNotEmpty) {
                allHodBloc.initState(employeeCode);
              }
            } catch (_) {}
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message ?? "Inserted Successfully"),
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
            return ElevatedButton.icon(
              onPressed: () async {
                final data = {
                  "reportResEmpCode": employeeCode,
                  "reportingToEmpCode": newHodCode,
                };
                await insertHODEMPloyeeBloc.insertHod(data);
                insertEmployeeName.value = "";
                NewHodName.value = "";
              },
              icon: const Icon(Icons.add_circle_outline,
                  size: 18, color: kcWhite),
              label: const Text(
                "Insert",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: kcWhite),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kcobservationgreen,
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
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
            try {
              if (reportEmployeeCode.isNotEmpty) {
                allHodBloc.initState(reportEmployeeCode);
              }
            } catch (_) {}
            deleteReportingEmployeeName.value = "";
            deleteHodName.value = "";
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message ?? "Deleted Successfully"),
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
            return ElevatedButton.icon(
              onPressed: () async {
                final data = {
                  "reportResEmpCode": reportEmployeeCode,
                  "reportingToEmpCode": hodCode,
                };
                await deleteHODBloc.forgetPassword(data);
                deleteReportingEmployeeName.value = "";
                deleteHodName.value = "";
              },
              icon: const Icon(Icons.delete_outline,
                  size: 18, color: kcWhite),
              label: const Text(
                "Delete",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: kcWhite),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kcRed,
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: kcWhite, border: Border.all(color: kcVeryLightGrey)),
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

  Future<void> _buildResponsibilityDialog(List<EmployeeFromAppReportingModel> responsibilityModel) async {
    final picked = await showEmployeePicker<EmployeeFromAppReportingModel>(
      context,
      items: responsibilityModel,
      name: (e) => e.empName,
      code: (e) => e.empUnqId,
      title: 'Select Responsible Engineer',
    );
    if (picked == null || !mounted) return;
    reportingEmployeeName.value = picked.empName;
    reportEmployeeCode = picked.empUnqId;
    allHodBloc.initState(reportEmployeeCode);
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: kcWhite, border: Border.all(color: kcVeryLightGrey)),
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

  Future<void> _buildDeleteResponsibilityDialog(List<EmployeeFromAppReportingModel> responsibilityModel) async {
    final picked = await showEmployeePicker<EmployeeFromAppReportingModel>(
      context,
      items: responsibilityModel,
      name: (e) => e.empName,
      code: (e) => e.empUnqId,
      title: 'Select Reporting Employee to Remove',
    );
    if (picked == null || !mounted) return;
    deleteReportingEmployeeName.value = picked.empName;
    reportEmployeeCode = picked.empUnqId;
    allHodBloc.initState(reportEmployeeCode);
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: kcWhite, border: Border.all(color: kcVeryLightGrey)),
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

  Future<void> _buildHodDialog(List<AllHodModel> allHod) async {
    final picked = await showEmployeePicker<AllHodModel>(
      context,
      items: allHod,
      name: (e) => e.empName,
      code: (e) => e.empUnqId,
      title: 'Select HOD',
    );
    if (picked == null || !mounted) return;
    hodName.value = picked.empName;
    hodCode = picked.empUnqId;
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: kcWhite, border: Border.all(color: kcVeryLightGrey)),
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

  Future<void> _buildDeleteHodDialog(List<AllHodModel> allHod) async {
    final picked = await showEmployeePicker<AllHodModel>(
      context,
      items: allHod,
      name: (e) => e.empName,
      code: (e) => e.empUnqId,
      title: 'Select HOD to Remove',
    );
    if (picked == null || !mounted) return;
    deleteHodName.value = picked.empName;
    hodCode = picked.empUnqId;
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: kcWhite, border: Border.all(color: kcVeryLightGrey)),
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

  Future<void> _buildAllEmployeeDialog(List<AllEmployeeModel> allEmployee) async {
    final picked = await showEmployeePicker<AllEmployeeModel>(
      context,
      items: allEmployee,
      name: (e) => e.empName,
      code: (e) => e.empUnqId,
      title: 'Select Employee',
    );
    if (picked == null || !mounted) return;
    employeeName.value = picked.empName;
    employeeCode = picked.empUnqId;
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: kcWhite, border: Border.all(color: kcVeryLightGrey)),
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

  Future<void> _buildInsertAllEmployeeDialog(List<AllEmployeeModel> allEmployee) async {
    final picked = await showEmployeePicker<AllEmployeeModel>(
      context,
      items: allEmployee,
      name: (e) => e.empName,
      code: (e) => e.empUnqId,
      title: 'Select Employee',
    );
    if (picked == null || !mounted) return;
    insertEmployeeName.value = picked.empName;
    employeeCode = picked.empUnqId;
    allHodBloc.initState(employeeCode);
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: kcWhite, border: Border.all(color: kcVeryLightGrey)),
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

  Future<void> _buildNewHODEmployeeDialog(List<AllEmployeeModel> allEmployee) async {
    final picked = await showEmployeePicker<AllEmployeeModel>(
      context,
      items: allEmployee,
      name: (e) => e.empName,
      code: (e) => e.empUnqId,
      title: 'Select New HOD',
    );
    if (picked == null || !mounted) return;
    NewHodName.value = picked.empName;
    newHodCode = picked.empUnqId;
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