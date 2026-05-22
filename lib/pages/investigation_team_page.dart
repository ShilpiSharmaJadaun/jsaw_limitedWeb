import 'package:flutter/foundation.dart' show Uint8List;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/allemployee_model.dart';
import '../service/employee_reporting_service.dart';
import '../utils/app_color.dart';
import 'image_picker.dart';

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

  // ---------- CAPA table state ----------
  List<_CapaRow> _capaRows = [];
  List<AllEmployeeModel> _allEmployees = [];
  bool _loadingEmployees = false;
  String? _employeesError;

  // ---------- Root Cause inputs ----------
  static const int _maxRootCauses = 2;
  List<TextEditingController> _rootCauseControllers = [];

  // ---------- Investigation Team ----------
  static const int _maxTeamMembers = 6;
  List<AllEmployeeModel?> _investigationTeam = [];

  // ---------- Report date (today, read-only) ----------
  late final TextEditingController _reportDateController;

  // ---------- Associated Risk image ----------
  dynamic _associatedRiskImage;
  Uint8List? _associatedRiskBytes;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    timeController = TextEditingController();
    detailsController = TextEditingController();
    _capaRows = [_CapaRow()];
    _rootCauseControllers = [TextEditingController()];
    _investigationTeam = [null];
    final today = DateTime.now();
    _reportDateController = TextEditingController(
      text: "${today.day.toString().padLeft(2, '0')}/"
          "${today.month.toString().padLeft(2, '0')}/"
          "${today.year}",
    );
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    setState(() {
      _loadingEmployees = true;
      _employeesError = null;
    });
    try {
      final service =
          Provider.of<EmployeeReportingService>(context, listen: false);
      final list = await service.getAllEmployee();
      if (!mounted) return;
      setState(() {
        _allEmployees = list;
        _loadingEmployees = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadingEmployees = false;
        _employeesError = e.toString();
      });
    }
  }

  @override
  void dispose() {
    for (final r in _capaRows) {
      r.dispose();
    }
    for (final c in _rootCauseControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addRootCause() {
    if (_rootCauseControllers.isEmpty ||
        _rootCauseControllers.last.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Please fill the current Root Cause first.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    if (_rootCauseControllers.length >= _maxRootCauses) return;
    setState(() => _rootCauseControllers.add(TextEditingController()));
  }

  void _removeRootCause(int index) {
    if (_rootCauseControllers.length <= 1) return;
    setState(() => _rootCauseControllers.removeAt(index).dispose());
  }

  void _addTeamMember() {
    if (_investigationTeam.isEmpty || _investigationTeam.last == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select an employee in the current row first.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    if (_investigationTeam.length >= _maxTeamMembers) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maximum 6 team members allowed.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() => _investigationTeam.add(null));
  }

  void _removeTeamMember(int index) {
    if (_investigationTeam.length <= 1) return;
    setState(() => _investigationTeam.removeAt(index));
  }

  Future<void> _pickTeamMember(int index) async {
    final picked = await showDialog<AllEmployeeModel>(
      context: context,
      builder: (ctx) => _EmployeePickerDialog(employees: _allEmployees),
    );
    if (picked != null) {
      setState(() => _investigationTeam[index] = picked);
    }
  }

  bool _isCapaRowValid(_CapaRow r) =>
      r.capaController.text.trim().isNotEmpty &&
      r.employee != null &&
      r.targetDate != null;

  void _addCapaRow() {
    if (_capaRows.isEmpty || !_isCapaRowValid(_capaRows.last)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Please fill CAPA, Responsible Employee and Target Date in the current row first.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    if (_capaRows.length >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maximum 6 CAPA entries allowed.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() => _capaRows.add(_CapaRow()));
  }

  void _removeCapaRow(int index) {
    if (_capaRows.length <= 1) return;
    setState(() {
      _capaRows.removeAt(index).dispose();
    });
  }

  Future<void> _pickTargetDate(_CapaRow row) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: row.targetDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      row.targetDate = picked;
      row.targetDateController.text =
          "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcDashboardBg1,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kcDashboardBg1, kcDashboardBg2],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: kcWhite,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _pageBanner(),
                const SizedBox(height: 20),

                _labeledField(
                  icon: Icons.qr_code_2,
                  color: kcStatBlue,
                  label: 'Select Unique Id',
                  required: true,
                  child: _buildInvestigationTeam(),
                ),

                const SizedBox(height: 20),

                _buildInvestigationTeamSection(),

                const SizedBox(height: 20),

                _labeledField(
                  icon: Icons.event_outlined,
                  color: kcStatAmber,
                  label: 'Report Date',
                  required: true,
                  child: _buildReportDateField(),
                ),

                const SizedBox(height: 20),

                _buildRootCauseInputs(),

                const SizedBox(height: 20),

                _buildCapaTable(),

                const SizedBox(height: 20),

                _buildAssociatedRiskSection(),

                const SizedBox(height: 24),

                _submitButton(),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pageBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [navyBlue, kcvoilet],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: kcvoilet.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kcWhite.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.fact_check_outlined,
                color: kcWhite, size: 26),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Investigation Report',
                style: TextStyle(
                    color: kcWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 2),
              Text(
                'Capture root cause, CAPA, team and evidence.',
                style: TextStyle(color: cream, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _labeledField({
    required IconData icon,
    required Color color,
    required String label,
    required Widget child,
    bool required = false,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: kcValueDark,
          ),
        ),
        if (required)
          const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text('*',
                style: TextStyle(color: Colors.red, fontSize: 16)),
          ),
        const SizedBox(width: 12),
        Expanded(child: child),
      ],
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.check_circle_outline, color: kcWhite),
        label: const Text(
          'Submit Investigation Report',
          style: TextStyle(
              color: kcWhite, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kcobservationgreen,
          padding: const EdgeInsets.symmetric(vertical: 14),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
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

  // ============== Report Date (today, read-only) ==============

  Widget _buildReportDateField() {
    return TextField(
      controller: _reportDateController,
      readOnly: true,
      enabled: false,
      style: const TextStyle(color: kcValueDark, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: kcVeryLightGrey,
        suffixIcon: const Icon(Icons.lock_outline, size: 16),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }

  // ============== Associated Risk Photo ==============

  Widget _buildAssociatedRiskSection() {
    return Container(
      decoration: BoxDecoration(
        color: kcWhite,
        border: Border.all(color: kcmegenta.withOpacity(0.25)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kcmegenta, kcInfoFir],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: const [
                Icon(Icons.image_outlined, color: kcWhite, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Associated Risk Identified & Evaluated — '
                    'Aspect / Hazard Register Photo',
                    style: TextStyle(
                        color: kcWhite,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Text('*',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ImagePickerPage(
              onImagePicked: (image, [bytes]) {
                setState(() {
                  _associatedRiskImage = image;
                  _associatedRiskBytes = bytes;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============== Investigation Team ==============

  Widget _buildInvestigationTeamSection() {
    final canAdd = _investigationTeam.length < _maxTeamMembers &&
        _investigationTeam.isNotEmpty &&
        _investigationTeam.last != null;
    return Container(
      decoration: BoxDecoration(
        color: kcWhite,
        border: Border.all(color: kcvoilet.withOpacity(0.25)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kcvoilet, kcInfoResponsibility],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.groups_outlined, color: kcWhite, size: 18),
                const SizedBox(width: 8),
                const Text(
                  'Investigation Team',
                  style: TextStyle(
                      color: kcWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 8),
                const Text('(optional, max 6)',
                    style: TextStyle(color: cream, fontSize: 11)),
                const Spacer(),
                Text(
                  '${_investigationTeam.length} / $_maxTeamMembers',
                  style: const TextStyle(
                      color: kcWhite,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          for (int i = 0; i < _investigationTeam.length; i++)
            _buildTeamMemberRow(i),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: kcDashboardBg2,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _addTeamMember,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add member'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      canAdd ? kcobservationgreen : kcLightGrey,
                  foregroundColor: kcWhite,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberRow(int index) {
    final emp = _investigationTeam[index];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: index.isOdd ? kcDashboardBg1 : kcWhite,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '${index + 1}.',
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: kcLabelGrey),
            ),
          ),
          Expanded(
            child: _loadingEmployees
                ? const SizedBox(
                    height: 20,
                    child: Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                : (_employeesError != null && _allEmployees.isEmpty)
                    ? TextButton.icon(
                        onPressed: _loadEmployees,
                        icon: const Icon(Icons.refresh, size: 16),
                        label: const Text('Retry'),
                      )
                    : InkWell(
                        onTap: () => _pickTeamMember(index),
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: kcDarkGreyColor),
                            borderRadius: BorderRadius.circular(6),
                            color: kcWhite,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  emp == null
                                      ? 'Select employee'
                                      : '${emp.empUnqId} — ${emp.empName}'
                                          '${emp.deptCode.isEmpty ? "" : "  (${emp.deptCode})"}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: emp == null
                                        ? kcLightGrey
                                        : kcValueDark,
                                  ),
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down, size: 18),
                            ],
                          ),
                        ),
                      ),
          ),
          SizedBox(
            width: 44,
            child: IconButton(
              tooltip:
                  _investigationTeam.length > 1 ? 'Remove' : null,
              icon: Icon(
                Icons.delete_outline,
                color: _investigationTeam.length > 1
                    ? kcRed
                    : kcVeryLightGrey,
              ),
              onPressed: _investigationTeam.length > 1
                  ? () => _removeTeamMember(index)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  // ============== Root Cause Inputs ==============

  Widget _buildRootCauseInputs() {
    final canAdd = _rootCauseControllers.length < _maxRootCauses &&
        _rootCauseControllers.isNotEmpty &&
        _rootCauseControllers.last.text.trim().isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset("assets/images/uniqueid.png", scale: 20),
            const SizedBox(width: 4),
            const Text("*",
                style: TextStyle(color: Colors.red, fontSize: 18)),
            const SizedBox(width: 4),
            _buildHeadingText("Root Cause"),
            const SizedBox(width: 10),
            Text(
              '${_rootCauseControllers.length} / $_maxRootCauses',
              style: const TextStyle(
                  fontSize: 12,
                  color: kcLabelGrey,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: canAdd ? _addRootCause : null,
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add', style: TextStyle(fontSize: 12)),
              style: ElevatedButton.styleFrom(
                backgroundColor: canAdd ? kcobservationgreen : kcLightGrey,
                foregroundColor: kcWhite,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (int i = 0; i < _rootCauseControllers.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _rootCauseControllers[i],
                    onChanged: (_) => setState(() {}),
                    maxLines: 2,
                    minLines: 1,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Root cause ${i + 1}',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                ),
                if (_rootCauseControllers.length > 1)
                  IconButton(
                    tooltip: 'Remove',
                    icon: const Icon(Icons.delete_outline, color: kcRed),
                    onPressed: () => _removeRootCause(i),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  // ============== CAPA Table ==============

  Widget _buildCapaTable() {
    return Container(
      decoration: BoxDecoration(
        color: kcWhite,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _capaHeader(),
          for (int i = 0; i < _capaRows.length; i++) _capaDataRow(i),
          _capaFooter(),
        ],
      ),
    );
  }

  Widget _capaHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kcobservationgreen, kcInfoPlant],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: const [
          Expanded(flex: 3, child: _CapaHeaderCell('CAPA')),
          Expanded(flex: 2, child: _CapaHeaderCell('Resp. Emp. Code')),
          Expanded(flex: 2, child: _CapaHeaderCell('Resp. Emp. Name')),
          Expanded(flex: 2, child: _CapaHeaderCell('Resp. Department')),
          Expanded(flex: 2, child: _CapaHeaderCell('Target Date')),
          SizedBox(width: 44),
        ],
      ),
    );
  }

  Widget _capaDataRow(int index) {
    final row = _capaRows[index];
    final isLast = index == _capaRows.length - 1;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: index.isOdd ? kcDashboardBg1 : kcWhite,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: _capaTextCell(row)),
          Expanded(flex: 2, child: _capaEmployeeDropdown(row)),
          Expanded(flex: 2, child: _capaReadOnlyCell(row.employee?.empName)),
          Expanded(flex: 2, child: _capaReadOnlyCell(row.employee?.deptCode)),
          Expanded(flex: 2, child: _capaDateCell(row)),
          SizedBox(
            width: 44,
            child: IconButton(
              tooltip: _capaRows.length > 1 ? 'Remove row' : null,
              icon: Icon(
                Icons.delete_outline,
                color: _capaRows.length > 1 ? kcRed : kcVeryLightGrey,
              ),
              onPressed:
                  _capaRows.length > 1 ? () => _removeCapaRow(index) : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _capaTextCell(_CapaRow row) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        controller: row.capaController,
        maxLines: 2,
        minLines: 1,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Corrective + Preventive action',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  Widget _capaEmployeeDropdown(_CapaRow row) {
    if (_loadingEmployees) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(
          height: 20,
          child: Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
      );
    }
    if (_employeesError != null && _allEmployees.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: TextButton.icon(
          onPressed: _loadEmployees,
          icon: const Icon(Icons.refresh, size: 16),
          label: const Text('Retry', style: TextStyle(fontSize: 12)),
        ),
      );
    }
    final label = row.employee == null
        ? 'Select'
        : '${row.employee!.empUnqId} — ${row.employee!.empName}';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () => _pickEmployee(row),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: kcDarkGreyColor),
            borderRadius: BorderRadius.circular(6),
            color: kcWhite,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: row.employee == null ? kcLightGrey : kcValueDark,
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickEmployee(_CapaRow row) async {
    final picked = await showDialog<AllEmployeeModel>(
      context: context,
      builder: (ctx) => _EmployeePickerDialog(employees: _allEmployees),
    );
    if (picked != null) {
      setState(() => row.employee = picked);
    }
  }

  Widget _capaReadOnlyCell(String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        (value == null || value.isEmpty) ? '—' : value,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: kcValueDark,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _capaDateCell(_CapaRow row) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        controller: row.targetDateController,
        readOnly: true,
        onTap: () => _pickTargetDate(row),
        decoration: InputDecoration(
          isDense: true,
          hintText: 'DD/MM/YYYY',
          suffixIcon: const Icon(Icons.calendar_today, size: 16),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  Widget _capaFooter() {
    final canAdd =
        _capaRows.isNotEmpty && _isCapaRowValid(_capaRows.last) && _capaRows.length < 6;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: kcDashboardBg2,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Text(
            '${_capaRows.length} / 6 entries',
            style: const TextStyle(
                fontSize: 12, color: kcLabelGrey, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: _addCapaRow,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add row'),
            style: ElevatedButton.styleFrom(
              backgroundColor: canAdd ? kcobservationgreen : kcLightGrey,
              foregroundColor: kcWhite,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CapaHeaderCell extends StatelessWidget {
  final String text;
  const _CapaHeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: kcWhite,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CapaRow {
  final TextEditingController capaController = TextEditingController();
  final TextEditingController targetDateController = TextEditingController();
  AllEmployeeModel? employee;
  DateTime? targetDate;

  void dispose() {
    capaController.dispose();
    targetDateController.dispose();
  }
}

class _EmployeePickerDialog extends StatefulWidget {
  final List<AllEmployeeModel> employees;
  const _EmployeePickerDialog({required this.employees});

  @override
  State<_EmployeePickerDialog> createState() => _EmployeePickerDialogState();
}

class _EmployeePickerDialogState extends State<_EmployeePickerDialog> {
  late List<AllEmployeeModel> _filtered;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = widget.employees;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String q) {
    final query = q.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filtered = widget.employees;
      } else {
        _filtered = widget.employees
            .where((e) =>
                e.empUnqId.toLowerCase().contains(query) ||
                e.empName.toLowerCase().contains(query) ||
                e.deptCode.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 480,
        height: 520,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Select Employee',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Search by code, name or dept',
                  prefixIcon: const Icon(Icons.search, size: 18),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _filtered.isEmpty
                  ? const Center(child: Text('No matches'))
                  : ListView.builder(
                      itemCount: _filtered.length,
                      itemBuilder: (context, i) {
                        final e = _filtered[i];
                        return ListTile(
                          dense: true,
                          title: Text('${e.empUnqId} — ${e.empName}',
                              style: const TextStyle(fontSize: 13)),
                          subtitle: Text(
                            'Dept: ${e.deptCode.isEmpty ? "—" : e.deptCode}',
                            style: const TextStyle(fontSize: 11),
                          ),
                          onTap: () => Navigator.of(context).pop(e),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
