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
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            onPressed: () => Navigator.of(context).maybePop(true),
            tooltip: 'Back',
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: kcWhite,
                letterSpacing: 0.3,
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
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {

                Navigator.pop(context, true);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
