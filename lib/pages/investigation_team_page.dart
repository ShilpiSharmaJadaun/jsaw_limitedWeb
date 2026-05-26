import 'package:flutter/foundation.dart' show Uint8List;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/allemployee_model.dart';
import '../model/investigationReport_response_model.dart';
import '../service/employee_reporting_service.dart';
import '../service/incident_service.dart';
import '../service/observation_service.dart';
import '../utils/app_color.dart';
import 'edit_investigation_page.dart';
import 'employee_picker_dialog.dart';
import 'image_picker.dart';

class InvestigationTeamPage extends StatefulWidget {
  const InvestigationTeamPage({super.key});

  @override
  State<InvestigationTeamPage> createState() => _InvestigationTeamPageState();
}

class _InvestigationTeamPageState extends State<InvestigationTeamPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // ---------- List tab state ----------
  List<InvestigationReportResponse> _listItems = [];
  bool _loadingList = false;
  String? _listError;
  int _listPage = 1;
  int _listPageSize = 1000;
  int _listTotalPages = 0;
  int _listTotalElements = 0;
  bool _listHasNext = false;
  bool _listHasPrevious = false;
  bool _listLoadedOnce = false;

  // Client-side substring filter on already-loaded _listItems
  final TextEditingController _listSearchController = TextEditingController();
  bool _listSearchActive = false;
  List<InvestigationReportResponse> _listSearchResults = [];

  // Inline edit mode (kept inside the tab so the app shell stays visible)
  InvestigationReportResponse? _editingReport;

  String _selectedIncidentUniqueId = "Select Unique Id";

  // ---------- Unique IDs (Incident Report) ----------
  final IncidentService _incidentService = IncidentService();
  List<String> _uniqueIds = [];
  bool _loadingUniqueIds = false;
  String? _uniqueIdsError;

  // ---------- Authorized users (Investigation Team picker) ----------
  List<AllEmployeeModel> _authUsers = [];
  bool _loadingAuthUsers = false;
  String? _authUsersError;

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

  // deptCode -> deptName, for CAPA "Resp. Department" lookup
  Map<String, String> _deptCodeToName = {};

  // ---------- Root Cause inputs ----------
  static const int _maxRootCauses = 2;
  List<TextEditingController> _rootCauseControllers = [];

  // ---------- Investigation Team ----------
  static const int _maxTeamMembers = 6;
  List<AllEmployeeModel?> _investigationTeam = [];

  // ---------- Report date (today, read-only) ----------
  late final TextEditingController _reportDateController;
  late final DateTime _reportDate;

  // ---------- Associated Risk image ----------
  dynamic _associatedRiskImage;
  Uint8List? _associatedRiskBytes;

  // ---------- Submit state ----------
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      if (_tabController.index == 1 && !_listLoadedOnce) {
        _loadInvestigationList();
      }
    });
    dateController = TextEditingController();
    timeController = TextEditingController();
    detailsController = TextEditingController();
    _capaRows = [_CapaRow()];
    _rootCauseControllers = [TextEditingController()];
    _investigationTeam = [null];
    final today = DateTime.now();
    _reportDate = DateTime(today.year, today.month, today.day);
    _reportDateController = TextEditingController(
      text: "${today.day.toString().padLeft(2, '0')}/"
          "${today.month.toString().padLeft(2, '0')}/"
          "${today.year}",
    );
    _loadEmployees();
    _loadAuthUsers();
    _loadUniqueIds();
    _loadDepartments();
  }

  Future<void> _loadDepartments() async {
    try {
      final service = Provider.of<ObservationService>(context, listen: false);
      final list = await service.getAllPlant();
      if (!mounted) return;
      setState(() {
        _deptCodeToName = {
          for (final d in list)
            if (d.deptCode.isNotEmpty) d.deptCode: d.deptName,
        };
      });
    } catch (_) {
      // Non-fatal: fall back to deptCode if lookup fails
    }
  }

  Future<void> _loadInvestigationList({int? page}) async {
    setState(() {
      _loadingList = true;
      _listError = null;
    });
    try {
      final result = await _incidentService.getAllInvestigationReport(
        page: page ?? _listPage,
        pageSize: _listPageSize,
      );
      if (!mounted) return;
      setState(() {
        _listItems = result.items;
        _listPage = result.currentPage;
        _listPageSize = result.pageSize;
        _listTotalPages = result.totalPages;
        _listTotalElements = result.totalElements;
        _listHasNext = result.hasNext;
        _listHasPrevious = result.hasPrevious;
        _loadingList = false;
        _listLoadedOnce = true;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadingList = false;
        _listError = e.toString().replaceFirst('Exception: ', '');
        _listLoadedOnce = true;
      });
    }
  }

  Future<void> _loadAuthUsers() async {
    setState(() {
      _loadingAuthUsers = true;
      _authUsersError = null;
    });
    try {
      final service =
          Provider.of<EmployeeReportingService>(context, listen: false);
      final list = await service.getAllCompOutSourcAuthUser();
      if (!mounted) return;
      setState(() {
        _authUsers = list;
        _loadingAuthUsers = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadingAuthUsers = false;
        _authUsersError = e.toString();
      });
    }
  }

  Future<void> _loadUniqueIds() async {
    setState(() {
      _loadingUniqueIds = true;
      _uniqueIdsError = null;
    });
    try {
      final list = await _incidentService.getAllIncidentReportUniqueIds();
      if (!mounted) return;
      setState(() {
        _uniqueIds = list;
        _loadingUniqueIds = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadingUniqueIds = false;
        _uniqueIdsError = e.toString();
      });
    }
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
    _tabController.dispose();
    _listSearchController.dispose();
    for (final r in _capaRows) {
      r.dispose();
    }
    for (final c in _rootCauseControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _clearListSearch() {
    setState(() {
      _listSearchController.clear();
      _listSearchActive = false;
      _listSearchResults = [];
    });
  }

  void _onSearchChanged(String value) {
    final query = value.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _listSearchActive = false;
        _listSearchResults = [];
      } else {
        _listSearchActive = true;
        _listSearchResults = _listItems
            .where((r) => r.incidentUniqueId.toLowerCase().contains(query))
            .toList();
      }
    });
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
      builder: (ctx) => EmployeePickerDialog(
        employees: _authUsers,
        searchByCodeAndNameOnly: true,
      ),
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

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 3)),
    );
  }

  void _showProcessingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  'Processing… Please wait',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showSuccessDialog(String msg) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 10),
            Text('Success'),
          ],
        ),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showErrorDialog(String msg) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 28),
            SizedBox(width: 10),
            Text('Error'),
          ],
        ),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _fmtYmd(DateTime d) =>
      "${d.year.toString().padLeft(4, '0')}-"
      "${d.month.toString().padLeft(2, '0')}-"
      "${d.day.toString().padLeft(2, '0')}";

  Future<void> _submit() async {
    if (_submitting) return;

    if (_selectedIncidentUniqueId.trim().isEmpty || _selectedIncidentUniqueId == "Select Unique Id") {
      _showSnack('Please select an Incident Unique Id');
      return;
    }
    if (_associatedRiskBytes == null || _associatedRiskBytes!.isEmpty) {
      _showSnack('Please attach the Associated Risk / Hazard Register photo');
      return;
    }

    final team = _investigationTeam
        .where((e) => e != null)
        .map((e) => {
              'empUnqId': e!.empUnqId,
              'empName': e.empName,
            })
        .toList();
    if (team.isEmpty) {
      _showSnack('Please add at least one Team member');
      return;
    }

    final rootCauses = _rootCauseControllers
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    if (rootCauses.isEmpty) {
      _showSnack('Please enter at least one Root Cause');
      return;
    }

    final capa = _capaRows.where(_isCapaRowValid).map((r) {
      return {
        'capaText': r.capaController.text.trim(),
        'respEmpCode': r.employee!.empUnqId,
        'respEmpName': r.employee!.empName,
        'respDeptCode': r.employee!.deptCode,
        'targetDate': _fmtYmd(r.targetDate!),
      };
    }).toList();
    if (capa.isEmpty) {
      _showSnack('Please add at least one complete CAPA entry');
      return;
    }

    setState(() => _submitting = true);
    _showProcessingDialog();
    try {
      final msg = await _incidentService.saveInvestigationReport(
        imageBytes: _associatedRiskBytes!,
        incidentUniqueId: _selectedIncidentUniqueId.trim(),
        reportDate: _fmtYmd(_reportDate),
        team: team,
        rootCauses: rootCauses,
        capa: capa,
      );
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // close processing dialog
      await _showSuccessDialog(msg ?? 'Investigation Report saved successfully');
      if (!mounted) return;
      _resetForm();
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // close processing dialog
      await _showErrorDialog(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _resetForm() {
    setState(() {
      _selectedIncidentUniqueId = "Select Unique Id";

      for (final c in _rootCauseControllers) {
        c.dispose();
      }
      _rootCauseControllers = [TextEditingController()];

      for (final r in _capaRows) {
        r.dispose();
      }
      _capaRows = [_CapaRow()];

      _investigationTeam = [null];

      _associatedRiskImage = null;
      _associatedRiskBytes = null;
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
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: TabBar(
                controller: _tabController,
                labelColor: kcvoilet,
                unselectedLabelColor: kcLabelGrey,
                indicatorColor: kcvoilet,
                indicatorWeight: 3,
                labelStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                unselectedLabelStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                tabs: const [
                  Tab(
                    icon: Icon(Icons.assignment_outlined),
                    text: 'Submit Investigation',
                  ),
                  Tab(
                    icon: Icon(Icons.list_alt_outlined),
                    text: 'All Investigations',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFormTab(),
                  _buildListTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormTab() {
    return SingleChildScrollView(
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
    );
  }

  // ============== List Tab ==============

  Widget _buildListTab() {
    if (_editingReport != null) {
      return EditInvestigationPage(
        report: _editingReport!,
        onClose: () => setState(() => _editingReport = null),
        onSaved: () => _loadInvestigationList(page: _listPage),
      );
    }
    return Column(
      children: [
        _buildListSearchBar(),
        Expanded(
          child: _listSearchActive ? _buildSearchBody() : _buildPaginatedBody(),
        ),
        if (!_listSearchActive && _listLoadedOnce && _listItems.isNotEmpty)
          _buildListPaginationBar(),
      ],
    );
  }

  Widget _buildListSearchBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _listSearchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search by Incident Unique Id',
                prefixIcon: const Icon(Icons.search, size: 18),
                suffixIcon: _listSearchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        tooltip: 'Clear',
                        onPressed: _clearListSearch,
                      ),
                filled: true,
                fillColor: kcWhite,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kcvoilet, width: 1.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginatedBody() {
    if (_loadingList && _listItems.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_listError != null && _listItems.isEmpty) {
      return _errorView(_listError!, () => _loadInvestigationList(page: 1));
    }
    if (_listItems.isEmpty) {
      return _emptyView(
        'No Investigation Reports Yet',
        onRefresh: () => _loadInvestigationList(page: 1),
      );
    }
    return RefreshIndicator(
      onRefresh: () => _loadInvestigationList(page: _listPage),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        itemCount: _listItems.length,
        itemBuilder: (context, i) =>
            _InvestigationReportCard(
              item: _listItems[i],
              onEdit: (r) => setState(() => _editingReport = r),
            ),
      ),
    );
  }

  Widget _buildSearchBody() {
    if (_listSearchResults.isEmpty) {
      return _emptyView(
        'No Investigation Report found for "${_listSearchController.text.trim()}"',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      itemCount: _listSearchResults.length,
      itemBuilder: (context, i) =>
          _InvestigationReportCard(
            item: _listSearchResults[i],
            onEdit: (r) => setState(() => _editingReport = r),
          ),
    );
  }

  Widget _errorView(String msg, VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: kcRed, size: 36),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              msg,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kcRed, fontSize: 13),
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _emptyView(String title, {VoidCallback? onRefresh}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.inbox_outlined, color: kcLightGrey, size: 48),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: kcLabelGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
          ),
          if (onRefresh != null) ...[
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Refresh'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildListPaginationBar() {
    final fromIndex = (_listPage - 1) * _listPageSize + 1;
    final toIndex =
        ((_listPage - 1) * _listPageSize + _listItems.length).clamp(0, _listTotalElements);
    return Container(
      decoration: BoxDecoration(
        color: kcWhite,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Text(
            _listTotalElements == 0
                ? '0 of 0'
                : 'Showing $fromIndex–$toIndex of $_listTotalElements',
            style: const TextStyle(
                fontSize: 12, color: kcLabelGrey, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          if (_loadingList)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2)),
            ),
          IconButton(
            tooltip: 'Previous page',
            onPressed: (_listHasPrevious && !_loadingList)
                ? () => _loadInvestigationList(page: _listPage - 1)
                : null,
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            'Page $_listPage / ${_listTotalPages == 0 ? 1 : _listTotalPages}',
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700, color: kcValueDark),
          ),
          IconButton(
            tooltip: 'Next page',
            onPressed: (_listHasNext && !_loadingList)
                ? () => _loadInvestigationList(page: _listPage + 1)
                : null,
            icon: const Icon(Icons.chevron_right),
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
        onPressed: _submitting ? null : _submit,
        icon: _submitting
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: kcWhite),
              )
            : const Icon(Icons.check_circle_outline, color: kcWhite),
        label: Text(
          _submitting ? 'Saving…' : 'Submit Investigation Report',
          style: const TextStyle(
              color: kcWhite, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _submitting ? kcLightGrey : kcobservationgreen,
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
    final isPlaceholder = _selectedIncidentUniqueId == "Select Unique Id";
    return InkWell(
      onTap: _buildInvestigationTeamList,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: kcDarkGreyColor),
          borderRadius: BorderRadius.circular(6),
          color: kcWhite,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                _selectedIncidentUniqueId,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                      isPlaceholder ? FontWeight.w400 : FontWeight.w600,
                  color: isPlaceholder ? kcLightGrey : kcValueDark,
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 18),
          ],
        ),
      ),
    );
  }

  Future<void> _buildInvestigationTeamList() async {
    if (_loadingUniqueIds) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: SizedBox(
            height: 60,
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
      return;
    }
    if (_uniqueIdsError != null && _uniqueIds.isEmpty) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: TextButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _loadUniqueIds();
            },
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('Retry'),
          ),
        ),
      );
      return;
    }

    final picked = await showDialog<String>(
      context: context,
      builder: (ctx) => _UniqueIdPickerDialog(uniqueIds: _uniqueIds),
    );
    if (picked != null) {
      setState(() {
        _selectedIncidentUniqueId = picked;
      });
    }
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
                      _selectedIncidentUniqueId,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: _selectedIncidentUniqueId == "Select Unique Id"
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
                      _selectedIncidentUniqueId = plants[index]; // ✅ selected value shown
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
                      _selectedIncidentUniqueId,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: _selectedIncidentUniqueId == "Select Unique Id"
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
                      _selectedIncidentUniqueId = plants[index]; // ✅ selected value shown
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
                      _selectedIncidentUniqueId,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: _selectedIncidentUniqueId == "Select Unique Id"
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
                      _selectedIncidentUniqueId = plants[index]; // ✅ selected value shown
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
                const Text('(required, max 6)',
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
            child: _loadingAuthUsers
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
                : (_authUsersError != null && _authUsers.isEmpty)
                    ? TextButton.icon(
                        onPressed: _loadAuthUsers,
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
                                          '${emp.gradeCode.isEmpty ? "" : "  [${emp.gradeCode}]"}'
                                          '${emp.wrkGrp.isEmpty ? "" : "  (${emp.wrkGrp})"}',
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
            child: _removeIconButton(
              enabled: _investigationTeam.length > 1,
              tooltip: 'Remove',
              onPressed: () => _removeTeamMember(index),
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
                  _removeIconButton(
                    enabled: true,
                    tooltip: 'Remove',
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
          Expanded(flex: 2, child: _capaReadOnlyCell(_deptDisplay(row.employee?.deptCode))),
          Expanded(flex: 2, child: _capaDateCell(row)),
          SizedBox(
            width: 44,
            child: _removeIconButton(
              enabled: _capaRows.length > 1,
              tooltip: 'Remove row',
              onPressed: () => _removeCapaRow(index),
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
      builder: (ctx) => EmployeePickerDialog(employees: _allEmployees),
    );
    if (picked != null) {
      setState(() => row.employee = picked);
    }
  }

  Widget _removeIconButton({
    required bool enabled,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    const enabledRed = Color(0xFFDC2626);
    final disabledGrey = Colors.grey.shade400;
    return Container(
      decoration: BoxDecoration(
        color: enabled ? const Color(0xFFFEE2E2) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        tooltip: enabled ? tooltip : null,
        iconSize: 20,
        padding: const EdgeInsets.all(6),
        constraints: const BoxConstraints(),
        icon: Icon(
          Icons.delete_outline,
          color: enabled ? enabledRed : disabledGrey,
        ),
        onPressed: enabled ? onPressed : null,
      ),
    );
  }

  String? _deptDisplay(String? deptCode) {
    if (deptCode == null || deptCode.isEmpty) return null;
    final name = _deptCodeToName[deptCode];
    if (name == null || name.isEmpty) return deptCode;
    return name;
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

class _InvestigationReportCard extends StatefulWidget {
  final InvestigationReportResponse item;
  final ValueChanged<InvestigationReportResponse> onEdit;
  const _InvestigationReportCard({
    required this.item,
    required this.onEdit,
  });

  @override
  State<_InvestigationReportCard> createState() =>
      _InvestigationReportCardState();
}

class _InvestigationReportCardState extends State<_InvestigationReportCard> {
  bool _expanded = false;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _toggle,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: _cardHeader(item),
          ),
          InkWell(
            onTap: _toggle,
            child: _collapsedMetaRow(item),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _expanded
                ? _buildExpandedBody(item)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _cardHeader(InvestigationReportResponse item) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kcStatBlue, kcInfoResponsibility],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.policy_outlined, color: kcWhite, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item.incidentUniqueId,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: kcWhite, fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '#${item.id == 0 ? '—' : item.id}',
              style: const TextStyle(
                  color: kcWhite,
                  fontSize: 11,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 6),
          AnimatedRotation(
            turns: _expanded ? 0.5 : 0.0,
            duration: const Duration(milliseconds: 220),
            child: const Icon(Icons.expand_more, color: kcWhite, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _collapsedMetaRow(InvestigationReportResponse item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Wrap(
        spacing: 14,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _miniIcon(Icons.event_outlined, kcStatAmber, 'Report Date',
              item.reportDate.isEmpty ? '—' : item.reportDate),
          _miniIcon(Icons.access_time, kcStatBlue, 'Raised',
              item.raisedDate.isEmpty ? '—' : item.raisedDate),
          _countChip(
              Icons.groups_outlined, kcvoilet, 'Team', item.team.length),
          _countChip(Icons.search_outlined, kcobservationgreen, 'Root Causes',
              item.rootCauses.length),
          _countChip(Icons.fact_check_outlined, kcmegenta, 'CAPA',
              item.capa.length),
        ],
      ),
    );
  }

  Widget _miniIcon(IconData icon, Color color, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        Text(
          '$label: ',
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: kcLabelGrey),
        ),
        Text(
          value,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: kcValueDark),
        ),
      ],
    );
  }

  Widget _countChip(IconData icon, Color color, String label, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 4),
          Text(
            '$label: ',
            style: TextStyle(
                fontSize: 12, color: color, fontWeight: FontWeight.w600),
          ),
          Text(
            '$count',
            style: TextStyle(
                fontSize: 12, color: color, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedBody(InvestigationReportResponse item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 1,
          margin: const EdgeInsets.symmetric(horizontal: 14),
          color: Colors.grey.shade200,
        ),
        if (item.updatedDate.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
            child: _row(Icons.edit_calendar_outlined, kcLabelGrey, 'Updated',
                item.updatedDate),
          ),
        if (item.highQualityImageUrl.isNotEmpty ||
            item.associatedRiskImageUrl.isNotEmpty)
          _imageSection(
            highUrl: item.highQualityImageUrl.isNotEmpty
                ? item.highQualityImageUrl
                : item.associatedRiskImageUrl,
            lowUrl: item.lowQualityImageUrl,
          ),
        _sectionBand(
          color: kcvoilet,
          icon: Icons.groups_outlined,
          title: 'Investigation Team',
          count: item.team.length,
        ),
        if (item.team.isEmpty)
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text('—',
                style: TextStyle(color: kcLabelGrey, fontSize: 12)),
          )
        else
          ...item.team.asMap().entries.map((e) => _kvRow(
                '${e.value.seq == 0 ? (e.key + 1) : e.value.seq}.',
                '${e.value.empUnqId} — ${e.value.empName}',
              )),
        _sectionBand(
          color: kcobservationgreen,
          icon: Icons.search_outlined,
          title: 'Root Causes',
          count: item.rootCauses.length,
        ),
        if (item.rootCauses.isEmpty)
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text('—',
                style: TextStyle(color: kcLabelGrey, fontSize: 12)),
          )
        else
          ...item.rootCauses.asMap().entries.map((e) => _kvRow(
                '${e.value.seq == 0 ? (e.key + 1) : e.value.seq}.',
                e.value.rootCauseText,
              )),
        _sectionBand(
          color: kcmegenta,
          icon: Icons.fact_check_outlined,
          title: 'CAPA',
          count: item.capa.length,
        ),
        if (item.capa.isEmpty)
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 14),
            child: Text('—',
                style: TextStyle(color: kcLabelGrey, fontSize: 12)),
          )
        else
          ...item.capa.map(_capaRowView).toList(),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () => widget.onEdit(item),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: const Text('Edit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcvoilet,
                  foregroundColor: kcWhite,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _row(IconData icon, Color color, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 14),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 100,
          child: Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: kcLabelGrey)),
        ),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: kcValueDark),
          ),
        ),
      ],
    );
  }

  Widget _imageSection({required String highUrl, String? lowUrl}) {
    final hasLow = (lowUrl ?? '').isNotEmpty;
    Widget errorBox() => Container(
          color: kcVeryLightGrey,
          alignment: Alignment.center,
          child: const Text('Image unavailable',
              style: TextStyle(color: kcLabelGrey, fontSize: 12)),
        );

    final Widget image = hasLow
        ? FadeInImage(
            placeholder: NetworkImage(lowUrl!),
            image: NetworkImage(highUrl),
            fadeInDuration: const Duration(milliseconds: 300),
            fadeOutDuration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
            imageErrorBuilder: (_, __, ___) => errorBox(),
            placeholderErrorBuilder: (_, __, ___) => const SizedBox.shrink(),
          )
        : Image.network(
            highUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
            loadingBuilder: (ctx, child, progress) {
              if (progress == null) return child;
              return const SizedBox.shrink();
            },
            errorBuilder: (_, __, ___) => errorBox(),
          );

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
      child: GestureDetector(
        onTap: () => _openFullImage(highUrl: highUrl, lowUrl: lowUrl),
        child: Container(
          decoration: BoxDecoration(
            color: kcDashboardBg1,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          padding: const EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              width: double.infinity,
              height: 260,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Always-visible loading indicator beneath the image;
                  // the image (when it arrives) paints on top and hides it.
                  Container(
                    color: kcVeryLightGrey,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                  image,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openFullImage({required String highUrl, String? lowUrl}) {
    final hasLow = (lowUrl ?? '').isNotEmpty;
    final Widget image = hasLow
        ? FadeInImage(
            placeholder: NetworkImage(lowUrl!),
            image: NetworkImage(highUrl),
            fadeInDuration: const Duration(milliseconds: 300),
            fadeOutDuration: const Duration(milliseconds: 300),
            fit: BoxFit.contain,
            imageErrorBuilder: (_, __, ___) => const Padding(
              padding: EdgeInsets.all(40),
              child: Text('Image unavailable',
                  style: TextStyle(color: Colors.white)),
            ),
            placeholderErrorBuilder: (_, __, ___) => const Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(),
            ),
          )
        : Image.network(
            highUrl,
            fit: BoxFit.contain,
            loadingBuilder: (ctx, child, progress) {
              if (progress == null) return child;
              return const Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (_, __, ___) => const Padding(
              padding: EdgeInsets.all(40),
              child: Text('Image unavailable',
                  style: TextStyle(color: Colors.white)),
            ),
          );

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            InteractiveViewer(
              minScale: 0.5,
              maxScale: 4,
              child: Center(child: image),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.black54,
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionBand({
    required Color color,
    required IconData icon,
    required String title,
    required int count,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 6, 12, 0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, color: kcWhite, size: 16),
          const SizedBox(width: 6),
          Text(title,
              style: const TextStyle(
                  color: kcWhite, fontSize: 13, fontWeight: FontWeight.w700)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('$count',
                style: const TextStyle(
                    color: kcWhite,
                    fontSize: 11,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _kvRow(String seq, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 16, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 26,
            child: Text(seq,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: kcLabelGrey)),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: kcValueDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _capaRowView(InvestigationCapaItem c) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kcDashboardBg1,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: kcmegenta.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('#${c.seq == 0 ? '?' : c.seq}',
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: kcmegenta)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  c.capaText,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: kcValueDark),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              _capaChip('Emp Code', c.respEmpCode.isEmpty ? '—' : c.respEmpCode),
              _capaChip('Emp Name', c.respEmpName.isEmpty ? '—' : c.respEmpName),
              _capaChip('Dept', c.respDeptCode.isEmpty ? '—' : c.respDeptCode),
              _capaChip('Target', c.targetDate.isEmpty ? '—' : c.targetDate),
            ],
          ),
        ],
      ),
    );
  }

  Widget _capaChip(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label: ',
            style: const TextStyle(
                fontSize: 11,
                color: kcLabelGrey,
                fontWeight: FontWeight.w600)),
        Text(value,
            style: const TextStyle(
                fontSize: 12,
                color: kcValueDark,
                fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _UniqueIdPickerDialog extends StatefulWidget {
  final List<String> uniqueIds;
  const _UniqueIdPickerDialog({required this.uniqueIds});

  @override
  State<_UniqueIdPickerDialog> createState() => _UniqueIdPickerDialogState();
}

class _UniqueIdPickerDialogState extends State<_UniqueIdPickerDialog> {
  late List<String> _filtered;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = widget.uniqueIds;
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
        _filtered = widget.uniqueIds;
      } else {
        _filtered = widget.uniqueIds
            .where((id) => id.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 380,
        height: 460,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Select Unique Id',
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
                  hintText: 'Search unique id',
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
                        final id = _filtered[i];
                        return ListTile(
                          dense: true,
                          title: Text(id,
                              style: const TextStyle(fontSize: 13)),
                          onTap: () => Navigator.of(context).pop(id),
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
