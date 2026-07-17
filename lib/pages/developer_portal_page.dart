import 'package:flutter/material.dart';
import 'package:jsaw_limited/pages/admin_complaints_page.dart';
import 'package:jsaw_limited/utils/app_color.dart';
import 'package:web/web.dart' as html;

class DeveloperPortalPage extends StatelessWidget {
  const DeveloperPortalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _DeveloperHeader(),
          const Expanded(child: AdminComplaintsPage()),
        ],
      ),
    );
  }
}

class _DeveloperHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: kcWhite,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.support_agent,
                color: Color(0xFF10B981), size: 22),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Support Portal',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: kcValueDark,
                      letterSpacing: 0.3)),
              Text('JSAW — Developer Access',
                  style: TextStyle(
                      fontSize: 11,
                      color: kcLabelGrey,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () {
              html.window.localStorage.removeItem('kAuthToken');
              html.window.localStorage.removeItem('kEmployeename');
              html.window.localStorage.removeItem('kDevPortal');
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/developer-login',
                (_) => false,
              );
            },
            icon: const Icon(Icons.logout, size: 16, color: Color(0xFFEF4444)),
            label: const Text('Logout',
                style: TextStyle(
                    color: Color(0xFFEF4444),
                    fontWeight: FontWeight.w700,
                    fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
