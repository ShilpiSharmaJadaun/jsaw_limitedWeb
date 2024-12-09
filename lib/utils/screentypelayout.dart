import 'package:flutter/material.dart';

class ResponsiveAppScreen extends StatelessWidget {
  final Widget smallScreen;
  final Widget mediumScreen;
  final Widget largeScreen;
  final Widget extraLargeScreen;

  const ResponsiveAppScreen({
    required this.smallScreen,
    required this.mediumScreen,
    required this.largeScreen,
    required this.extraLargeScreen,
  });

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 && MediaQuery.of(context).size.width < 1200;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200 && MediaQuery.of(context).size.width < 1600;
  }

  static bool isExtraLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1600;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1600) {
          return extraLargeScreen;
        } else if (constraints.maxWidth >= 1200) {
          return largeScreen;
        } else if (constraints.maxWidth >= 800) {
          return mediumScreen;
        } else {
          return smallScreen;
        }
      },
    );
  }
}
