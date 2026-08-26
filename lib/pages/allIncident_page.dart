import 'dart:ui' hide window;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/allIncident_bloc.dart';
import 'package:jsaw_limited/bloc/allMedicalOfficerList_bloc.dart';
import 'package:flutter/material.dart';
import 'package:jsaw_limited/bloc/completeMedicalResponse_bloc.dart';
import 'package:jsaw_limited/model/allIncident_model.dart';
import 'package:jsaw_limited/model/allMedicalOfficerList_model.dart';
import 'package:jsaw_limited/model/completeMedicalResponse_model.dart';
import 'package:jsaw_limited/pages/medical_Officer_page.dart';
import 'package:jsaw_limited/state/allIncident_state.dart';
import 'package:jsaw_limited/state/allMedicalOfficerList_state.dart';
import 'package:jsaw_limited/state/completeMedicalResponse_state.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:js_interop';
import 'package:web/web.dart' show window;
import 'package:web/web.dart' as html;
import '../bloc/all_filter_observation_bloc.dart';
import '../service/incident_service.dart';
import 'widgets/incident_filter.dart';
import 'incident_view_page.dart';
import '../error/api_error.dart';
import '../utils/app_color.dart';
import '../utils/progressive_image.dart';

/// Which slice of incidents a tab shows (Phase-2 point 1).
enum IncidentListMode {
  /// Incidents where the logged-in user is the employee selected on the raise form.
  received,
  /// Incidents reported by the logged-in user.
  raised,
  /// Every incident (the original All Incident list).
  all,
}

// ─────────────────────────────────────────────────────────────────────────────
// AllIncidentPage — tab host: Received Incident · Raised Incident · All Incidents
// (same shape as ObservationPage so the customer gets the familiar layout).
// ─────────────────────────────────────────────────────────────────────────────
class AllIncidentPage extends StatefulWidget {
  const AllIncidentPage({super.key});

  @override
  State<AllIncidentPage> createState() => _AllIncidentPageState();
}

