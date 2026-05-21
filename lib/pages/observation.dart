import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/all_filter_observation_bloc.dart';
import 'package:jsaw_limited/bloc/allobservationTillDate_bloc.dart';
import 'package:jsaw_limited/bloc/allobservation_bloc.dart';
import 'package:jsaw_limited/bloc/filterObservation_bloc.dart';
import 'package:jsaw_limited/bloc/generateexcel_bloc.dart';
import 'package:jsaw_limited/bloc/raisedObservationBloc.dart';
import 'package:jsaw_limited/bloc/uniqueId_bloc.dart';
import 'package:jsaw_limited/model/all_filter_observation_model.dart';
import 'package:jsaw_limited/model/filterObservation_model.dart';
import 'package:jsaw_limited/pages/edit_received_observation.dart';
import 'package:jsaw_limited/pages/raisedObservation.dart';
import 'package:jsaw_limited/pages/receivedObservation.dart';
import 'package:jsaw_limited/service/observation_service.dart';
import 'package:jsaw_limited/state/all_filter_observation_state.dart';
import 'package:jsaw_limited/state/filterObservation_state.dart';
import 'package:jsaw_limited/state/generateExcel_state.dart';
import 'package:jsaw_limited/state/uniqueId_state.dart';
import 'package:jsaw_limited/utils/app_color.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/allDepart_bloc.dart';
import '../bloc/allhazard_cat_bloc.dart';
import '../bloc/allplant_bloc.dart';
import '../bloc/alltype_hazard_bloc.dart';
import '../bloc/employeeResponsibility_bloc.dart';
import '../bloc/location_bloc.dart';
import '../bloc/observationby_uni_bloc.dart';
import '../bloc/priority_bloc.dart';
import '../bloc/responsibleHod_bloc.dart';
import '../bloc/save_observation_bloc.dart';
import '../model/allDepartment_model.dart';
import '../model/allhazard_cat_model.dart';
import '../model/allplant_model.dart';
import '../model/alltype_hazard_model.dart';
import '../model/allwork_group_model.dart';
import '../model/employeeResponsibility_model.dart';
import '../model/location_model.dart';
import '../model/priority_model.dart';
import '../model/uniqueId_model.dart';
import '../service/dashboard_service.dart';
import '../state/allDepart_state.dart';
import '../state/allhazard_cat_state.dart';
import '../state/allplant_state.dart';
import '../state/employeeResponsibility_state.dart';
import '../state/location_state.dart';
import '../state/priority_state.dart';
import '../state/responsibleHOD_state.dart';
import 'edit_all_observation_page.dart';
import 'package:web/web.dart' show window;
import 'package:web/web.dart' as html;
import 'hseEditObservation_Page.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Generic SearchableValueNotifier — replaces 9 near-identical classes
// ─────────────────────────────────────────────────────────────────────────────
class SearchableValueNotifier<T> extends ValueNotifier<List<T>> {
  SearchableValueNotifier(super.value, {required this.filter}) {
    _initial = value;
  }

  final bool Function(T item, String query) filter;
  late final List<T> _initial;

