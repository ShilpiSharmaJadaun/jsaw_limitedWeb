import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/allhazard_cat_bloc.dart';
import 'package:jsaw_limited/bloc/alltoday_observation_bloc.dart';
import 'package:jsaw_limited/bloc/observationstatus_bloc.dart';
import 'package:jsaw_limited/bloc/top3hazard_bloc.dart';
import 'package:jsaw_limited/bloc/update_password_bloc.dart';
import 'package:jsaw_limited/model/allhazard_cat_model.dart';
import 'package:jsaw_limited/model/alltoday_observation_model.dart';
import 'package:jsaw_limited/model/observationstatus_model.dart';
import 'package:jsaw_limited/model/top3hazard_model.dart';
import 'package:jsaw_limited/pages/suggestion_page.dart';
import 'package:jsaw_limited/service/dashboard_service.dart';
import 'package:jsaw_limited/service/password_service.dart';
import 'package:jsaw_limited/state/allhazard_cat_state.dart';
import 'package:jsaw_limited/state/alltoday_observation_state.dart';
import 'package:jsaw_limited/state/observationStatus_state.dart';
import 'package:jsaw_limited/state/top3hazard_state.dart';
import 'package:jsaw_limited/state/update_password_state.dart';
import 'package:jsaw_limited/utils/app_color.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:web/web.dart' as html;

import 'package:responsive_builder/responsive_builder.dart';

class ExtraLargeDashboardPage extends StatefulWidget {
  const ExtraLargeDashboardPage({super.key});

  @override
  State<ExtraLargeDashboardPage> createState() =>
      _ExtraLargeDashboardPageState();
}

class _ExtraLargeDashboardPageState extends State<ExtraLargeDashboardPage> {
  // Below this width, layout stacks vertically
  static const double _wideBreakpoint = 1100;
  // Below this width, stat grid uses 2 columns instead of 3
  static const double _statNarrowBreakpoint = 720;

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController plantTypeInput = TextEditingController();
  final now = DateTime.now();
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  late AllTodayObservationBloc allTodayObservationBloc;
  late AllHazardCatBloc allHazardCatBloc;
  late ObservationStatusBloc observationStatusBloc;
  late Top3HazardBloc top3hazardBloc;
  late UpdatePasswordBloc updatePasswordBloc;

  ValueNotifier<String> hazardCategory =
  ValueNotifier("Select hazard Category");

  static const String _hazardPlaceholder = "Select hazard Category";

