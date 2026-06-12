import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/allhazard_cat_bloc.dart';
import 'package:jsaw_limited/bloc/alltoday_observation_bloc.dart';
import 'package:jsaw_limited/bloc/observationstatus_bloc.dart';
import 'package:jsaw_limited/bloc/top3hazard_bloc.dart';
import 'package:jsaw_limited/bloc/update_password_bloc.dart';
import 'package:jsaw_limited/utils/progressive_image.dart';
import 'package:jsaw_limited/model/allhazard_cat_model.dart';
import 'package:jsaw_limited/model/alltoday_observation_model.dart';
import 'package:jsaw_limited/model/observationstatus_model.dart';
import 'package:jsaw_limited/model/top3hazard_model.dart';
import 'package:jsaw_limited/pages/common_navigation_page.dart';
import 'package:jsaw_limited/pages/suggestion_page.dart';
import 'package:jsaw_limited/routes/app_routes.dart';
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

class LargeDashboardPage extends StatefulWidget {
  const LargeDashboardPage({super.key});

  @override
  State<LargeDashboardPage> createState() => _LargeDashboardPageState();
}

class _LargeDashboardPageState extends State<LargeDashboardPage> {
  late AllTodayObservationBloc allTodayObservationBloc;
  late AllHazardCatBloc allHazardCatBloc;
  late ObservationStatusBloc observationStatusBloc;
  late Top3HazardBloc top3hazardBloc;
  late UpdatePasswordBloc updatePasswordBloc;

  final ValueNotifier<String> hazardCategory =
      ValueNotifier("All hazards");

  // Per-stat accent palette
  static const _blue = Color(0xFF3B82F6);
  static const _amber = Color(0xFFF59E0B);
  static const _green = Color(0xFF10B981);
  static const _fuchsia = Color(0xFFD946EF);
  static const _orange = Color(0xFFFF7B2C);
  static const _purple = Color(0xFF8B5CF6);

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

