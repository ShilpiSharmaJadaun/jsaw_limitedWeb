import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_color.dart';

class InvestigationTeamPage extends StatefulWidget {
  const InvestigationTeamPage({super.key});

  @override
  State<InvestigationTeamPage> createState() => _InvestigationTeamPageState();
}

class _InvestigationTeamPageState extends State<InvestigationTeamPage> {
  String selectedPlant = "Select Unique Id";

  late final TextEditingController dateController;
  DateTime? selectedDate;
  late final TextEditingController timeController;
  TimeOfDay? selectedTime;

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
        dateController.text = "${picked.day.toString().padLeft(2, '0')}/"
            "${picked.month.toString().padLeft(2, '0')}/"
            "${picked.year}";
      });
    }
  }

  late final TextEditingController detailsController;

  TextEditingController dateTimeController = TextEditingController();

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 2)),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime fullDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        dateTimeController.text =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(fullDateTime);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    timeController = TextEditingController();
    detailsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        _buildHeadingText("Reporting Image"),
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset("assets/images/adhyamLogo.png"),
                        ),
                      ],
                    ), Column(
                      children: [
                        _buildHeadingText("Compliance Image"),
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset("assets/images/compareimage.png"),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    /// Unique Id
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Investigation Team"),
                          const SizedBox(width: 10),

                          /// IMPORTANT: wrap dropdown with Expanded
                          Expanded(child: _buildInvestigationTeam()),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    /// Date
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/date.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Incident Report Date"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildDateTextField()),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Image.asset("assets/images/uniqueid.png",
                                scale: 20),
                            const SizedBox(width: 4),
                            const Text("*",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18)),
                            const SizedBox(width: 4),
                            _buildHeadingText("Root Cause"),
                            const SizedBox(width: 10),

                            /// IMPORTANT: wrap dropdown with Expanded
                            Expanded(child: _buildRootCause()),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          children: [
                            Image.asset("assets/images/uniqueid.png",
                                scale: 20),
                            const SizedBox(width: 4),
                            const Text("*",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18)),
                            const SizedBox(width: 4),
                            _buildHeadingText("CorrectiveAction"),
                            const SizedBox(width: 10),
                            Expanded(child: _buildDetailsTextField()),
                          ],
                        ),
                      ),
                    ]),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Preventive Action taken"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildDetailsTextField()),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/images/date.png", scale: 20),
                          // const SizedBox(width: 4),
                          const Text("*",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Responsible Egg Code"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("110062")),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/images/date.png", scale: 20),
                          // const SizedBox(width: 4),
                          const Text("*",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Responsible Shift Engg"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("Ravi")),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/images/date.png", scale: 20),
                          // const SizedBox(width: 4),
                          const Text("*",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Responsible Dept"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("CCM")),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText(
                              "Associated risk identified and evaluated"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildDetailsTextField()),
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
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Target Date"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildDateTextField()),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/date.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Action Compliance Date"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildDateTextField()),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/images/date.png", scale: 20),
                          // const SizedBox(width: 4),
                          const Text("*",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Status"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("Closed")),
                        ],
                      ),
                    ),
                  ],
                ),

                ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(backgroundColor: kclightOrange),
                    child: Text("Submit",style: TextStyle(color: kcWhite),)),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInvestigationTeam() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildInvestigationTeamList();
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
                      selectedPlant,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: selectedPlant == "Select Unique Id"
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

  Future<void> _buildInvestigationTeamList() {
    final List<String> plants = ["P1", "P2", "P3", "P4"];

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          title: const Text(
            "Select plant",
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
                      selectedPlant = plants[index]; // ✅ selected value shown
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

  Widget _buildRootCause() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildRootCauseList();
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
                      selectedPlant,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: selectedPlant == "Select Unique Id"
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

  Future<void> _buildRootCauseList() {
    final List<String> plants = ["R1", "R2", "R3", "R4"];

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          title: const Text(
            "Select plant",
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
                      selectedPlant = plants[index]; // ✅ selected value shown
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

  Widget _buildTimeTextField() {
    return SizedBox(
      width: 150,
      height: 30,
      child: TextFormField(
        controller: timeController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "Select time",
          prefixIcon: const Icon(Icons.access_time),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onTap: () async {
          final TimeOfDay now = TimeOfDay.now();

          final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: selectedTime ?? now,
          );

          if (picked != null) {
            setState(() {
              selectedTime = picked;

              // ✅ 12-hr formatted text like 08:30 PM
              final int hour12 =
                  picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
              final String hh = hour12.toString().padLeft(2, '0');
              final String mm = picked.minute.toString().padLeft(2, '0');
              final String ampm = picked.period == DayPeriod.am ? "AM" : "PM";

              timeController.text = "$hh:$mm $ampm";
            });
          }
        },
      ),
    );
  }

  _buildHeadingText(String title) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 100,
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }

  _buildInfoText(String title) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 100, // ✅ fixed width
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: kcWhite, // ✅ white background// ✅ black border
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
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

  Widget _buildIncidentTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildIncidentTypeListDialog();
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
                      selectedPlant,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: selectedPlant == "Select Unique Id"
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

  Future<void> _buildIncidentTypeListDialog() {
    final List<String> plants = [
      "Injury (IOW)",
      "Near Miss (NM)",
      "Property Damage Incident (DO)",
      "Road Traffic Accident (RTA)",
      "Fire (FI)",
      "Environmental Incidents (EI)"
    ];

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          title: const Text(
            "Select plant",
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
                      selectedPlant = plants[index]; // ✅ selected value shown
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

  Widget _buildWorkInjuryDropdown() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildWorkInjuryListDialog();
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
                      selectedPlant,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: selectedPlant == "Select Unique Id"
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

  Future<void> _buildWorkInjuryListDialog() {
    final List<String> plants = ["IOW", "IOD", "NA"];

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          title: const Text(
            "Select plant",
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
                      selectedPlant = plants[index]; // ✅ selected value shown
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

  _buildFIRDateTime() {
    return SizedBox(
      width: 250,
      child: GestureDetector(
        onTap: () => _selectDateTime(context),
        child: AbsorbPointer(
          child: TextField(
            controller: dateTimeController,
            textAlign: TextAlign.start,
            minLines: 1,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: kcvoilet,
            ),
            decoration: InputDecoration(
              hintText: "Time of Occurrence",
              contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
              hintStyle: const TextStyle(
                fontSize: 12,
                color: kcMediumGrey,
              ),
              fillColor: Colors.transparent,
              filled: true,
              border: _border(),
              focusedBorder: _border(),
              enabledBorder: _border(),
            ),
          ),
        ),
      ),
    );
  }

  _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: kcDarkGreyColor, width: 1.5));
}
