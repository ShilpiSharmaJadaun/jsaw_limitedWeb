import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'app_color.dart';

class PageHeader extends StatelessWidget {
  final String title;
  PageHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    //print(  MediaQuery.of(context).size.width - 200);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 200,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [navyBlue, cream, golden]),
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
          ],
        ),
      ),
    );
  }
}
