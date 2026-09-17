import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web/web.dart' show window;
import '../pages/common_navigation_page.dart';
import '../pages/profile_page.dart';
import 'app_color.dart';

/// Slim header for *nested* pages (e.g. detail / edit screens pushed inside a
/// nested Navigator). Just a back arrow + title — no profile avatar, since the
/// outer [PageHeader] already shows it. Used to avoid duplicate top bars.
class SubPageHeader extends StatelessWidget {
  final String title;
  const SubPageHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return InlineHeaderBand(
      child: Row(
        children: [
          InlineBackButton(
            label: 'Back',
            onPressed: () => Navigator.of(context).maybePop(true),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: kInlineHeaderInk,
                letterSpacing: 0.2,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  final String title;
  PageHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    //print(  MediaQuery.of(context).size.width - 200);
    final empName = window.localStorage.getItem('kEmployeename') ?? '';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF7B2C), Color(0xFFEF4A8B), Color(0xFF8B5CF6)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFEF4A8B).withOpacity(0.18),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // No back arrow here: this header sits on the app shell whose only
            // route below is the Login page, so a pop would log the user out
            // (customer bug list 28-Aug-2026, point 10). In-app back buttons
            // live on the sub-pages themselves.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: kcWhite,
                ),
              ),
            ),
            const Spacer(),
            _ProfileButton(name: empName),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  final String name;
  const _ProfileButton({required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final show = CommonNavigationPage.showPage;
        if (show != null) {
          show('Profile', const ProfilePage());
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ProfilePage()),
          );
        }
      },
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (name.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  name,
                  style: const TextStyle(
                    color: kcWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            CircleAvatar(
              radius: 18,
              backgroundColor: kcWhite,
              child: Text(
                _initials(name),
                style: const TextStyle(
                  color: navyBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}

/// Back control for pages opened INLINE inside the app shell (Compliance
/// Review / Closure detail, All Incident → View, Check Details, the Medical
/// and Safety forms, Edit Investigation …). Replaces the bare white arrow
/// (user request 29-Aug-2026: the arrow looked like the removed
/// "back-to-login" arrow). A white pill with a chevron and a label that says
/// where it goes; sits on the page's gradient header band.
class InlineBackButton extends StatefulWidget {
  const InlineBackButton({
    super.key,
    required this.onPressed,
    this.label = 'Back to list',
  });

  final VoidCallback? onPressed;
  final String label;

  @override
  State<InlineBackButton> createState() => _InlineBackButtonState();
}

class _InlineBackButtonState extends State<InlineBackButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    // Design 9 (user's pick, 29-Aug-2026): a bare, larger "«" double chevron
    // on the gradient band — no container, a faint drop shadow so it reads on
    // the light part of the gradient, and only a light tint on hover. The
    // label lives in the tooltip.
    return Tooltip(
      message: widget.label,
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Material(
            color: _hover
                ? kInlineHeaderAccent.withValues(alpha: 0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Icon(
                  Icons.keyboard_double_arrow_left_rounded,
                  size: 28,
                  color: kInlineHeaderAccent,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Text colour on the inline header band (design 40-b).
const Color kInlineHeaderInk = kcValueDark;

/// Accent used by the inline header band for the « chevron, chips and
/// buttons: the pink from the middle of the app gradient.
const Color kInlineHeaderAccent = Color(0xFFEF4A8B);

/// Header band for pages opened INLINE inside the app shell — design "40-b"
/// chosen by the user on 29-Aug-2026 out of ~90 mock-ups: a white card with an
/// 8 px app-gradient bar across the top, dark text and the pink « chevron, so
/// it reads as a detail page and never as a second main header.
class InlineHeaderBand extends StatelessWidget {
  const InlineHeaderBand({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(8, 6, 14, 8),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kcVeryLightGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 8,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF7B2C), Color(0xFFEF4A8B), Color(0xFF8B5CF6)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

/// Small accent chip for the inline header (incident ID, incident type…).
class InlineHeaderChip extends StatelessWidget {
  const InlineHeaderChip(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: kInlineHeaderAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kInlineHeaderAccent.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: kInlineHeaderAccent, fontSize: 12, fontWeight: FontWeight.w700),
      ),
    );
  }
}
