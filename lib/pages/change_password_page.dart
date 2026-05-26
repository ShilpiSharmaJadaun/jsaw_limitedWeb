import 'package:flutter/material.dart';
import 'package:jsaw_limited/bloc/changeEmail_bloc.dart';
import 'package:jsaw_limited/bloc/changepassword_bloc.dart';
import 'package:jsaw_limited/service/password_service.dart';
import 'package:web/web.dart' as html;
import 'package:provider/provider.dart';
import '../utils/app_color.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ChangepasswordBloc changepasswordBloc;
  late ChangeEmailBloc changeEmailBloc;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController employeeCodeController = TextEditingController();

  bool _showPassword = false;
  bool _showResetPassword = false;

  bool get _canResetForOthers =>
      html.window.localStorage.getItem('kResetPasswordAuth') == '1';

  @override
  void initState() {
    super.initState();
    final passwordService =
        Provider.of<PasswordService>(context, listen: false);
    changepasswordBloc = ChangepasswordBloc(passwordService);
    changeEmailBloc = ChangeEmailBloc(passwordService);
    _tabController =
        TabController(length: _canResetForOthers ? 3 : 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    newPasswordController.dispose();
    newEmailController.dispose();
    employeeCodeController.dispose();
    super.dispose();
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
        child: Column(
          children: [
            Container(
              color: kcWhite,
              child: TabBar(
                controller: _tabController,
                labelColor: kcvoilet,
                unselectedLabelColor: kcLabelGrey,
                indicatorColor: kcvoilet,
                indicatorWeight: 3,
                tabs: [
                  const Tab(
                      text: 'Change Password',
                      icon: Icon(Icons.lock_outline)),
                  const Tab(
                      text: 'Change Email',
                      icon: Icon(Icons.alternate_email)),
                  if (_canResetForOthers)
                    const Tab(
                        text: 'Reset Password',
                        icon: Icon(Icons.lock_reset_outlined)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildChangePassword(),
                  _buildChangeEmail(),
                  if (_canResetForOthers) _buildResetPassword(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== Tabs =====

  Widget _buildChangePassword() {
    return _formCard(
      title: 'Change Password',
      subtitle: 'Update the password for your own account.',
      headerIcon: Icons.password_outlined,
      headerColors: const [kcStatBlue, kcvoilet],
      fieldIcon: Icons.lock_outline,
      hintText: 'Enter new password',
      controller: newPasswordController,
      obscure: !_showPassword,
      suffix: IconButton(
        icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility,
            size: 18, color: kcLabelGrey),
        onPressed: () => setState(() => _showPassword = !_showPassword),
      ),
      buttonText: 'Save Password',
      buttonIcon: Icons.save_outlined,
      buttonColor: kcvoilet,
      onPressed: () {
        final newPassword = newPasswordController.text.trim();
        if (newPassword.isEmpty) {
          _snack('Password cannot be empty', kcRed);
          return;
        }
        _updatePassword(
          html.window.localStorage.getItem('kEmployeeCode') ?? '',
          html.window.localStorage.getItem('kEmployeePassStatus') ?? '',
          newPassword,
        );
        newPasswordController.clear();
        _snack('Password changed successfully', kcobservationgreen);
      },
    );
  }

  Widget _buildChangeEmail() {
    return _formCard(
      title: 'Change Email',
      subtitle: 'Update the email address linked to your account.',
      headerIcon: Icons.mail_outline,
      headerColors: const [kcInfoDate, kcOrange],
      fieldIcon: Icons.alternate_email,
      hintText: 'Enter new email address',
      controller: newEmailController,
      keyboardType: TextInputType.emailAddress,
      buttonText: 'Save Email',
      buttonIcon: Icons.save_outlined,
      buttonColor: kcInfoDate,
      onPressed: () {
        final newEmail = newEmailController.text.trim();
        if (newEmail.isEmpty) {
          _snack('Email cannot be empty', kcRed);
          return;
        }
        _updateEmail(
          html.window.localStorage.getItem('kEmployeeCode') ?? '',
          newEmail,
        );
        newEmailController.clear();
        _snack('Email changed successfully', kcobservationgreen);
      },
    );
  }

  Widget _buildResetPassword() {
    return _formCard(
      title: 'Reset Password',
      subtitle: "Set another employee's password.",
      headerIcon: Icons.lock_reset_outlined,
      headerColors: const [kcStatAmber, kcOrange],
      fieldIcon: Icons.badge_outlined,
      hintText: 'Enter Employee Code',
      controller: employeeCodeController,
      obscure: !_showResetPassword,
      suffix: IconButton(
        icon: Icon(
            _showResetPassword ? Icons.visibility_off : Icons.visibility,
            size: 18,
            color: kcLabelGrey),
        onPressed: () =>
            setState(() => _showResetPassword = !_showResetPassword),
      ),
      buttonText: 'Reset Password',
      buttonIcon: Icons.lock_reset_outlined,
      buttonColor: kcStatAmber,
      onPressed: () {
        final code = employeeCodeController.text.trim();
        if (code.isEmpty) {
          _snack('Employee code cannot be empty', kcRed);
          return;
        }
        _updatePassword(
          code,
          html.window.localStorage.getItem('kEmployeePassStatus') ?? '',
          code,
        );
        employeeCodeController.clear();
        _snack('Password reset successfully', kcobservationgreen);
      },
    );
  }

  // ===== Reusable card =====

  Widget _formCard({
    required String title,
    required String subtitle,
    required IconData headerIcon,
    required List<Color> headerColors,
    required IconData fieldIcon,
    required String hintText,
    required TextEditingController controller,
    bool obscure = false,
    Widget? suffix,
    TextInputType? keyboardType,
    required String buttonText,
    required IconData buttonIcon,
    required Color buttonColor,
    required VoidCallback onPressed,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 540),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: kcWhite,
              borderRadius: BorderRadius.circular(14),
              border:
                  Border.all(color: headerColors.first.withOpacity(0.25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
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
                        child:
                            Icon(headerIcon, color: kcWhite, size: 18),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: controller,
                        obscureText: obscure,
                        keyboardType: keyboardType,
                        decoration: InputDecoration(
                          hintText: hintText,
                          prefixIcon: Icon(fieldIcon, color: kcLabelGrey),
                          suffixIcon: suffix,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: buttonColor, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: onPressed,
                          icon: Icon(buttonIcon,
                              size: 18, color: kcWhite),
                          label: Text(
                            buttonText,
                            style: const TextStyle(
                              color: kcWhite,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===== Actions =====

  void _updatePassword(
      String empUnqId, String empPassStatus, String empNewPass) async {
    final data = {'empUnqId': empUnqId, 'empNewPass': empNewPass};
    await changepasswordBloc.forgetPassword(data);
  }

  void _updateEmail(String empUnqId, String empNewEmail) async {
    final data = {'empUnqId': empUnqId, 'email': empNewEmail};
    await changeEmailBloc.forgetPassword(data);
  }

  void _snack(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