    final empPassStatus =
        html.window.localStorage.getItem('kEmployeePassStatus').toString();
    if (empPassStatus == '0') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showPasswordChangeDialog(context);
      });
    }
  }

  @override
  void dispose() {
    hazardCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kcDashboardBg1, kcDashboardBg2],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: LayoutBuilder(
          builder: (ctx, c) {
            final wide = c.maxWidth > 1100;
            if (wide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 7, child: _todayObservationsCard()),
                  const SizedBox(width: 18),
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _statsRow(),
                          const SizedBox(height: 16),
                          _sideColumn(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            // Narrow: stats on top, then side column, then observations fills rest.
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _statsRow(),
                const SizedBox(height: 14),
                _sideColumn(),
                const SizedBox(height: 14),
                Expanded(child: _todayObservationsCard()),
              ],
            );
          },
        ),
      ),
    );
  }


  // ============ Stats row ============
  Widget _statsRow() {
    return BlocBuilder<ObservationStatusBloc, ObservationStatusState>(
      bloc: observationStatusBloc,
      builder: (_, state) {
        return state.when(
          loading: (_) => SizedBox(
            height: 110,
            child: Center(
              child: Lottie.asset('assets/lottie/loading.json',
                  height: 70, width: 70),
            ),
          ),
          content: _buildStatsGrid,
          success: _buildStatsGrid,
          failed: (_, e) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kcWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                Text('Could not load stats: $e', style: const TextStyle(color: kcRed)),
          ),
        );
      },
    );
  }

  Widget _buildStatsGrid(ObservationStatusModel m) {
    final cards = <_StatTile>[
      _StatTile('All Observations', Icons.list_alt_outlined,
          '${m.alls}', _blue),
      _StatTile('Pending', Icons.hourglass_top_outlined,
          '${m.pending}', _amber),
      _StatTile('Closed', Icons.check_circle_outline,
          '${m.closed}', _green),
      _StatTile('In Progress', Icons.timelapse_outlined,
          '${m.inProgress}', _purple),
      _StatTile('Compliance', Icons.verified_outlined,
          '${m.compliance}', _orange),
    ];
    return LayoutBuilder(
      builder: (ctx, c) {
        final cross = c.maxWidth >= 1100
            ? 5
            : c.maxWidth >= 800
                ? 4
                : c.maxWidth >= 540
                    ? 3
                    : 2;
        final spacing = 12.0;
        final tileWidth =
            (c.maxWidth - spacing * (cross - 1)) / cross;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: cards
              .map((t) => SizedBox(
                    width: tileWidth,
                    child: _statCard(t),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _statCard(_StatTile t) {
    // Soft pastel tint of the status color, blended over white so it stays light.
    final tintBg = Color.alphaBlend(t.color.withOpacity(0.12), kcWhite);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tintBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: t.color.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: t.color.withOpacity(0.10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: t.color.withOpacity(0.16),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(t.icon, color: t.color, size: 16),
          ),
          const SizedBox(height: 6),
          Text(
            t.value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: t.color,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            t.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: kcLabelGrey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ============ Today observations card ============
  Widget _todayObservationsCard() {
    return _sectionCard(
      title: "Today's Observations",
      icon: Icons.today_outlined,
      accent: _blue,
      fillBody: true,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _hazardChip(),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {
              allTodayObservationBloc.initState();
              observationStatusBloc.initState();
              top3hazardBloc.initState();
              allHazardCatBloc.initState();
            },
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text(
              'Refresh',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _blue,
              foregroundColor: kcWhite,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
      child: BlocBuilder<AllTodayObservationBloc, AllTodayObservationState>(
        bloc: allTodayObservationBloc,
        builder: (_, state) => state.when(
          loading: (_) => Center(
            child: Lottie.asset('assets/lottie/loading.json',
                height: 70, width: 70),
          ),
          content: _renderObservationList,
          success: _renderObservationList,
          failed: (form, e) => _renderObservationList(form),
        ),
      ),
    );
  }

  Widget _renderObservationList(List<AllTodayObservationModel> model) {
    if (model.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.inbox_outlined, size: 48, color: kcLabelGrey),
            SizedBox(height: 6),
            Text('No observations for today',
                style: TextStyle(
                    color: kcLabelGrey, fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }
    return ListView.separated(
      itemCount: model.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) => _observationCard(model[i]),
    );
  }

  Widget _observationCard(AllTodayObservationModel item) {
    final priorityColor = _hexToColor(item.priorityStatusColour);
    return Container(
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: LayoutBuilder(
          builder: (ctx, c) {
            final wide = c.maxWidth > 500;
            final image = ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: wide ? 160 : double.infinity,
                height: 140,
                child: ProgressiveImage(
                  highUrl: item.imageNumber,
                  lowUrl: item.lowQualityImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
            final body = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.observationRaisedBy.isEmpty
                            ? '—'
                            : item.observationRaisedBy,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: kcValueDark),
                      ),
                    ),
                    _pillChip(item.priorityStatusName, priorityColor),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '#${item.uniqueIdentificationNumber}',
                  style: const TextStyle(
                      fontSize: 11,
                      color: kcLabelGrey,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                _miniChip(
                    Icons.category_outlined, _purple, item.hazardCategory),
                const SizedBox(height: 6),
                Text(
                  item.observationText,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: kcValueDark,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _miniChip(Icons.person_outline, _blue,
                        item.responsibility.isEmpty
                            ? '—'
                            : item.responsibility),
                    _miniChip(Icons.label_important_outline, _green,
                        item.status.isEmpty ? '—' : item.status),
                    _miniChip(Icons.event_outlined, _orange,
                        item.raisedDate.isEmpty ? '—' : item.raisedDate),
                  ],
                ),
              ],
            );
            if (wide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image,
                  const SizedBox(width: 12),
                  Expanded(child: body),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                image,
                const SizedBox(height: 10),
                body,
              ],
            );
          },
        ),
      ),
    );
  }

  // ============ Side column ============
  Widget _sideColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _topCategoriesCard(),
        // Write Us card hidden from dashboard.
        // const SizedBox(height: 16),
        // _writeUsCard(),
      ],
    );
  }

  Widget _topCategoriesCard() {
    return _sectionCard(
      title: 'Top Categories',
      icon: Icons.local_fire_department_outlined,
      accent: _orange,
      child: BlocBuilder<Top3HazardBloc, Top3HazardState>(
        bloc: top3hazardBloc,
        builder: (_, state) => state.when(
          loading: (_) => SizedBox(
            height: 80,
            child: Center(
                child: Lottie.asset('assets/lottie/loading.json',
                    height: 60, width: 60)),
          ),
          content: _renderTopCategories,
          success: _renderTopCategories,
          failed: (form, _) => _renderTopCategories(form),
        ),
      ),
    );
  }

  Widget _renderTopCategories(List<Top3HazardModel> list) {
    if (list.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text('No data yet',
            style: TextStyle(color: kcLabelGrey, fontSize: 12)),
      );
    }
    final palette = [_fuchsia, _amber, _purple, _green, _blue, _orange];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(list.length, (i) {
        final color = palette[i % palette.length];
        return _categoryPill(list[i].hazardCategory,
            list[i].count.toString(), color);
      }),
    );
  }

  Widget _categoryPill(String label, String count, Color color) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 6, 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(count,
                style: const TextStyle(
                    color: kcWhite,
                    fontSize: 11,
                    fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _writeUsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF7B2C), Color(0xFFEF4A8B), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF4A8B).withOpacity(0.22),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.22),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.forum_outlined,
                    color: kcWhite, size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Got feedback or a bug?',
                  style: TextStyle(
                      color: kcWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Facing any difficulty while using the Safety Portal? '
            'Tell us — we read everything.',
            style: TextStyle(
                color: kcWhite, fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                final show = CommonNavigationPage.showPage;
                if (show != null) {
                  show('Write Us', const SuggestionFeedbackPage());
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SuggestionFeedbackPage(),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.edit_note_rounded,
                  color: Color(0xFFEF4A8B), size: 18),
              label: const Text(
                'Write Us',
                style: TextStyle(
                  color: Color(0xFFEF4A8B),
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  letterSpacing: 0.3,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kcWhite,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============ Hazard filter ============
  Widget _hazardChip() {
    return BlocBuilder<AllHazardCatBloc, AllHazardCatState>(
      bloc: allHazardCatBloc,
      builder: (_, state) {
        final list = state.when(
          loading: (_) => const <AllHazardCatModel>[],
          content: (m) => m,
          success: (m) => m,
          failed: (m, _) => m,
        );
        return ValueListenableBuilder<String>(
          valueListenable: hazardCategory,
          builder: (_, value, __) {
            final isAll = value == 'All hazards';
            return InkWell(
              onTap: () => _buildhazardListDialog(list),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _blue.withOpacity(isAll ? 0.08 : 0.16),
                  border: Border.all(
                      color: _blue.withOpacity(isAll ? 0.25 : 0.45)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.filter_alt_outlined,
                        size: 14, color: _blue),
                    const SizedBox(width: 6),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 110),
                      child: Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: _blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down,
                        size: 18, color: _blue),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _buildhazardListDialog(List<AllHazardCatModel> model) {
    final listNotifier = SearchableListNotifier(model);
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: 380,
          height: 480,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 8, 6),
                child: Row(
                  children: [
                    const Icon(Icons.filter_alt_outlined,
                        color: _blue, size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text('Filter by hazard',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: kcValueDark)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  onChanged: listNotifier.filterBasedOn,
                  autofocus: true,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Search…',
                    prefixIcon: const Icon(Icons.search, size: 18),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: () {
                  hazardCategory.value = 'All hazards';
                  allTodayObservationBloc.initState();
                  Navigator.pop(ctx);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 12),
                  child: Row(
                    children: const [
                      Icon(Icons.clear_all, color: _blue, size: 16),
                      SizedBox(width: 8),
                      Text('All hazards',
                          style: TextStyle(
                              color: _blue,
                              fontWeight: FontWeight.w800,
                              fontSize: 13)),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ValueListenableBuilder<List<AllHazardCatModel>>(
                  valueListenable: listNotifier,
                  builder: (_, list, __) => ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => Divider(
                        height: 1, color: Colors.grey.shade200),
                    itemBuilder: (_, i) => InkWell(
                      onTap: () {
                        hazardCategory.value = list[i].hazardCategoryName;
                        allTodayObservationBloc
                            .initState(hazardCategory.value);
                        Navigator.pop(ctx);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        child: Text(list[i].hazardCategoryName,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600)),
                      ),
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

  // ============ Shared widgets ============
  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Color accent,
    Widget? trailing,
    bool fillBody = false,
    required Widget child,
  }) {
    final body = Padding(
      padding: const EdgeInsets.all(14),
      child: child,
    );
    return Container(
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: fillBody ? MainAxisSize.max : MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accent.withOpacity(0.10), Colors.transparent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, color: accent, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: kcValueDark),
                    ),
                  ],
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
          if (fillBody) Expanded(child: body) else body,
        ],
      ),
    );
  }

  Widget _pillChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label.isEmpty ? '—' : label,
        style: const TextStyle(
            color: kcWhite,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3),
      ),
    );
  }

  Widget _miniChip(IconData icon, Color color, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 160),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Color _hexToColor(String hexString) {
    if (hexString.isEmpty) return _blue;
    var s = hexString.replaceFirst('#', '');
    if (s.length == 6) s = 'FF$s';
    try {
      return Color(int.parse(s, radix: 16));
    } catch (_) {
      return _blue;
    }
  }

  // ============ Password change dialog (preserved) ============
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
            content: BlocConsumer<UpdatePasswordBloc, UpdatePasswordState>(
              bloc: updatePasswordBloc,
              listener: (_, state) {
                state.maybeWhen(
                  success: (_, message) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(message ?? "Something")));
                    Navigator.pop(context);
                  },
                  failed: (_, message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)));
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loading: (_) => const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  orElse: () {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 500,
                        height: 200,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xFFFF7B2C),
                                    Color(0xFFEF4A8B),
                                    Color(0xFF8B5CF6),
                                  ]),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Text(
                                    "Change Password",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: kcWhite),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: newPasswordController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter New Password",
                                    border: OutlineInputBorder(),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  String newPassword =
                                      newPasswordController.text;
                                  if (newPassword.isNotEmpty) {
                                    _updatepassword(
                                        html.window.localStorage
                                                .getItem('kEmployeeCode')
                                                .toString(),
                                        html.window.localStorage
                                                .getItem(
                                                    'kEmployeePassStatus')
                                                .toString(),
                                        newPasswordController.text);
                                    Navigator.pop(context);
                                    Navigator.pushReplacementNamed(
                                        context, AppRoutes.loginPage);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Password cannot be empty")));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFF8B5CF6)),
                                child: const Text(
                                  "Save Password",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
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
      'empNewPass': empNewPass,
    };
    await updatePasswordBloc.forgetPassword(data);
  }
}

class _StatTile {
  final String label;
  final IconData icon;
  final String value;
  final Color color;
  const _StatTile(this.label, this.icon, this.value, this.color);
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
          .where((e) =>
              e.hazardCategoryName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
