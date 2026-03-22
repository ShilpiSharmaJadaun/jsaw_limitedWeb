import 'package:flutter/material.dart';
import '../utils/app_color.dart';

class MedicalOfficerPage extends StatefulWidget {
  const MedicalOfficerPage({super.key});

  @override
  State<MedicalOfficerPage> createState() => _MedicalOfficerPageState();
}

class _MedicalOfficerPageState extends State<MedicalOfficerPage> {
  String selectedInjuryType = "Select Injury Type";
  String selectedBodyPaty = "Select Body Part";
  String selectedNatureOfInjury = "Select Nature Of Injury";
  String employeeName = "Select Employee Name";

  late final TextEditingController detailsController;
  late final TextEditingController dateController;
  DateTime? selectedDate;

  Map<String, String>? selectedEmployee;

  final List<Map<String, String>> employees = [
    {
      "name": "Prashant",
      "department": "CCM",
      "uniqueId": "HSM/IR&T/10/2025/01",
      "engineer": "Ravi",
      "description": "LEFT THUMB FINGER BLUNT INJURY",
      "age": "31",
      "contractor": "ABC Contractor",
    },
    {
      "name": "Ram",
      "department": "SMS",
      "uniqueId": "HSM/IR&T/10/2025/02",
      "engineer": "Amit",
      "description": "RIGHT HAND MINOR CUT",
      "age": "28",
      "contractor": "XYZ Contractor",
    },
    {
      "name": "Arjun",
      "department": "Utility",
      "uniqueId": "HSM/IR&T/10/2025/03",
      "engineer": "Suresh",
      "description": "LEG INJURY",
      "age": "35",
      "contractor": "PQR Contractor",
    },
    {
      "name": "Ravi",
      "department": "Mechanical",
      "uniqueId": "HSM/IR&T/10/2025/04",
      "engineer": "Manoj",
      "description": "HAND CUT INJURY",
      "age": "30",
      "contractor": "LMN Contractor",
    },
  ];

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
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              /// Employee Details
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset("assets/images/uniqueid.png", scale: 20),
                        const SizedBox(width: 4),
                        const Text("*",
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                        const SizedBox(width: 4),
                        _buildHeadingText("Select Employee"),
                        const SizedBox(width: 10),
                        Expanded(child: _buildEmployeeNameDropdown()),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset("assets/images/date.png", scale: 20),
                        const SizedBox(width: 4),
                        const Text("*",
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                        const SizedBox(width: 4),
                        _buildHeadingText("Department"),
                        const SizedBox(width: 10),
                        if (selectedEmployee != null)
                          Expanded(
                            child: _buildInfoText(
                              selectedEmployee?["department"] ?? "",
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Unique Id + Responsible Engineer
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset("assets/images/uniqueid.png", scale: 20),
                        const SizedBox(width: 4),
                        const Text("*",
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                        const SizedBox(width: 4),
                        _buildHeadingText("Unique Id"),
                        const SizedBox(width: 10),
                        if (selectedEmployee != null)
                          Expanded(
                            child: _buildInfoText(
                              selectedEmployee?["uniqueId"] ?? "",
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset("assets/images/date.png", scale: 20),
                        const SizedBox(width: 4),
                        const Text("*",
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                        const SizedBox(width: 4),
                        _buildHeadingText("Responsible Engineer"),
                        const SizedBox(width: 10),
                        if (selectedEmployee != null)
                          Expanded(
                            child: _buildInfoText(
                              selectedEmployee?["engineer"] ?? "",
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Description + Age
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset("assets/images/uniqueid.png", scale: 20),
                        const SizedBox(width: 4),
                        const Text("*",
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                        const SizedBox(width: 4),
                        _buildHeadingText("Description"),
                        const SizedBox(width: 10),
                        if (selectedEmployee != null)
                          Expanded(
                            child: _buildInfoText(
                              selectedEmployee?["description"] ?? "",
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset("assets/images/date.png", scale: 20),
                        const SizedBox(width: 4),
                        const Text("*",
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                        const SizedBox(width: 4),
                        _buildHeadingText("Age"),
                        const SizedBox(width: 10),
                        if (selectedEmployee != null)
                          Expanded(
                            child: _buildInfoText(
                              selectedEmployee?["age"] ?? "",
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Type Injury + Body Part
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset("assets/images/uniqueid.png", scale: 20),
                        const SizedBox(width: 4),
                        const Text("*",
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                        const SizedBox(width: 4),
                        _buildHeadingText("Type Of Injury"),
                        const SizedBox(width: 10),
                        Expanded(child: _buildInjuryTypeDropdown()),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset("assets/images/date.png", scale: 20),
                        const SizedBox(width: 4),
                        const Text("*",
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                        const SizedBox(width: 4),
                        _buildHeadingText("Body Part"),
                        const SizedBox(width: 10),
                        Expanded(child: _buildBodyTypeDropdown()),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Nature of Injury + Rest Upto
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset("assets/images/uniqueid.png", scale: 20),
                        const SizedBox(width: 4),
                        const Text("*",
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                        const SizedBox(width: 4),
                        _buildHeadingText("Nature Of Injury"),
                        const SizedBox(width: 10),
                        Expanded(child: _buildNatureOfInjuryDropdown()),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset("assets/images/date.png", scale: 20),
                        const SizedBox(width: 4),
                        const Text("*",
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                        const SizedBox(width: 4),
                        _buildHeadingText("Rest Upto in Days"),
                        const SizedBox(width: 10),
                        Expanded(child: _buildDetailsTextField()),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

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

  Widget _buildEmployeeNameDropdown() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: _buildEmployeeListDialog,
        child: SizedBox(
          width: 200,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: kcWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      employeeName,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: employeeName == "Select Employee Name"
                            ? kcDarkGreyColor
                            : kcLightGrey,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down_sharp),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _buildEmployeeListDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          title: const Text(
            "Select Employee",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 200,
            height: 300,
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      employeeName = employee["name"] ?? "Select Employee Name";
                      selectedEmployee = employee;
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(employee["name"] ?? ""),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }

  Widget _buildInjuryTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildinjuryTypeListDialog();
        },
        child: SizedBox(
          width: 200,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: kcWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      selectedInjuryType,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: selectedInjuryType == "Select Injury Type"
                            ? kcDarkGreyColor
                            : kcLightGrey,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down_sharp)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _buildinjuryTypeListDialog() {
    final List<String> plants = [
      "Mechanical Injury",
      "Chemical Injury",
      "Electrical Injury",
      "Thermal Injury"
    ];

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          title: const Text(
            "Select Injury Type",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 200,
            height: 300,
            child: ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedInjuryType = plants[index];
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(plants[index]),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }

  Widget _buildBodyTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildBodyPartListDialog();
        },
        child: SizedBox(
          width: 200,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: kcWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      selectedBodyPaty,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: selectedBodyPaty == "Select Body Part"
                            ? kcDarkGreyColor
                            : kcLightGrey,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down_sharp)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _buildBodyPartListDialog() {
    final List<String> bodyPart = [
      "Back Upper",
      "Leg",
      "Hand",
      "Face"
    ];

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          title: const Text(
            "Select Body Part",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 200,
            height: 300,
            child: ListView.builder(
              itemCount: bodyPart.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedBodyPaty = bodyPart[index];
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(bodyPart[index]),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }

  Widget _buildNatureOfInjuryDropdown() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildNatureOfInjuryListDialog();
        },
        child: SizedBox(
          width: 200,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: kcWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      selectedNatureOfInjury,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color:
                        selectedNatureOfInjury == "Select Nature Of Injury"
                            ? kcDarkGreyColor
                            : kcLightGrey,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down_sharp)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _buildNatureOfInjuryListDialog() {
    final List<String> natureOfInjury = [
      "Mechanical Injury",
      "Chemical Injury",
      "Electrical Injury",
      "Thermal Injury"
    ];

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          title: const Text(
            "Select Nature Of Injury",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 200,
            height: 300,
            child: ListView.builder(
              itemCount: natureOfInjury.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedNatureOfInjury = natureOfInjury[index];
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(natureOfInjury[index]),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            )
          ],
        );
      },
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