  @override
  void initState() {
    super.initState();
    final dashboardServices =
    Provider.of<DashboardService>(context, listen: false);
    final passwordService =
    Provider.of<PasswordService>(context, listen: false);
    allTodayObservationBloc = AllTodayObservationBloc(dashboardServices);
    allTodayObservationBloc.initState();
    allHazardCatBloc = AllHazardCatBloc(dashboardServices);
    allHazardCatBloc.initState();
    observationStatusBloc = ObservationStatusBloc(dashboardServices);
    observationStatusBloc.initState();
    top3hazardBloc = Top3HazardBloc(dashboardServices);
    top3hazardBloc.initState();
    updatePasswordBloc = UpdatePasswordBloc(passwordService);

    var empPassStatus =
    html.window.localStorage.getItem('kEmployeePassStatus').toString();
    if (empPassStatus == '0') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showPasswordChangeDialog(context);
      });
    }
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
        child: _buildObservation(),
      ),
    );
  }

  Widget _buildObservation() {
    return BlocConsumer<AllTodayObservationBloc, AllTodayObservationState>(
      bloc: allTodayObservationBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: (_) {
              return Center(
                  child: Lottie.asset("assets/lottie/loading.json",
                      height: 80, width: 80));
            },
            content: _buildContent,
            success: _buildContent,
            failed: (form, __) => _buildContent(form));
      },
    );
  }

  Widget _buildContent(List<AllTodayObservationModel> model) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= _wideBreakpoint;
        if (isWide) {
          // Side-by-side: observations | dashboard widgets
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildWelcomeHeader(),
                const SizedBox(height: 16),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _buildLeftColumn(model)),
                      const SizedBox(width: 16),
                      Expanded(flex: 4, child: _buildRightColumn()),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        // Stacked: dashboard on top, observations below
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildWelcomeHeader(),
              const SizedBox(height: 16),
              _buildRightColumn(),
              const SizedBox(height: 16),
              SizedBox(
                height: 600,
                child: _buildLeftColumn(model),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWelcomeHeader() {
    final dateStr = DateFormat('EEEE, MMM d, y').format(DateTime.now());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [navyBlue, kcStatBlue],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: navyBlue.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.dashboard_rounded, color: kcWhite, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Safety Dashboard",
                  style: TextStyle(
                    color: kcWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateStr,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- LEFT COLUMN: Today's Observations ----------------

  Widget _buildLeftColumn(List<AllTodayObservationModel> model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterBar(),
        const SizedBox(height: 12),
        Expanded(
          child: model.isEmpty
              ? _buildEmptyState()
              : ListView.separated(
            itemCount: model.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                _buildObservationCard(model[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined,
              size: 56, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            "No observations to show",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.filter_list_rounded,
              color: kcHazardViolet, size: 20),
          const SizedBox(width: 8),
          Expanded(child: _buildHazardBody()),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: () {
              hazardCategory.value = _hazardPlaceholder;
              allTodayObservationBloc.initState();
            },
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text("Refresh"),
            style: TextButton.styleFrom(
              foregroundColor: kcStatBlue,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObservationCard(AllTodayObservationModel item) {
    final priorityColor = hexToColor(item.priorityStatusColour);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Header: image + name + ID + priority pill ----
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 100,
                    height: 80,
                    child: Image.network(
                      item.imageNumber,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade100,
                        alignment: Alignment.center,
                        child: Icon(Icons.broken_image_outlined,
                            color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage(
                                "assets/images/jindal-saw-logo.png"),
                            radius: 14,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.observationRaisedBy,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: kcValueDark,
                                  ),
                                ),
                                Text(
                                  item.uniqueIdentificationNumber,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: kcLabelGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildPriorityPill(
                              item.priorityStatusName, priorityColor),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Hazard category line
                      Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded,
                              color: kcOrange, size: 16),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "Hazard: ${item.hazardCategory}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: kcOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ---- Observation text ----
            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: kcObservationCyan.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border(
                  left: BorderSide(color: kcObservationCyan, width: 3),
                ),
              ),
              child: Text(
                item.observationText,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: kcValueDark,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // ---- Footer: Assignee | Status | Date ----
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildFooterInfo(
                  Icons.person_outline_rounded,
                  Colors.indigo,
                  "Assignee",
                  item.responsibility,
                ),
                _buildFooterInfo(
                  Icons.flag_outlined,
                  Colors.teal,
                  "Status",
                  item.status,
                ),
                _buildFooterInfo(
                  Icons.calendar_today_rounded,
                  Colors.deepOrange,
                  "Date",
                  item.raisedDate,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityPill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildFooterInfo(
      IconData icon, Color color, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                  fontSize: 10,
                  color: kcLabelGrey,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: kcValueDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------- Hazard category dropdown ----------------

  Widget _buildHazardBody() {
    return BlocConsumer<AllHazardCatBloc, AllHazardCatState>(
      bloc: allHazardCatBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: (_) => const SizedBox(
              height: 36,
              child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            content: _buildHazardContent,
            success: _buildHazardContent,
            failed: (form, __) => _buildHazardContent(form));
      },
    );
  }

  Widget _buildHazardContent(List<AllHazardCatModel> model) {
    return ValueListenableBuilder<String>(
      valueListenable: hazardCategory,
      builder: (context, value, child) {
        final isPlaceholder = value == _hazardPlaceholder;
        return InkWell(
          onTap: () => _buildhazardListDialog(model),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isPlaceholder ? Colors.grey : kcValueDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down_rounded,
                    color: Colors.grey.shade600),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _buildhazardListDialog(List<AllHazardCatModel> model) {
    final listNotifier = SearchableListNotifier(model);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select Hazard Category",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                onChanged: listNotifier.filterBasedOn,
                decoration: const InputDecoration(
                  hintText: "search here...",
                  prefixIcon: Icon(Icons.search, color: kcLightGrey),
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 300,
            height: 300,
            child: ValueListenableBuilder<List<AllHazardCatModel>>(
              valueListenable: listNotifier,
              builder: (context, list, _) => ListView.separated(
                itemCount: list.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.grey.shade200),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      hazardCategory.value = list[index].hazardCategoryName;
                      allTodayObservationBloc.initState(hazardCategory.value);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: Text(list[index].hazardCategoryName),
                    ),
                  );
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("close",
                  style: TextStyle(color: kcDarkGreyColor)),
            ),
          ],
        );
      },
    );
  }

  // ---------------- RIGHT COLUMN: stats + top + info ----------------

  Widget _buildRightColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGridBody(),
        const SizedBox(height: 16),
        _buildTopCategoriesCard(),
        const SizedBox(height: 16),
        _buildInfoCard(),
      ],
    );
  }

  Widget _buildTopCategoriesCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: kcHazardViolet.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.local_fire_department_outlined,
                    color: kcHazardViolet,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Top Categories",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: kcValueDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildTop3HazardBody(),
          ],
        ),
      ),
    );
  }

  // ---------------- Stats grid ----------------

  Widget _buildGridBody() {
    return BlocConsumer<ObservationStatusBloc, ObservationStatusState>(
      bloc: observationStatusBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
          loading: (_) => SizedBox(
              height: 200,
              child: Center(
                  child: Lottie.asset("assets/lottie/loading.json",
                      height: 60, width: 60))),
          content: _buildGridViewContent,
          success: _buildGridViewContent,
          failed: (form, error) => _buildErrorState(error),
        );
      },
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Text('Error: $error',
          style: const TextStyle(color: Colors.red, fontSize: 13)),
    );
  }

  Widget _buildGridViewContent(ObservationStatusModel m) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < _statNarrowBreakpoint;
        return GridView.count(
          crossAxisCount: isNarrow ? 2 : 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            _buildStatCard("All Observations", "${m.alls}",
                Icons.assignment_outlined, kcStatBlue),
            _buildStatCard("Pending", "${m.pending}",
                Icons.pending_actions_outlined, kcStatRed),
            _buildStatCard("Closed", "${m.closed}",
                Icons.check_circle_outline_rounded, kcStatGreen),
            _buildStatCard("In Progress", "${m.inProgress}",
                Icons.trending_up_rounded, kcStatPurple),
            _buildStatCard("Compliance", "${m.compliance}",
                Icons.verified_outlined, kcStatAmber),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: kcLabelGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- Top 3 hazard ----------------

  Widget _buildTop3HazardBody() {
    return BlocConsumer<Top3HazardBloc, Top3HazardState>(
      bloc: top3hazardBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
          loading: (_) => const SizedBox(
              height: 60,
              child:
              Center(child: CircularProgressIndicator(strokeWidth: 2))),
          content: _buildtop3HazardContent,
          success: _buildtop3HazardContent,
          failed: (form, error) => _buildErrorState(error),
        );
      },
    );
  }

  Widget _buildtop3HazardContent(List<Top3HazardModel> top3) {
    if (top3.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Text("No data",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
      );
    }
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: top3
          .map((e) =>
          _buildTopCategoryChip(e.hazardCategory, e.count.toString()))
          .toList(),
    );
  }

  Widget _buildTopCategoryChip(String title, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: kcHazardViolet.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: kcValueDark,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                kcHazardViolet,
                kcHazardViolet.withOpacity(0.8),
              ]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Info / suggestion card ----------------

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hello 👋",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: kcValueDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Facing any difficulty using the Safety Portal app, or have suggestions? Write to us.",
                    style: TextStyle(
                      fontSize: 13,
                      color: kcLabelGrey,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [navyBlue, cream, golden]),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: navyBlue.withOpacity(0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                              const SuggestionFeedbackPage(),
                              fullscreenDialog: true),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      icon: const Icon(Icons.edit_note_rounded,
                          color: kcWhite, size: 18),
                      label: const Text(
                        "Write Us",
                        style: TextStyle(
                          color: kcWhite,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Image.asset("assets/images/adhyamLogo.png", height: 60),
          ],
        ),
      ),
    );
  }

  // ---------------- Helpers ----------------

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }

  // ---------------- Password change dialog (unchanged logic) ----------------

  Future<void> _showPasswordChangeDialog(BuildContext context) async {
    final TextEditingController newPasswordController =
    TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            content: BlocConsumer<UpdatePasswordBloc, UpdatePasswordState>(
              bloc: updatePasswordBloc,
              listener: (_, state) {
                state.maybeWhen(
                    success: (_, message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message ?? "Something")));
                      Navigator.pop(context);
                    },
                    failed: (_, message) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(message)));
                    },
                    orElse: () {});
              },
              builder: (context, state) {
                return state.maybeWhen(
                    loading: (_) =>
                    const Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(),
                    ),
                    orElse: () {
                      return SizedBox(
                        width: 500,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [navyBlue, cream, golden]),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Icon(Icons.lock_outline_rounded,
                                        color: kcWhite),
                                    SizedBox(width: 8),
                                    Text(
                                      "Change Password",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kcWhite,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextFormField(
                                controller: newPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Enter New Password",
                                  prefixIcon: const Icon(
                                      Icons.password_rounded,
                                      color: kcStatBlue),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16, 0, 16, 16),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    String newPassword =
                                        newPasswordController.text;
                                    if (newPassword.isNotEmpty) {
                                      _updatepassword(
                                          html.window.localStorage
                                              .getItem('kEmployeeCode')
                                              .toString(),
                                          html.window.localStorage
                                              .getItem('kEmployeePassStatus')
                                              .toString(),
                                          newPasswordController.text);
                                      Navigator.pop(context);
                                      Navigator.pushReplacementNamed(
                                          context, '/login');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Password cannot be empty")));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kcStatBlue,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "Save Password",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ),
        );
      },
    );
  }

  void _updatepassword(
      String empUnqId, String empPassStatus, String empNewPass) async {
    final data = {
      'empUnqId': empUnqId,
      'empPassStatus': "1",
      'empNewPass': empNewPass
    };
    await updatePasswordBloc.forgetPassword(data);
  }
}

class SearchableListNotifier extends ValueNotifier<List<AllHazardCatModel>> {
  SearchableListNotifier(super.value) {
    initialValue = value;
  }

  late List<AllHazardCatModel> initialValue;

  void filterBasedOn(String query) {
    if (query.isEmpty) {
      value = initialValue;
    } else {
      value = initialValue
          .where((e) => e.hazardCategoryName
          .toLowerCase()
          .startsWith(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}