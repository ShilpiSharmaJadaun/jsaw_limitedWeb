import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class SafetyRemarkPage extends StatefulWidget {
  const SafetyRemarkPage({super.key});

  @override
  State<SafetyRemarkPage> createState() => _SafetyRemarkPageState();
}

class _SafetyRemarkPageState extends State<SafetyRemarkPage> {

  late final TextEditingController safetyRemarkController;


  @override
  void initState() {
    super.initState();
    safetyRemarkController = TextEditingController();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          _buildSafetyRemarkTextField(),
          Row(
            children: [
              _buildHeadingText("FIR Received Date"),
              _buildInfoText("12/03/2026")

            ],
          ),
          ElevatedButton(onPressed: (){}, child: Text("Submit"))
        ],
      )),
    );
  }


  Widget _buildSafetyRemarkTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: safetyRemarkController,
        maxLines: 10,
        minLines: 1,
        decoration: InputDecoration(
          hintText: "Enter details",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildHeadingText(String title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 100,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String title) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
