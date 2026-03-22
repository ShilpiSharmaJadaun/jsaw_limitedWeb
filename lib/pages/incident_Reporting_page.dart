import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_color.dart';

class IncidentReportingPage extends StatefulWidget {
  const IncidentReportingPage({super.key});

  @override
  State<IncidentReportingPage> createState() => _IncidentReportingPageState();
}

class _IncidentReportingPageState extends State<IncidentReportingPage> {

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
        dateController.text =
        "${picked.day.toString().padLeft(2, '0')}/"
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

        dateTimeController.text = DateFormat('yyyy-MM-dd HH:mm:ss').format(fullDateTime);
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
        
                /// 🔹 Row 1 : Unique Id + Date (parallel)
                Row(
                  children: [
        
                    /// Unique Id
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Unique Id"),
                          const SizedBox(width: 10),
        
                          /// IMPORTANT: wrap dropdown with Expanded
                          Expanded(child: _buildUniqueIdDropdown()),
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
                              style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Date"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildDateTextField()),
                        ],
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 20),
        
                /// 🔹 Row 2 : Time + Shift
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Time"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildTimeTextField()),
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
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Shift"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("A")),
                        ],
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 20),
        
                /// 🔹 Row 3 : Employee Code + Employee Name
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Employee Code"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("35016051")),
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
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Employee Name"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("Avadesh Kumar")),
                        ],
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 20),
        
                /// 🔹Row 4 : Age + Contractor Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Age"),
                          const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("31")),
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
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Contractor Name"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("MAA LAXMI ENT")),
                        ],
                      ),
                    ),
                  ],
                ),
        
                /// Row 5 : Plant + Dept
                const SizedBox(height: 20),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Plant "),
                          const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("DI")),
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
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Dept Name"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("CCM")),
                        ],
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 20),
        
                ///Row 6 :  Location+ Responsible Shit Engg
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Location "),
                          const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("New Yard")),
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
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Responsible Shift Engg"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("Ravi")),
                        ],
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 20),
        
                /// ROw 7 : Responsible HOD + Contact Num
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Responsible HOD "),
                          const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("Shankar Rao")),
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
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Contact Number"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildInfoText("8511172947")),
                        ],
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 20),

                ///Row 8  incident Type and Work on injury

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Incident Type "),
                          const SizedBox(width: 10),
                          Expanded(child: _buildIncidentTypeDropdown()),
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
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("Work Injury"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildWorkInjuryDropdown()),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Row 9 : incident Details and FIR date and time

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset("assets/images/uniqueid.png", scale: 20),
                          const SizedBox(width: 4),
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          const SizedBox(width: 4),
                          _buildHeadingText("Descp. of Incident"),
                          const SizedBox(width: 10),
                          Expanded(child:  _buildDetailsTextField()),
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
                          const Text("*", style: TextStyle(color: Colors.red, fontSize: 18)),
                          // const SizedBox(width: 4),
                          _buildHeadingText("FIR Date & Time"),
                          // const SizedBox(width: 10),
                          Expanded(child: _buildFIRDateTime()),
                        ],
                      ),
                    ),
                  ],
                ),
        

        
        
              ],
            ),
          ),
        ),
      )
    );
  }


  Widget _buildUniqueIdDropdown() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _buildUniqueIdListDialog();
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

  Future<void> _buildUniqueIdListDialog() {
    final List<String> plants = [
      "2010002",
      "1234900",
      "1202930",
      "2346178"
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
              final int hour12 = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
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

  _buildHeadingText(String title){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 100,
        child: Text(title, style: const TextStyle( fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black),),
      ),
    );
  }

  _buildInfoText(String title){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 100,                 // ✅ fixed width
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: kcWhite,           // ✅ white background// ✅ black border
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
    final List<String> plants = [
      "IOW",
      "IOD",
      "NA"
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

  _buildFIRDateTime(){
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
      borderSide:   const BorderSide(color: kcDarkGreyColor,width: 1.5)
  );


}

