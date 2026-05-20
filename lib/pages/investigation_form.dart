import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class InvestigationFormPage extends StatefulWidget {
  const InvestigationFormPage({super.key});

  @override
  State<InvestigationFormPage> createState() => _InvestigationFormPageState();
}

class _InvestigationFormPageState extends State<InvestigationFormPage> {

  late final TextEditingController detailsController;
  late final TextEditingController dateController;
  DateTime? selectedDate;

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text =
        "${picked.day.toString().padLeft(2, '0')}/"
            "${picked.month.toString().padLeft(2, '0')}/"
            "${picked.year}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    detailsController = TextEditingController();

  }

  @override
  void dispose() {
    dateController.dispose();
    detailsController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              _buildHeadingText("Safety Remark"),
              Expanded(child: _buildDetailsTextField()),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 500,
                child: Row(
                  children: [
                    Image.asset("assets/images/date.png", scale: 20),
                    const SizedBox(width: 4),
                    const Text("*",
                        style: TextStyle(color: Colors.red, fontSize: 18)),
                    const SizedBox(width: 4),
                    _buildHeadingText("Fit for Duty from Date"),
                    const SizedBox(width: 10),
                    Expanded(child: _buildDateTextField()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildHeadingText(String title) {
    return Padding(
      padding: const EdgeInsets.all(5),
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

  Widget _buildDetailsTextField() {
    return TextFormField(
      controller: detailsController,
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
    );
  }

  Widget _buildDateTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        height: 30,
        child: TextField(
          controller: dateController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: "Select date",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onTap: _pickDate,
        ),
      ),
    );
  }
}
