import 'package:flutter/material.dart';
import 'package:jsaw_limited/bloc/changeEmail_bloc.dart';
import 'package:jsaw_limited/bloc/changepassword_bloc.dart';
import 'package:jsaw_limited/service/password_service.dart';
import 'package:web/web.dart' as html;
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late ChangepasswordBloc changepasswordBloc;
  late ChangeEmailBloc changeEmailBloc;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController employeeCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final passwordService = Provider.of<PasswordService>(context, listen: false);
    changepasswordBloc = ChangepasswordBloc(passwordService);
    changeEmailBloc = ChangeEmailBloc(passwordService);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    newPasswordController.dispose();
    newEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       automaticallyImplyLeading: false,
        title: const Text("Account Management", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            const Tab(text: "Change Password", icon: Icon(Icons.password),),
            const Tab(text: "Change Email", icon: Icon(Icons.email),),
            if (html.window.localStorage.getItem('kResetPasswordAuth') == '1')
            const Tab(text: "Reset Password", icon: Icon(Icons.email),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChangePassword(),
          _buildChangeEmail(),
          _buildRestPassword(),
        ],
      ),
    );
  }

  Widget _buildChangePassword() {
    return _formCard(
      title: "Change Password",
      hintText: "Enter New Password",
      controller: newPasswordController,
      buttonText: "Save Password",
      onPressed: () {
        final newPassword = newPasswordController.text.trim();
        if (newPassword.isNotEmpty) {
          _updatePassword(
            html.window.localStorage.getItem('kEmployeeCode') ?? "",
            html.window.localStorage.getItem('kEmployeePassStatus') ?? "",
            newPassword,
          );
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password Changed Successfully")));

          // Navigator.pop(context);
         // Navigator.pushReplacementNamed(context, '/login');
        } else {
          _showSnackbar("Password cannot be empty");
        }
      },
    );
  }

  Widget _buildChangeEmail() {
    return _formCard(
      title: "Change Email",
      hintText: "Enter New Email",
      controller: newEmailController,
      buttonText: "Save Email",
      onPressed: () {
        final newEmail = newEmailController.text.trim();
        if (newEmail.isNotEmpty) {
          _updateEmail(
            html.window.localStorage.getItem('kEmployeeCode') ?? "",
            newEmail,
          );
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email Changed Successfully")));
          newEmailController.clear();
        } else {
          _showSnackbar("Email cannot be empty");
        }
      },
    );
  }

  Widget _buildRestPassword() {
    return _formCard(
      title: "Reset Password",
      hintText: "Enter EmployeeCode",
      controller: employeeCodeController,
      buttonText: "Reset Password",
      onPressed: () {
        final restPassword = employeeCodeController.text.trim();
        if (restPassword.isNotEmpty) {
          _updatePassword(
            employeeCodeController.text,
            html.window.localStorage.getItem('kEmployeePassStatus') ?? "",
            restPassword,
          );
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password Changed Successfully")));
        } else {
          _showSnackbar("Password cannot be empty");
        }
      },
    );
  }

  Widget _formCard({
    required String title,
    required String hintText,
    required TextEditingController controller,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: SizedBox(
          width: 600,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: _border(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text(buttonText, style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updatePassword(String empUnqId, String empPassStatus, String empNewPass) async {
    final data = {'empUnqId': empUnqId, 'empNewPass': empNewPass};
    await changepasswordBloc.forgetPassword(data);
  }

  void _updateEmail(String empUnqId, String empNewEmail) async {
    final data = {'empUnqId': empUnqId, 'email': empNewEmail};
    await changeEmailBloc.forgetPassword(data); // Replace with your actual API logic
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }


  OutlineInputBorder _border() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.grey),
  );
}