class _AllIncidentPageState extends State<AllIncidentPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcDashboardBg1,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: kcWhite,
            child: TabBar(
              controller: tabController,
              indicatorColor: kcvoilet,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              labelColor: kcvoilet,
              unselectedLabelColor: kcLightGrey,
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 13, letterSpacing: 0.2),
              unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 13, letterSpacing: 0.2),
              dividerColor: kcVeryLightGrey,
              tabs: [
                _tab(Icons.inbox_outlined, 'Received Incident'),
                _tab(Icons.add_alert_outlined, 'Raised Incident'),
                _tab(Icons.list_alt_outlined, 'All Incidents'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                IncidentListTab(mode: IncidentListMode.received),
                IncidentListTab(mode: IncidentListMode.raised),
                IncidentListTab(mode: IncidentListMode.all),
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
// IncidentListTab — one paginated incident list, scoped by [mode].
// ─────────────────────────────────────────────────────────────────────────────
class IncidentListTab extends StatefulWidget {
  const IncidentListTab({super.key, required this.mode});

  final IncidentListMode mode;

  @override
  State<IncidentListTab> createState() => _IncidentListTabState();
}

class _IncidentListTabState extends State<IncidentListTab>
    with AutomaticKeepAliveClientMixin {
  // Keep each tab's State (and bloc) alive inside the TabBarView so switching
  // tabs does not refetch and dialogs never reference a disposed State.
  @override
  bool get wantKeepAlive => true;

  late AllIncidentbloc allIncidentbloc;

  /// Filter pickers' option lists, fetched once per tab on first Filter tap.
  Future<IncidentFilterOptions>? _filterOptions;

  /// True while an Excel export is being generated (disables the button).
  bool _exporting = false;

  /// Incident opened with "View" (Phase-2 point 4); null = list is shown.
  /// Kept as state (not Navigator.push) so Back returns to the same tab with
  /// its filter and page intact.
  AllIncidentModel? _selected;

  String get _tabTitle {
    switch (widget.mode) {
      case IncidentListMode.received:
        return 'Received Incident';
      case IncidentListMode.raised:
        return 'Raised Incident';
      case IncidentListMode.all:
        return 'All Incidents';
    }
  }

  @override
  void initState() {
    super.initState();
    final incidentService = Provider.of<IncidentService>(context, listen: false);
    final myCode = window.localStorage.getItem('kEmployeeCode') ?? "";
    allIncidentbloc = AllIncidentbloc(
      incidentService,
      raisedByEmpCode: widget.mode == IncidentListMode.raised ? myCode : '',
      employeeCode: widget.mode == IncidentListMode.received ? myCode : '',
    );
    allIncidentbloc.load();
  }

  Future<IncidentFilterOptions> _optionsFuture() {
    final incidentService = Provider.of<IncidentService>(context, listen: false);
    return _filterOptions ??= incidentService.getIncidentFilterOptions();
  }

  Future<void> _openFilter() async {
    final result = await showIncidentFilterDialog(
      context: context,
      initial: allIncidentbloc.filter,
      options: _optionsFuture(),
      // The employee is fixed on the Received tab and the raiser on the Raised
      // tab, so those two inputs would be meaningless there.
      showEmployee: widget.mode != IncidentListMode.received,
      showRaisedBy: widget.mode != IncidentListMode.raised,
    );
    if (result == null || !mounted) return;
    await allIncidentbloc.applyFilter(result);
    if (mounted) setState(() {});
  }

  /// Phase-2 point 3: export what this tab currently shows (scope + filters,
  /// every page) and hand the .xlsx to the browser as a download.
  Future<void> _exportExcel() async {
    if (_exporting) return;
    if (allIncidentbloc.totalElements == 0) {
      _toast('Nothing to export — the list is empty.');
      return;
    }
    setState(() => _exporting = true);
    try {
      final incidentService =
          Provider.of<IncidentService>(context, listen: false);
      final filter = allIncidentbloc.filter;
      final bytes = await incidentService.exportIncidentsExcel(
        filter: filter,
        raisedByEmpCode: allIncidentbloc.raisedByEmpCode,
        employeeCode: allIncidentbloc.employeeCode,
        exportTitle: _tabTitle,
        exportFilters: [for (final c in filter.chips) '${c.key}: ${c.value}'],
      );
      final now = DateTime.now();
      String two(int v) => v.toString().padLeft(2, '0');
      final stamp =
          '${now.year}${two(now.month)}${two(now.day)}-${two(now.hour)}${two(now.minute)}';
      final fileName =
          'Incidents_${_tabTitle.replaceAll(RegExp(r'[^A-Za-z0-9]+'), '_')}_$stamp.xlsx';
      final blob = html.Blob(
        [bytes.toJS].toJS,
        html.BlobPropertyBag(
            type:
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
      );
      final url = html.URL.createObjectURL(blob);
      html.HTMLAnchorElement()
        ..href = url
        ..setAttribute('download', fileName)
        ..click();
      html.URL.revokeObjectURL(url);
      _toast('Exported ${allIncidentbloc.totalElements} record(s) to $fileName');
    } on ApiError catch (e) {
      _toast(e.message);
    } catch (e) {
      _toast('Excel export failed: $e');
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  void _toast(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _clearFilter() async {
    await allIncidentbloc.clearFilter();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    allIncidentbloc.close();
    super.dispose();
  }

  String get _emptyMessage {
    if (!allIncidentbloc.filter.isEmpty) {
      return 'No incidents match the current filters';
    }
    switch (widget.mode) {
      case IncidentListMode.received:
        return 'No incidents received by you';
      case IncidentListMode.raised:
        return 'No incidents raised by you';
      case IncidentListMode.all:
        return 'No incidents found';
    }
  }

  int currentPage = 0;
  late String raisedSessionID = window.localStorage.getItem('kRaisedSessionID') ?? "";


  @override
  Widget build(BuildContext context) {
    super.build(context);
    final selected = _selected;
    if (selected != null) {
      return IncidentViewPage(
        key: ValueKey('view-${selected.uniqueId}'),
        incident: selected,
        onBack: () => setState(() => _selected = null),
      );
    }
    return Column(
      children: [
        BlocBuilder<AllIncidentbloc, AllIncidentState>(
          bloc: allIncidentbloc,
          builder: (_, state) {
            final isLoading =
                state.maybeWhen(loading: (_) => true, orElse: () => false);
            return IncidentFilterBar(
              filter: allIncidentbloc.filter,
              onOpen: _openFilter,
              onClear: _clearFilter,
              onRefresh: allIncidentbloc.refresh,
              currentPage: allIncidentbloc.currentPage,
              totalPages: allIncidentbloc.totalPages,
              hasPrev: allIncidentbloc.hasPrevious && !isLoading,
              hasNext: allIncidentbloc.hasNext && !isLoading,
              onPrev: allIncidentbloc.previousPage,
              onNext: allIncidentbloc.nextPage,
              exporting: _exporting,
              onExport: _exportExcel,
            );
          },
        ),
        Expanded(child: _buildAllIncidentList()),
        _buildPagination(),
      ],
    );
  }

  /// Bottom pagination bar — same design as the All Observation page.
  Widget _buildPagination() {
    return BlocBuilder<AllIncidentbloc, AllIncidentState>(
      bloc: allIncidentbloc,
      builder: (_, state) {
        final isLoading =
            state.maybeWhen(loading: (_) => true, orElse: () => false);
        if (allIncidentbloc.totalElements == 0 && !isLoading) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              incidentPageButton(
                icon: Icons.chevron_left_rounded,
                label: 'Prev',
                enabled: allIncidentbloc.hasPrevious && !isLoading,
                onPressed: allIncidentbloc.previousPage,
              ),
              const SizedBox(width: 16),
              incidentPagePill(
                  allIncidentbloc.currentPage, allIncidentbloc.totalPages),
              const SizedBox(width: 16),
              incidentPageButton(
                icon: Icons.chevron_right_rounded,
                label: 'Next',
                enabled: allIncidentbloc.hasNext && !isLoading,
                onPressed: allIncidentbloc.nextPage,
                iconAfter: true,
              ),
            ],
          ),
        );
      },
    );
  }

  _buildAllIncidentList() {
    return BlocConsumer<AllIncidentbloc, AllIncidentState>(
      bloc: allIncidentbloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: (_) {
              return Center(
                child: Lottie.asset("assets/lottie/loading.json",
                    height: 80, width: 80),
              );
            },
            content: (model) =>
                model.isEmpty ? _buildEmpty(_emptyMessage) : _buildContent(model),
            success: (model) =>
                model.isEmpty ? _buildEmpty(_emptyMessage) : _buildContent(model),
            // The backend answers "No Incident Reports found for the given
            // filters" as a failure; show the tab-specific wording instead.
            failed: (_, msg) => _buildEmpty(
                msg.toLowerCase().contains('no incident') ? _emptyMessage : msg));
      },
    );
  }

  Widget _buildEmpty(String message) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kcDashboardBg1, kcDashboardBg2],
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline, size: 64, color: kcLightGrey),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: kcValueDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<AllIncidentModel> model) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kcDashboardBg1, kcDashboardBg2],
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: model.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ----- Image section -----
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 16.screenWidth,
                      height: 12.screenHeight,
                      child: ProgressiveImage(
                        highUrl: model[index].imageUrl,
                        lowUrl: model[index].lowQualityImageUrl,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // ----- Content section -----
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Header: incident ID + workflow stage (visible at
                        // first glance — customer request during point 4).
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Icon(Icons.tag, size: 16, color: kcLabelGrey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  model[index].uniqueId,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w800,
                                    color: kcValueDark,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IncidentStagePill(
                                status: model[index].status,
                                investigationStatus:
                                    model[index].investigationStatus,
                              ),
                            ],
                          ),
                        ),

                        // Top row: 3 columns of grouped info
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
                                    label: "Employee Name / Code",
                                    value:
                                    "${model[index].employeeName} (${model[index].employeeCode})",
                                    valueColor: kcValueDark,
                                  ),
                                  _buildInfoSection(
                                    icon: Icons.factory_outlined,
                                    iconColor: kcInfoPlant,
                                    label: "Plant / Dept",
                                    value: model[index].plant,
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
                                    icon: Icons.engineering_outlined,
                                    iconColor: kcInfoContractor,
                                    label: "Contractor Name",
                                    value: model[index].contractorName,
                                    valueColor: kcValueDark,
                                  ),
                                  _buildInfoSection(
                                    icon: Icons.location_on_outlined,
                                    iconColor: kcInfoLocation,
                                    label: "Location",
                                    value: model[index].location,
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
                                    icon:  Icons.warning_amber_rounded,
                                    iconColor: kcStatAmber,
                                    label: "Incident Type",
                                    value: model[index].incidentType,
                                    valueColor: kcRed,
                                  ),
                                  _buildInfoSection(
                                    icon: Icons.assignment_ind_outlined,
                                    iconColor: kcInfoResponsibility,
                                    label: "Responsibility",
                                    value: model[index].responsibleShiftEngg,
                                    valueColor: kcmegenta,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Soft gradient divider
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
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

                        // FIR Date with pill chip
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Row(
                              children: [
                                _buildIconBadge(Icons.event_note_outlined, kcInfoFir),
                                const SizedBox(width: 8),
                                _buildLabel("FIR Date :"),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: _buildPillBadge(model[index].firDateTime, kcInfoFir),
                                ),
                              ],
                            )),

                            const SizedBox(width: 8),
                            Expanded(
                              child: Row(
                                children: [
                                  _buildIconBadge(Icons.calendar_today_rounded, kcInfoDate),
                                  const SizedBox(width: 8),
                                  _buildLabel("Date :"),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: _buildPillBadge(
                                      model[index].incidentDateTime,
                                      kcStatAmber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Injury type + Incident date
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  _buildIconBadge(
                                      Icons.medical_services_outlined,
                                      kcInfoInjury),
                                  const SizedBox(width: 8),
                                  _buildLabel("Injury :"),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      model[index].workInjury,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: kcValueDark,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                        const SizedBox(height: 6),

                        // Observations
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildIconBadge(Icons.visibility_outlined,
                                kcInfoObservation),
                            const SizedBox(width: 8),
                            _buildLabel("Description :"),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  model[index].descpOfIncident,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 1.8.screenWidth,
                                    color: kcValueDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // View (Phase-2 point 4) — read-only full-chain view
                        // of this incident, opened inline.
                        Align(
                          alignment: Alignment.centerRight,
                          child: _buildViewButton(
                            () => setState(() => _selected = model[index]),
                          ),
                        ),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildIconBadge(Icons.visibility_outlined,
                                kcInfoObservation),
                            const SizedBox(width: 8),
                            _buildLabel("Medical Officer Remark :"),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  model[index].medicalOfficerRemarks,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 1.8.screenWidth,
                                    color: kcValueDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildIconBadge(Icons.visibility_outlined,
                                kcInfoObservation),
                            const SizedBox(width: 8),
                            _buildLabel("Safety Remark :"),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  model[index].safetyRemarks,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 1.8.screenWidth,
                                    color: kcValueDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // // Plant
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     _buildIconBadge(
                        //         Icons.precision_manufacturing_outlined,
                        //         kcInfoPlant),
                        //     const SizedBox(width: 8),
                        //     _buildLabel("Plant :"),
                        //     const SizedBox(width: 8),
                        //     Expanded(
                        //       child: Padding(
                        //         padding:
                        //         const EdgeInsets.symmetric(vertical: 4),
                        //         child: Text(
                        //           model[index].plant,
                        //           maxLines: 5,
                        //           overflow: TextOverflow.ellipsis,
                        //           style: const TextStyle(
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 14,
                        //             color: kcValueDark,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------- Reusable building blocks ----------

  /// Builds an info group: colored icon + label + colored-accent value card.
  Widget _buildViewButton(VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: kcStatBlue,
        foregroundColor: kcWhite,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      icon: const Icon(Icons.visibility_outlined, size: 16),
      label: const Text('View',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
    );
  }

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
          padding: EdgeInsets.symmetric(vertical: 0.15.screenHeight),
          child: Row(
            children: [
              _buildIconBadge(icon, iconColor),
              const SizedBox(width: 6),
              _buildLabel("$label :"),
            ],
          ),
        ),
        _buildTextBox(value, valueColor, accentColor: iconColor),
      ],
    );
  }

  /// Colored circular icon badge — colorful icon on a tinted square background.
  Widget _buildIconBadge(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 15),
    );
  }

  /// Pill-style chip for short emphasized values like dates.
  Widget _buildPillBadge(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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

  /// Compact label (replaces the old grey heading text).
  Widget _buildLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
        color: kcLabelGrey,
      ),
    );
  }

  /// Kept for backwards-compatibility if referenced elsewhere.
  _buildHeadingText(String title) {
    return Padding(
      padding: EdgeInsets.all(1.screenWidth),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 2.2.screenWidth,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  /// Value card with a left-edge colored accent bar matching its icon color.
  Widget _buildTextBox(String title, Color color, {Color? accentColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 1.screenWidth, vertical: 0.15.screenHeight),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 2.4.screenHeight),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: (accentColor ?? Colors.black).withOpacity(0.06),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 1.2.screenWidth,
                    vertical: 0.2.screenHeight,
                  ),
                  child: Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 1.5.screenWidth,
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

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }
}