  void search(String query) {
    value = query.isEmpty
        ? _initial
        : _initial.where((e) => filter(e, query)).toList();
    notifyListeners();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ObservationPage (tab host) — unchanged logic, just TabBar polish
// ─────────────────────────────────────────────────────────────────────────────
class ObservationPage extends StatefulWidget {
  const ObservationPage({super.key});

  @override
  State<ObservationPage> createState() => _ObservationPageState();
}

class _ObservationPageState extends State<ObservationPage>
    with SingleTickerProviderStateMixin {
  late final FilterObservationBloc filterObservationBloc;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    final observationService =
    Provider.of<ObservationService>(context, listen: false);
    filterObservationBloc = FilterObservationBloc(observationService);
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  isScrollable: false,
                  controller: tabController,
                  indicatorColor: kcvoilet,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  labelColor: kcvoilet,
                  unselectedLabelColor: kcLightGrey,
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      letterSpacing: 0.2),
                  unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      letterSpacing: 0.2),
                  dividerColor: kcVeryLightGrey,
                  tabs: [
                    _tab(Icons.inbox_outlined, 'Received Observation'),
                    _tab(Icons.add_alert_outlined, 'Raised Observation'),
                    _tab(Icons.list_alt_outlined, 'All Observation'),
                    if (html.window.localStorage.getItem('khseCode') == '1')
                      _tab(Icons.edit_note, 'Edit Observation'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ReceivedObservationPage(),
                      RaisedObservationPage(),
                      const AllObservationPage(),
                      if (html.window.localStorage.getItem('khseCode') == '1')
                        HseEditObservationPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Tab _tab(IconData icon, String label) => Tab(
    icon: Icon(icon),
    child: Text(label,
        textAlign: TextAlign.center,
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// AllObservationPage
// ─────────────────────────────────────────────────────────────────────────────
class AllObservationPage extends StatefulWidget {
  const AllObservationPage({super.key});

  @override
  State<AllObservationPage> createState() => _AllObservationPageState();
}

class _AllObservationPageState extends State<AllObservationPage> {
  late final AllObservaionTillDateBloc allObservaionTillDateBloc;
  late final ObservationbyUniBloc observationbyUniBloc;
  late final AllPlantBloc allPlantBloc;
  late final AllDepartBloc allDepartBloc;
  late final EmployeeResponsibilityBloc employeeResponsibilityBloc;
  late final PriorityBloc priorityBloc;
  late final LocationBloc locationBloc;
  late final AllHazardCatBloc allHazardCatBloc;
  late final SaveObservationBloc saveObservationBloc;
  late final AllTypeHazardBloc allTypeHazardBloc;
  late final ResponsibleHODBloc responsibleHODBloc;
  late final FilterObservationBloc filterObservationBloc;
  late final AllFilterObservationBloc allFilterObservationBloc;
  late final GenerateExcelBloc generateExcelBloc;
  late final UniqueIdBloc uniqueIdBloc;

  // ── Filter state ──────────────────────────────────────────────────────────
  ValueNotifier<String> workGroup = ValueNotifier('');
  ValueNotifier<String> plant = ValueNotifier('');
  ValueNotifier<String> stat = ValueNotifier('');
  ValueNotifier<String> responsibility = ValueNotifier('');
  ValueNotifier<String> responsibleHOD = ValueNotifier('');
  ValueNotifier<String> priority = ValueNotifier('');
  ValueNotifier<String> priorityDesc = ValueNotifier('Deadline');
  ValueNotifier<String> location = ValueNotifier('');
  ValueNotifier<String> uniqueId = ValueNotifier('');
  ValueNotifier<String> hazard = ValueNotifier('');
  ValueNotifier<String> hazardType = ValueNotifier('');
  final TextEditingController startDateInput = TextEditingController();
  final TextEditingController endDateInput = TextEditingController();
  final TextEditingController fromDateInput = TextEditingController();

  late String employeeName;
  late String employeeCode;
  late String allObservationSessionID =
      window.localStorage.getItem('kAllSessionID') ?? '';
  late String statCode = '';
  late String departCode = '';
  late String responsibleCode = '';
  late String responsibleHODCode = '';
  late String priorityColor = '';
  late String status = '';
  late String responsibleEnggDesignationCode = '';

  final List<String> statusList = ['PENDING', 'CLOSED', 'IN PROGRESS', 'COMPLIANCE'];
  int currentPage = 0;

  // ── Pagination ────────────────────────────────────────────────────────────
  void _nextPage() => setState(() {
    currentPage++;
    allFilterObservationBloc.initState(currentPage, '', '', '', '', '', '',
        '', '', '', allObservationSessionID, '');
  });

  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
        allFilterObservationBloc.initState(currentPage, '', '', '', '', '', '',
            '', '', '', allObservationSessionID, '');
      });
    }
  }

  // ── Lifecycle ─────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    final observationService =
    Provider.of<ObservationService>(context, listen: false);
    final dashboardService =
    Provider.of<DashboardService>(context, listen: false);
    generateExcelBloc = GenerateExcelBloc(observationService);
    allObservaionTillDateBloc = AllObservaionTillDateBloc(observationService);
    filterObservationBloc = FilterObservationBloc(observationService);
    allFilterObservationBloc = AllFilterObservationBloc(observationService);
    allFilterObservationBloc.initState(currentPage, '', '', '', '', '', '', '', '', '', '', '');
    allPlantBloc = AllPlantBloc(observationService)..initState();
    allDepartBloc = AllDepartBloc(observationService);
    employeeResponsibilityBloc = EmployeeResponsibilityBloc(observationService);
    employeeName = window.localStorage.getItem('kEmployeename') ?? '';
    employeeCode = window.localStorage.getItem('kEmployeeCode') ?? '';
    priorityBloc = PriorityBloc(observationService)..initState();
    locationBloc = LocationBloc(observationService);
    allHazardCatBloc = AllHazardCatBloc(dashboardService)..initState();
    allTypeHazardBloc = AllTypeHazardBloc(observationService)..initState();
    uniqueIdBloc = UniqueIdBloc(observationService);
    saveObservationBloc = SaveObservationBloc(observationService);
    responsibleHODBloc = ResponsibleHODBloc(observationService);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Build
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: _buildObservation()),
    );
  }

  Widget _buildObservation() {
    return BlocConsumer<AllFilterObservationBloc, AllFilterObservationState>(
      bloc: allFilterObservationBloc,
      listener: (_, __) {},
      builder: (_, state) => state.when(
        loading: (_) => Center(
            child: Lottie.asset('assets/lottie/loading.json',
                height: 80, width: 80)),
        content: _buildContent,
        success: _buildContent,
        failed: (form, __) => _buildContent(form),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Toolbar
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildToolbar(String sessionID) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: kcWhite,
        border: Border(bottom: BorderSide(color: kcVeryLightGrey, width: 1)),
      ),
      child: Row(
        children: [
          // Refresh
          _toolbarIconButton(
            icon: Icons.refresh_rounded,
            tooltip: 'Refresh',
            color: kcgreen,
            onPressed: () {
              setState(() => currentPage = 0);
              allFilterObservationBloc.initState(
                  0, '', '', '', '', '', '', '', '', '', '', '');
            },
          ),
          const SizedBox(width: 10),
          // Filter
          ElevatedButton.icon(
            onPressed: () {
              uniqueIdBloc.initState();
              _openFilterDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kcvoilet,
              foregroundColor: kcWhite,
              fixedSize: const Size(140, 38),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            icon: const Icon(Icons.filter_alt_outlined, size: 16),
            label: const Text('Filter',
                style:
                TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ),
          const SizedBox(width: 10),
          // Export
          _buildDownloadExcel(sessionID),
        ],
      ),
    );
  }

  Widget _toolbarIconButton({
    required IconData icon,
    required String tooltip,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Pagination bar
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildPaginationBar(AllFilterObservationModel model) {
    final hasPrev = currentPage > 0;                          // ✅ fixed: was currentPage < totalPages
    final hasNext = currentPage < model.totalPages - 1;       // ✅ fixed

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Prev
          _pageButton(
            icon: Icons.chevron_left_rounded,
            label: 'Prev',
            enabled: hasPrev,
            onPressed: _previousPage,
          ),
          const SizedBox(width: 16),
          // Page indicator
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: kcvoilet.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: kcvoilet.withValues(alpha: 0.15), width: 1),
            ),
            child: Text(
              'Page ${currentPage + 1} of ${model.totalPages}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: kcvoilet,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Next
          _pageButton(
            icon: Icons.chevron_right_rounded,
            label: 'Next',
            enabled: hasNext,
            onPressed: _nextPage,
            iconAfter: true,
          ),
        ],
      ),
    );
  }

  Widget _pageButton({
    required IconData icon,
    required String label,
    required bool enabled,
    required VoidCallback onPressed,
    bool iconAfter = false,
  }) {
    return AnimatedOpacity(
      opacity: enabled ? 1.0 : 0.35,
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: kcvoilet,
          foregroundColor: kcWhite,
          disabledBackgroundColor: kcLightGrey,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: iconAfter
              ? [
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(width: 4),
            Icon(icon, size: 18),
          ]
              : [
            Icon(icon, size: 18),
            const SizedBox(width: 4),
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Main content
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildContent(AllFilterObservationModel model) {
    return Column(
      children: [
        _buildToolbar(model.sessionID),
        _buildPaginationBar(model),
        const Divider(height: 1),
        ListView.builder(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: model.model.length,
          itemBuilder: (context, index) =>
              _ObservationCard(item: model.model[index]),
        ),
        _buildPaginationBar(model), // bottom pagination
        const SizedBox(height: 16),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Filter Dialog — polished, grouped
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> _openFilterDialog() async {
    final empCode = window.localStorage.getItem('kEmployeeCode') ?? '';
    await showDialog(
      context: context,
      builder: (dialogContext) => _FilterDialog(
        startDateInput: startDateInput,
        endDateInput: endDateInput,
        fromDateInput: fromDateInput,
        plantWidget: _buildPlant(),
        departWidget: _buildDepartment(),
        statusWidget: _buildStatusContent(statusList),
        locationWidget: _buildLocation(),
        hazardWidget: _buildHazard(),
        uniqueIdWidget: _buildUniqueId(),
        onClear: () {
          _clearFormValues();
          Navigator.pop(dialogContext);
        },
        onApply: () {
          allFilterObservationBloc.initState(
            0,
            statCode,
            fromDateInput.text,
            endDateInput.text,
            location.value,
            departCode,
            priority.value,
            hazard.value,
            '',
            '',
            '',
            uniqueId.value,
          );
          setState(() => currentPage = 0);
          html.window.localStorage.removeItem('kAllSessionID');
          startDateInput.clear();
          endDateInput.clear();
          _clearFormValues();
          Navigator.of(dialogContext).pop();
        },
      ),
    );
  }

  void _clearFormValues() {
    workGroup.value = '';
    plant.value = '';
    stat.value = '';
    responsibility.value = '';
    responsibleHOD.value = '';
    priority.value = '';
    priorityDesc.value = '';
    location.value = '';
    hazard.value = '';
    hazardType.value = '';
    startDateInput.clear();
    endDateInput.clear();
    fromDateInput.clear();
    statCode = '';
    departCode = '';
    responsibleCode = '';
    responsibleHODCode = '';
    priorityColor = '';
    status = '';
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Date range field
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildDateRangeContainer(
      String hintText, TextEditingController controller) {
    return SizedBox(
      height: 44,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 14, color: kcValueDark),
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          hintText: hintText,
          hintStyle: const TextStyle(color: kcLightGrey, fontSize: 14),
          fillColor: kcWhite,
          filled: true,
          prefixIcon: const Icon(Icons.calendar_month_outlined,
              size: 18, color: kcLightGrey),
          enabledBorder: _inputBorder(),
          focusedBorder: _focusedInputBorder(),
        ),
        readOnly: true,
        onTap: () async {
          final picked = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            builder: (ctx, child) => Theme(
              data: Theme.of(ctx).copyWith(
                colorScheme: Theme.of(ctx)
                    .colorScheme
                    .copyWith(primary: kcvoilet, onPrimary: kcWhite),
              ),
              child: child!,
            ),
            initialDateRange: startDateInput.text.isNotEmpty &&
                endDateInput.text.isNotEmpty
                ? DateTimeRange(
                start: DateTime.parse(startDateInput.text),
                end: DateTime.parse(endDateInput.text))
                : DateTimeRange(
                start:
                DateTime.now().subtract(const Duration(days: 7)),
                end: DateTime.now()),
          );
          if (picked != null) {
            final fmt = DateFormat('yyyy-MM-dd');
            setState(() {
              startDateInput.text = fmt.format(picked.start);
              fromDateInput.text = fmt.format(picked.start);
              endDateInput.text = fmt.format(picked.end);
            });
          }
        },
      ),
    );
  }

  OutlineInputBorder _inputBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: kcVeryLightGrey));

  OutlineInputBorder _focusedInputBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.5, color: kcvoilet));

  // ─────────────────────────────────────────────────────────────────────────
  // Reusable: dropdown trigger chip
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildDropdownChip({
    required ValueNotifier<String> notifier,
    required String placeholder,
    required VoidCallback onTap,
    double width = double.infinity,
  }) {
    return ValueListenableBuilder<String>(
      valueListenable: notifier,
      builder: (_, value, __) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: width,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: kcWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kcVeryLightGrey, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value.isEmpty ? placeholder : value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: value.isEmpty ? kcLightGrey : kcValueDark,
                  ),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 20, color: kcLightGrey),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Reusable: searchable picker dialog
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> _showPickerDialog<T>({
    required BuildContext ctx,
    required String title,
    required List<T> items,
    required String Function(T) label,
    required void Function(T) onSelect,
    required bool Function(T, String) filter,
    String? subtitle,
  }) {
    final notifier =
    SearchableValueNotifier<T>(items, filter: filter);
    return showDialog(
      context: ctx,
      builder: (context) => Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: 340,
          height: 520,
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
                decoration: BoxDecoration(
                  color: kcvoilet,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: kcWhite, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(title,
                          style: const TextStyle(
                              color: kcWhite,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: kcWhite, size: 18),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              // Search field
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                child: TextField(
                  onChanged: notifier.search,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search…',
                    hintStyle:
                    const TextStyle(color: kcLightGrey, fontSize: 14),
                    prefixIcon: const Icon(Icons.search,
                        color: kcLightGrey, size: 18),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    filled: true,
                    fillColor: kcVeryLightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              // List
              Expanded(
                child: ValueListenableBuilder<List<T>>(
                  valueListenable: notifier,
                  builder: (_, list, __) => list.isEmpty
                      ? const Center(
                      child: Text('No results',
                          style: TextStyle(color: kcLightGrey)))
                      : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    itemCount: list.length,
                    separatorBuilder: (_, __) =>
                    const Divider(height: 1),
                    itemBuilder: (_, i) => ListTile(
                      dense: true,
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      title: Text(label(list[i]),
                          style: const TextStyle(
                              fontSize: 14, color: kcValueDark)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      hoverColor:
                      kcvoilet.withValues(alpha: 0.06),
                      onTap: () {
                        onSelect(list[i]);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Status filter
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildStatusContent(List<String> list) => _buildDropdownChip(
    notifier: priority,
    placeholder: 'Filter Status',
    onTap: () => _showPickerDialog<String>(
      ctx: context,
      title: 'Select Status',
      items: list,
      label: (s) => s,
      filter: (s, q) =>
          s.toLowerCase().contains(q.toLowerCase()),
      onSelect: (s) => priority.value = s,
    ),
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Plant
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildPlant() => BlocConsumer<AllPlantBloc, AllPlantState>(
    bloc: allPlantBloc,
    listener: (_, __) {},
    builder: (_, state) => state.when(
      loading: (_) => const _LoadingChip(),
      content: _plantChip,
      success: _plantChip,
      failed: (m, __) => _plantChip(m),
    ),
  );

  Widget _plantChip(List<AllPlantModel> model) => _buildDropdownChip(
    notifier: plant,
    placeholder: 'Filter Plant',
    onTap: () => _showPickerDialog<AllPlantModel>(
      ctx: context,
      title: 'Select Plant',
      items: model,
      label: (m) => m.deptName,
      filter: (m, q) =>
          m.deptName.toLowerCase().contains(q.toLowerCase()),
      onSelect: (m) {
        plant.value = m.deptName;
        departCode = m.deptCode;
        allDepartBloc.initState(departCode);
        locationBloc.initState(departCode);
      },
    ),
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Department
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildDepartment() =>
      BlocConsumer<AllDepartBloc, AllDepartState>(
        bloc: allDepartBloc,
        listener: (_, __) {},
        builder: (_, state) => state.when(
          loading: (_) => const _LoadingChip(),
          content: _deptChip,
          success: _deptChip,
          failed: (m, __) => _deptChip(m),
        ),
      );

  Widget _deptChip(List<AllDepartmentModel> model) =>
      _buildDropdownChip(
        notifier: stat,
        placeholder: 'Filter Department',
        onTap: () {
          if (departCode.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please select a plant first')));
            return;
          }
          _showPickerDialog<AllDepartmentModel>(
            ctx: context,
            title: 'Select Department',
            items: model,
            label: (m) => m.statName,
            filter: (m, q) =>
                m.statName.toLowerCase().contains(q.toLowerCase()),
            onSelect: (m) {
              stat.value = m.statName;
              statCode = m.statCode;
              employeeResponsibilityBloc.initState(
                  departCode,
                  statCode,
                  window.localStorage.getItem('kDesgnCode')!);
            },
          );
        },
      );

  // ─────────────────────────────────────────────────────────────────────────
  // Location
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildLocation() =>
      BlocConsumer<LocationBloc, LocationState>(
        bloc: locationBloc,
        listener: (_, __) {},
        builder: (_, state) => state.when(
          loading: (_) => const _LoadingChip(),
          content: _locationChip,
          success: _locationChip,
          failed: (m, __) => _locationChip(m),
        ),
      );

  Widget _locationChip(List<LocationModel> model) =>
      _buildDropdownChip(
        notifier: location,
        placeholder: 'Filter Location',
        onTap: () => _showPickerDialog<LocationModel>(
          ctx: context,
          title: 'Select Location',
          items: model,
          label: (m) => m.locations,
          filter: (m, q) =>
              m.locations.toLowerCase().contains(q.toLowerCase()),
          onSelect: (m) => location.value = m.locations,
        ),
      );

  // ─────────────────────────────────────────────────────────────────────────
  // Hazard
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildHazard() =>
      BlocConsumer<AllHazardCatBloc, AllHazardCatState>(
        bloc: allHazardCatBloc,
        listener: (_, __) {},
        builder: (_, state) => state.when(
          loading: (_) => const _LoadingChip(),
          content: _hazardChip,
          success: _hazardChip,
          failed: (m, __) => _hazardChip(m),
        ),
      );

  Widget _hazardChip(List<AllHazardCatModel> model) =>
      _buildDropdownChip(
        notifier: hazard,
        placeholder: 'Filter Hazard Category',
        onTap: () => _showPickerDialog<AllHazardCatModel>(
          ctx: context,
          title: 'Select Hazard Category',
          items: model,
          label: (m) => m.hazardCategoryName,
          filter: (m, q) => m.hazardCategoryName
              .toLowerCase()
              .contains(q.toLowerCase()),
          onSelect: (m) => hazard.value = m.hazardCategoryName,
        ),
      );

  // ─────────────────────────────────────────────────────────────────────────
  // Unique ID
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildUniqueId() =>
      BlocConsumer<UniqueIdBloc, UniqueIdState>(
        bloc: uniqueIdBloc,
        listener: (_, __) {},
        builder: (_, state) => state.when(
          loading: (_) => const _LoadingChip(),
          content: _uniqueIdChip,
          success: _uniqueIdChip,
          failed: (m, __) => _uniqueIdChip(m),
        ),
      );

  Widget _uniqueIdChip(List<UniqueIdModel> model) =>
      _buildDropdownChip(
        notifier: uniqueId,
        placeholder: 'Filter Unique ID',
        onTap: () {
          uniqueIdBloc.initState();
          _showPickerDialog<UniqueIdModel>(
            ctx: context,
            title: 'Select Observation ID',
            items: model,
            label: (m) => m.uniqueIdentificationNumber,
            filter: (m, q) => m.uniqueIdentificationNumber
                .toLowerCase()
                .contains(q.toLowerCase()),
            onSelect: (m) =>
            uniqueId.value = m.uniqueIdentificationNumber,
          );
        },
      );

  // ─────────────────────────────────────────────────────────────────────────
  // Excel download
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildDownloadExcel(String sessionID) {
    return BlocConsumer<GenerateExcelBloc, GenerateExcelState>(
      bloc: generateExcelBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, url) => launchUrl(Uri.parse(url!)),
          failed: (_, msg) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg))),
          orElse: () {},
        );
      },
      builder: (_, state) => state.maybeWhen(
        loading: (_) =>
        const SizedBox(width: 38, height: 38, child: CircularProgressIndicator(strokeWidth: 2)),
        orElse: () => ElevatedButton.icon(
          onPressed: () => generateExcelBloc.initState(sessionID),
          style: ElevatedButton.styleFrom(
            backgroundColor: kcWhite,
            foregroundColor: kcobservationgreen,
            elevation: 0,
            side: const BorderSide(color: kcobservationgreen, width: 1.2),
            fixedSize: const Size(160, 38),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
          icon: Image.asset('assets/images/excelicon.png',
              width: 16, height: 16),
          label: const Text('Export Excel',
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) hexString = 'FF$hexString';
    return Color(int.parse(hexString, radix: 16));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Filter Dialog — extracted widget for cleanliness
// ─────────────────────────────────────────────────────────────────────────────
class _FilterDialog extends StatelessWidget {
  final TextEditingController startDateInput;
  final TextEditingController endDateInput;
  final TextEditingController fromDateInput;
  final Widget plantWidget;
  final Widget departWidget;
  final Widget statusWidget;
  final Widget locationWidget;
  final Widget hazardWidget;
  final Widget uniqueIdWidget;
  final VoidCallback onClear;
  final VoidCallback onApply;

  const _FilterDialog({
    required this.startDateInput,
    required this.endDateInput,
    required this.fromDateInput,
    required this.plantWidget,
    required this.departWidget,
    required this.statusWidget,
    required this.locationWidget,
    required this.hazardWidget,
    required this.uniqueIdWidget,
    required this.onClear,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding:
      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: SizedBox(
        width: 380,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ────────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
              decoration: const BoxDecoration(
                color: kcvoilet,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.filter_alt_outlined,
                      color: kcWhite, size: 20),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Filter Observations',
                      style: TextStyle(
                          color: kcWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    icon:
                    const Icon(Icons.close, color: kcWhite, size: 20),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            // ── Body ──────────────────────────────────────────────────────
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _filterSection('Date Range', [
                      _buildDateField(
                          context, 'Start Date', startDateInput),
                      const SizedBox(height: 8),
                      _buildDateField(
                          context, 'End Date', endDateInput),
                    ]),
                    _filterSection('Location', [plantWidget, const SizedBox(height: 8), departWidget, const SizedBox(height: 8), locationWidget]),
                    _filterSection('Classification', [statusWidget, const SizedBox(height: 8), hazardWidget]),
                    _filterSection('Observation ID', [uniqueIdWidget]),
                  ],
                ),
              ),
            ),
            // ── Actions ───────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: kcVeryLightGrey, width: 1)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onClear,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kcLightGrey,
                        side:
                        const BorderSide(color: kcVeryLightGrey),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding:
                        const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.clear_all_rounded,
                          size: 16),
                      label: const Text('Clear',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: onApply,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kcvoilet,
                        foregroundColor: kcWhite,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding:
                        const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.check_rounded, size: 16),
                      label: const Text('Apply Filters',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterSection(String label, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: kcLightGrey,
                  letterSpacing: 0.8)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDateField(BuildContext context,
      String hint, TextEditingController controller) {
    return SizedBox(
      height: 44,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 14, color: kcValueDark),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
          const TextStyle(color: kcLightGrey, fontSize: 14),
          prefixIcon: const Icon(Icons.calendar_month_outlined,
              size: 18, color: kcLightGrey),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          filled: true,
          fillColor: kcWhite,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(width: 1, color: kcVeryLightGrey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(width: 1.5, color: kcvoilet)),
        ),
        readOnly: true,
        onTap: () async {
          final picked = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            builder: (ctx, child) => Theme(
              data: Theme.of(ctx).copyWith(
                colorScheme: Theme.of(ctx)
                    .colorScheme
                    .copyWith(primary: kcvoilet, onPrimary: kcWhite),
              ),
              child: child!,
            ),
            initialDateRange: startDateInput.text.isNotEmpty &&
                    endDateInput.text.isNotEmpty
                ? DateTimeRange(
                    start: DateTime.parse(startDateInput.text),
                    end: DateTime.parse(endDateInput.text))
                : DateTimeRange(
                    start:
                        DateTime.now().subtract(const Duration(days: 7)),
                    end: DateTime.now()),
          );
          if (picked != null) {
            final fmt = DateFormat('yyyy-MM-dd');
            startDateInput.text = fmt.format(picked.start);
            fromDateInput.text = fmt.format(picked.start);
            endDateInput.text = fmt.format(picked.end);
          }
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Observation Card — extracted widget
// ─────────────────────────────────────────────────────────────────────────────
class _ObservationCard extends StatelessWidget {
  final dynamic item; // replace with your actual model type

  const _ObservationCard({required this.item});

  Color _statusColor(String status) {
    switch (status.trim().toUpperCase()) {
      case 'CLOSED':
        return kcStatGreen;
      case 'PENDING':
        return kcStatRed;
      case 'IN PROGRESS':
        return kcStatPurple;
      case 'COMPLIANCE':
        return kcStatAmber;
      default:
        return kcLightGrey;
    }
  }

  Color hexToColor(String h) {
    h = h.replaceFirst('#', '');
    if (h.length == 6) h = 'FF$h';
    return Color(int.parse(h, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kcVeryLightGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----- Image -----
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 220,
                height: 200,
                child: FadeInImage(
                  placeholder: NetworkImage(item.lowQualityImageUrl),
                  image: NetworkImage(item.imageNumber),
                  fadeInDuration: const Duration(milliseconds: 300),
                  fadeOutDuration: const Duration(milliseconds: 300),
                  fit: BoxFit.cover,
                  imageErrorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade100,
                    alignment: Alignment.center,
                    child: Icon(Icons.broken_image_outlined,
                        color: Colors.grey.shade400, size: 48),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // ----- Content -----
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top: 3 columns of grouped info, each with accent-bar value box
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              icon: Icons.person_outline_rounded,
                              iconColor: kcStatBlue,
                              label: "Raised By",
                              value: item.observationRaisedBy,
                              valueColor: kcValueDark,
                            ),
                            _buildInfoSection(
                              icon: Icons.factory_outlined,
                              iconColor: kcStatGreen,
                              label: "Plant / Dept",
                              value: item.plantDept,
                              valueColor: kcValueDark,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              icon: Icons.qr_code_2_outlined,
                              iconColor: kcvoilet,
                              label: "Unique ID",
                              value: item.uniqueIdentificationNumber,
                              valueColor: kcValueDark,
                            ),
                            _buildInfoSection(
                              icon: Icons.location_on_outlined,
                              iconColor: kcStatRed,
                              label: "Location",
                              value: item.location,
                              valueColor: kcValueDark,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoSection(
                              icon: Icons.assignment_ind_outlined,
                              iconColor: kcStatPurple,
                              label: "Responsibility",
                              value: item.responsibility,
                              valueColor: kcmegenta,
                            ),
                            _buildInfoSection(
                              icon: Icons.workspace_premium_outlined,
                              iconColor: _statusColor(item.status),
                              label: "Status",
                              value: item.status,
                              valueColor: _statusColor(item.status),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Soft gradient divider
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.grey.shade300,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Date pill row: Raised + Target
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(
                                Icons.event_note_outlined, kcStatAmber),
                            const SizedBox(width: 8),
                            _buildLabel("Raised Date :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                  item.raisedDate, kcStatAmber),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.event_outlined, kcvoilet),
                            const SizedBox(width: 8),
                            _buildLabel("Target Date :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                  item.observationCompletionTargetDate,
                                  kcvoilet),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Compliance + Priority
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(
                                Icons.event_available_outlined, kcStatGreen),
                            const SizedBox(width: 8),
                            _buildLabel("Compliance Date :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                item.complianceDate.trim().isEmpty
                                    ? '—'
                                    : item.complianceDate,
                                item.complianceDate.trim().isEmpty
                                    ? kcLightGrey
                                    : kcStatGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            _buildIconBadge(Icons.flag_outlined,
                                hexToColor(item.priorityStatusColour)),
                            const SizedBox(width: 8),
                            _buildLabel("Priority :"),
                            const SizedBox(width: 6),
                            Flexible(
                              child: _buildPillBadge(
                                item.priorityStatusName,
                                hexToColor(item.priorityStatusColour),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Observation paragraph
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconBadge(
                          Icons.visibility_outlined, kcObservationCyan),
                      const SizedBox(width: 8),
                      _buildLabel("Observation :"),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            item.observationText.isEmpty
                                ? '—'
                                : item.observationText,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: kcValueDark,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Corrective measure + edit arrow
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconBadge(Icons.build_outlined, kcStatPurple),
                      const SizedBox(width: 8),
                      _buildLabel("Corrective Measure :"),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            item.correctiveMeasure.isEmpty
                                ? '—'
                                : item.correctiveMeasure,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: kcValueDark,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'View / Edit',
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => EditAllObservationPage(
                              uniqueId: item.uniqueIdentificationNumber,
                              raisedBy: item.observationRaisedBy,
                              wrkGrp: item.wrkGrp,
                              stationName: item.stationName,
                              stateCode: item.stationCode,
                              plant: item.plantDept,
                              location: item.location,
                              resHod: item.responsibilityHODName,
                              priority: item.priorityStatusName,
                              hazard: item.hazardCategory,
                              observation: item.observationText,
                              name: item.responsibility,
                              raisedDate: item.raisedDate,
                              raisedByEmpID:
                                  item.observationRaisedByEmpUnqId,
                              status: item.status,
                              correctiveMeasure: item.correctiveMeasure,
                              image: item.imageNumber,
                              targetDate:
                                  item.observationCompletionTargetDate,
                              complianceDate: item.complianceDate,
                            ),
                            fullscreenDialog: true,
                          ));
                        },
                        icon: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: kcvoilet,
                            size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Info group: tinted icon badge + label, then a colored-accent value box.
  Widget _buildInfoSection({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4, top: 4),
          child: Row(
            children: [
              _buildIconBadge(icon, iconColor),
              const SizedBox(width: 6),
              Flexible(child: _buildLabel("$label :")),
            ],
          ),
        ),
        _buildAccentTextBox(value, valueColor, accentColor: iconColor),
      ],
    );
  }

  /// Colored icon badge — colored icon on a tinted square background.
  Widget _buildIconBadge(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color, size: 16),
    );
  }

  /// Gradient pill chip for short emphasized values like dates.
  Widget _buildPillBadge(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  /// Compact label used next to icon badges.
  Widget _buildLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: kcLabelGrey,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Value card with a left-edge colored accent bar matching its icon color.
  Widget _buildAccentTextBox(String title, Color color,
      {Color? accentColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 36),
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kcVeryLightGrey, width: 1),
          boxShadow: [
            BoxShadow(
              color: (accentColor ?? Colors.black).withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (accentColor != null)
                Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  child: Text(
                    title.isEmpty ? '—' : title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small helpers
// ─────────────────────────────────────────────────────────────────────────────

class _LoadingChip extends StatelessWidget {
  const _LoadingChip();
  @override
  Widget build(BuildContext context) => Container(
    height: 44,
    decoration: BoxDecoration(
      color: kcVeryLightGrey,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Center(
      child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2)),
    ),
  );
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    padding:
    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: kcWhite,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        letterSpacing: 0.4,
      ),
    ),
  );
}