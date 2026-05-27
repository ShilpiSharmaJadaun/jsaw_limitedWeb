import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/routes/app_routes.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../bloc/login_bloc.dart';
import '../service/login_service.dart';
import '../state/login_state.dart';
import '../utils/app_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late TextEditingController mobileUserTextController = TextEditingController();
  late TextEditingController mobilePassTextController = TextEditingController();
  final FocusNode _userFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  late final LoginPageBloc bloc;

  // Dashboard-matching palette
  static const _ink = Color(0xFF263238);          // kcValueDark
  static const _muted = Color(0xFF607D8B);        // kcLabelGrey
  static const _line = Color(0xFFE2E8F0);
  static const _bg1 = Color(0xFFF5F7FA);          // kcDashboardBg1
  static const _bg2 = Color(0xFFE8EEF4);          // kcDashboardBg2

  // Dashboard signature gradient
  static const _gOrange = Color(0xFFFF7B2C);
  static const _gPink = Color(0xFFEF4A8B);
  static const _gViolet = Color(0xFF8B5CF6);

  // HSE palette (matches Understanding HSE poster)
  static const _hseRed = Color(0xFFE53935);
  static const _hseAmber = Color(0xFFF6BF26);
  static const _hseGreen = Color(0xFF43A047);

  @override
  void initState() {
    super.initState();
    final loginService = Provider.of<LoginService>(context, listen: false);
    bloc = LoginPageBloc(loginService);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _userFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _userFocus.dispose();
    _passwordFocus.dispose();
    mobileUserTextController.dispose();
    mobilePassTextController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (mobileUserTextController.text.isEmpty ||
        mobilePassTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter both User Code and Password.')),
      );
      return;
    }
    bloc.logIn(
        mobileUserTextController.text, mobilePassTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, c) {
            final wide = c.maxWidth >= 1000;
            if (wide) {
              return Row(
                children: [
                  Expanded(flex: 6, child: _brandPanel()),
                  Expanded(flex: 5, child: _loginPanel()),
                ],
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  _brandPanel(compact: true),
                  _loginPanel(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ============ Brand panel ============
  Widget _brandPanel({bool compact = false}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_bg1, _bg2],
        ),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: compact ? 24 : 64, vertical: compact ? 32 : 56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _line),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.asset(
                  "assets/images/jindal-saw-logo.png",
                  height: compact ? 28 : 36,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  "JINDAL SAW LIMITED",
                  style: TextStyle(
                    color: _ink,
                    fontSize: compact ? 15 : 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: compact ? 18 : 28),
          // Gradient "Safety Portal" headline matching dashboard primary action
          ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              colors: [_gOrange, _gPink, _gViolet],
            ).createShader(rect),
            child: Text(
              "Safety Portal",
              style: TextStyle(
                color: Colors.white,
                fontSize: compact ? 36 : 56,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
                height: 1.05,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 5,
            width: 64,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_gOrange, _gPink, _gViolet],
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Text(
              "Report hazards. Track observations. Build a safer plant — together.",
              style: TextStyle(
                color: _muted,
                fontSize: compact ? 14 : 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: compact ? 28 : 44),
          // ============ Understanding HSE ============
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: compact ? 20 : 26,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.6,
              ),
              children: const [
                TextSpan(
                    text: "Understanding ",
                    style: TextStyle(color: _ink)),
                TextSpan(text: "H", style: TextStyle(color: _hseRed)),
                TextSpan(text: "S", style: TextStyle(color: _hseAmber)),
                TextSpan(text: "E", style: TextStyle(color: _hseGreen)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          compact
              ? Column(
                  children: const [
                    _HseCard(
                      icon: Icons.favorite_outline_rounded,
                      title: 'Health',
                      subtitle: 'Protecting Physical & Mental Well-being',
                      color: _hseRed,
                    ),
                    SizedBox(height: 10),
                    _HseCard(
                      icon: Icons.health_and_safety_outlined,
                      title: 'Safety',
                      subtitle: 'Preventing Accidents & Injuries',
                      color: _hseAmber,
                    ),
                    SizedBox(height: 10),
                    _HseCard(
                      icon: Icons.eco_outlined,
                      title: 'Environment',
                      subtitle: 'Minimizing Ecological Impact',
                      color: _hseGreen,
                    ),
                  ],
                )
              : Row(
                  children: const [
                    Expanded(
                      child: _HseCard(
                        icon: Icons.favorite_outline_rounded,
                        title: 'Health',
                        subtitle: 'Protecting Physical & Mental Well-being',
                        color: _hseRed,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _HseCard(
                        icon: Icons.health_and_safety_outlined,
                        title: 'Safety',
                        subtitle: 'Preventing Accidents & Injuries',
                        color: _hseAmber,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _HseCard(
                        icon: Icons.eco_outlined,
                        title: 'Environment',
                        subtitle: 'Minimizing Ecological Impact',
                        color: _hseGreen,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  // ============ Login panel ============
  Widget _loginPanel() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Plant location pill — teal (moved from brand panel, bigger)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 11),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF009688), Color(0xFF00ACC1)],
                      ),
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF009688).withOpacity(0.32),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.place_rounded,
                            size: 18, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "HARESAMUDRAM",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Gradient SIGN IN badge
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_gOrange, _gPink, _gViolet],
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "SIGN IN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  "Welcome back",
                  style: TextStyle(
                      color: _ink,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Sign in to continue to your dashboard",
                  style: TextStyle(
                      color: _muted,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 32),
                const _FieldLabel(label: 'User Code', accent: kcStatBlue),
                const SizedBox(height: 6),
                _MinimalInput(
                  controller: mobileUserTextController,
                  focusNode: _userFocus,
                  hint: 'Enter your user code',
                  icon: Icons.person_outline_rounded,
                  accent: kcStatBlue,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => _passwordFocus.requestFocus(),
                ),
                const SizedBox(height: 18),
                const _FieldLabel(label: 'Password', accent: kcHazardViolet),
                const SizedBox(height: 6),
                _MinimalInput(
                  controller: mobilePassTextController,
                  focusNode: _passwordFocus,
                  hint: 'Enter your password',
                  icon: Icons.lock_outline_rounded,
                  accent: kcHazardViolet,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submitLogin(),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: kcStatAmber,
                          fontWeight: FontWeight.w800,
                          fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                _buildLoginButton(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Facing any difficulty?",
                      style: TextStyle(
                          color: _muted,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "Contact Us",
                        style: TextStyle(
                            color: _gPink,
                            fontWeight: FontWeight.w800,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return BlocConsumer<LoginPageBloc, LoginState>(
      bloc: bloc,
      listener: (_, state) {
        state.maybeWhen(
            success: (_) {
              Navigator.pushNamed(context, AppRoutes.dashboardSelection);
            },
            failed: (_, message) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            },
            orElse: () {});
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: (_) => Container(
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_gOrange, _gPink, _gViolet],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Lottie.asset("assets/lottie/loading.json",
                height: 34, width: 34),
          ),
          orElse: () {
            return _GradientButton(
              label: 'Sign In',
              onPressed: _submitLogin,
            );
          },
        );
      },
    );
  }
}

// ============ Field label ============
class _FieldLabel extends StatelessWidget {
  final String label;
  final Color accent;
  const _FieldLabel({required this.label, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 14,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: _LoginPageState._ink,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ============ Minimal input field ============
class _MinimalInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final IconData icon;
  final Color accent;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  const _MinimalInput({
    required this.controller,
    required this.focusNode,
    required this.hint,
    required this.icon,
    required this.accent,
    this.isPassword = false,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  State<_MinimalInput> createState() => _MinimalInputState();
}

class _MinimalInputState extends State<_MinimalInput> {
  bool _obscure = true;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocus);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocus);
    super.dispose();
  }

  void _onFocus() {
    if (mounted) setState(() => _focused = widget.focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: _focused ? widget.accent.withOpacity(0.04) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _focused ? widget.accent : _LoginPageState._line,
          width: _focused ? 1.6 : 1.0,
        ),
        boxShadow: _focused
            ? [
                BoxShadow(
                  color: widget.accent.withOpacity(0.18),
                  blurRadius: 0,
                  spreadRadius: 3,
                ),
              ]
            : null,
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: widget.isPassword && _obscure,
        textInputAction: widget.textInputAction,
        onSubmitted: widget.onSubmitted,
        cursorColor: widget.accent,
        style: const TextStyle(
            color: _LoginPageState._ink,
            fontSize: 14,
            fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: const TextStyle(
              color: _LoginPageState._muted,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: widget.accent.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(widget.icon, color: widget.accent, size: 16),
            ),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: _LoginPageState._muted,
                    size: 18,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                )
              : null,
        ),
      ),
    );
  }
}

// ============ Gradient button (matches dashboard primary action) ============
class _GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _GradientButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Ink(
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _LoginPageState._gOrange,
                _LoginPageState._gPink,
                _LoginPageState._gViolet,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _LoginPageState._gPink.withOpacity(0.38),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded,
                  color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ HSE card (Health / Safety / Environment) ============
class _HseCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _HseCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.35), width: 1.4),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.12),
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _LoginPageState._muted,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
