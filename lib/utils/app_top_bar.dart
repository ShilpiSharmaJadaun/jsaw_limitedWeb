import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'app_color.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({ key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: kcWhite,
        ),
      ),
      centerTitle: true,
      title: Image.asset("assets/images/jindal-saw-logo-removebg-preview.png", scale: 0.5.screenWidth,),
      actions: [
        TextButton(onPressed: (){}, child: Text("Logout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kcWhite),)),
      ],
    );
  }

  static final _appBar = AppBar();

  @override
  Size get preferredSize => _appBar.preferredSize;
}
