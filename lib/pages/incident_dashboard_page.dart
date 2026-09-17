import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/incident_dashboard_model.dart';
import '../service/incident_service.dart';
import '../utils/app_color.dart';
import '../utils/compact_date_range_picker.dart';

/// Incident Dashboard (customer request Sep-2026): five tabs — Number of
/// Injuries, Plant-wise, Department-wise, Category-wise (Nature of Injury)
/// and Type-wise (Incident Type). Every tab has its OWN date-range filter,
/// and each dimension tab additionally has a dropdown of its own values
/// ("All" = comparison bar chart; a specific value = that value's monthly
/// trend). Visible to every logged-in user.
class IncidentDashboardPage extends StatefulWidget {
  const IncidentDashboardPage({super.key});

  @override
  State<IncidentDashboardPage> createState() => _IncidentDashboardPageState();
}

/// Which dimension a tab aggregates on; null = the overview tab.
enum _Dimension { plant, department, nature, type }

class _IncidentDashboardPageState extends State<IncidentDashboardPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Tab _tab(IconData icon, String label) => Tab(
        icon: Icon(icon, size: 18),
        child: Text(label,
            textAlign: TextAlign.center, maxLines: 2, softWrap: true),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcDashboardBg1,
      body: Column(
        children: [
          Container(
            color: kcWhite,
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              indicatorColor: kcvoilet,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              labelColor: kcvoilet,
              unselectedLabelColor: kcLightGrey,
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 12.5),
              unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 12.5),
              dividerColor: kcVeryLightGrey,
              tabs: [
                _tab(Icons.personal_injury_outlined, 'Number of Injuries'),
                _tab(Icons.factory_outlined, 'Plant-wise'),
                _tab(Icons.apartment_outlined, 'Department-wise'),
                _tab(Icons.category_outlined, 'Category-wise'),
                _tab(Icons.label_outline, 'Type-wise'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _DashboardTab(dimension: null),
                _DashboardTab(dimension: _Dimension.plant),
                _DashboardTab(dimension: _Dimension.department),
                _DashboardTab(dimension: _Dimension.nature),
                _DashboardTab(dimension: _Dimension.type),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardTab extends StatefulWidget {
  final _Dimension? dimension;

  const _DashboardTab({required this.dimension});

  @override
  State<_DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<_DashboardTab>
    with AutomaticKeepAliveClientMixin {
  // One hue per tab (single-series charts; identity is carried by the axis
  // labels and titles, never by color alone).
  static const Color _cMonthly = Color(0xFF604ADD); // app violet
  static const Color _cPlant = Color(0xFF0277BD); // blue
  static const Color _cDepartment = Color(0xFFC2185B); // pink
  static const Color _cNature = Color(0xFFE65100); // orange
  static const Color _cType = Color(0xFF2E7D32); // green

  static final DateFormat _apiFmt = DateFormat('yyyy-MM-dd');
  static final DateFormat _labelFmt = DateFormat('dd MMM yyyy');

  late DateTimeRange _range;
  String? _selected; // null = "All"
  List<String> _options = const []; // dropdown values, from the "All" load
  IncidentDashboardStats _stats = const IncidentDashboardStats();
  bool _loading = true;
  String? _error;

  @override
  bool get wantKeepAlive => true;

  Color get _color {
    switch (widget.dimension) {
      case _Dimension.plant:
        return _cPlant;
      case _Dimension.department:
        return _cDepartment;
      case _Dimension.nature:
        return _cNature;
      case _Dimension.type:
        return _cType;
      case null:
        return _cMonthly;
    }
  }

  String get _dimensionLabel {
    switch (widget.dimension) {
      case _Dimension.plant:
        return 'Plant';
      case _Dimension.department:
        return 'Department';
      case _Dimension.nature:
        return 'Nature of Injury';
      case _Dimension.type:
        return 'Incident Type';
      case null:
        return '';
    }
  }

  List<LabelCount> _dimensionList(IncidentDashboardStats s) {
    switch (widget.dimension) {
      case _Dimension.plant:
        return s.byPlant;
      case _Dimension.department:
        return s.byDepartment;
      case _Dimension.nature:
        return s.byNature;
      case _Dimension.type:
        return s.byType;
      case null:
        return const [];
    }
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _range = DateTimeRange(start: DateTime(now.year, 1, 1), end: now);
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final service = Provider.of<IncidentService>(context, listen: false);
      final d = widget.dimension;
      final stats = await service.getIncidentDashboardStats(
        _apiFmt.format(_range.start),
        _apiFmt.format(_range.end),
        plant: d == _Dimension.plant ? _selected : null,
        deptName: d == _Dimension.department ? _selected : null,
        nature: d == _Dimension.nature ? _selected : null,
        incidentType: d == _Dimension.type ? _selected : null,
      );
      if (!mounted) return;
      setState(() {
        _stats = stats;
        _loading = false;
        // The unfiltered ("All") load refreshes the dropdown's value list.
        if (_selected == null) {
          _options = _dimensionList(stats).map((e) => e.label).toList();
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Could not load the dashboard. Please try again.';
      });
    }
  }

  Future<void> _pickRange() async {
    final picked = await showCompactDateRangePicker(
      context,
      initialRange: _range,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      title: 'Incident Date Range',
    );
    if (picked == null) return;
    setState(() => _range = picked);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : _error != null
            ? _buildError()
            : _buildContent();
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off_outlined, size: 56, color: kcLightGrey),
          const SizedBox(height: 10),
          Text(_error!, style: const TextStyle(color: kcLabelGrey)),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _load,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
                backgroundColor: kcvoilet, foregroundColor: kcWhite),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildToolbar(),
              const SizedBox(height: 14),
              _buildStatTiles(),
              const SizedBox(height: 16),
              if (widget.dimension == null || _selected != null)
                _chartCard(
                  title: _selected == null
                      ? 'Injuries per Month'
                      : '$_selected — Injuries per Month',
                  subtitle: 'Incidents by incident date',
                  child: _monthlyChart(),
                )
              else
                _chartCard(
                  title: '$_dimensionLabel-wise Injuries',
                  subtitle: widget.dimension == _Dimension.nature
                      ? 'Nature of injury (latest medical assessment)'
                      : 'Incidents per ${_dimensionLabel.toLowerCase()}',
                  child: _barChart(_dimensionList(_stats), _color),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildToolbar() {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: kcvoilet.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kcvoilet.withValues(alpha: 0.15)),
          ),
          child: Text(
            '${_labelFmt.format(_range.start)}  –  ${_labelFmt.format(_range.end)}',
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: kcvoilet),
          ),
        ),
        ElevatedButton.icon(
          onPressed: _pickRange,
          icon: const Icon(Icons.date_range_outlined, size: 16),
          label: const Text('Date Range',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          style: ElevatedButton.styleFrom(
            backgroundColor: kcvoilet,
            foregroundColor: kcWhite,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        if (widget.dimension != null) _buildDimensionDropdown(),
        Tooltip(
          message: 'Refresh',
          child: InkWell(
            onTap: _load,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: kcStatGreen.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kcStatGreen.withValues(alpha: 0.3)),
              ),
              child: const Icon(Icons.refresh_rounded,
                  color: kcStatGreen, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDimensionDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _color.withValues(alpha: 0.4)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: _selected,
          hint: Text('All ${_dimensionLabel}s',
              style: const TextStyle(fontSize: 13)),
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600, color: _color),
          icon: Icon(Icons.arrow_drop_down, color: _color),
          items: [
            DropdownMenuItem<String?>(
              value: null,
              child: Text('All ${_dimensionLabel}s',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
            ),
            ..._options.map((o) => DropdownMenuItem<String?>(
                  value: o,
                  child: Text(o,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13)),
                )),
          ],
          onChanged: (v) {
            setState(() => _selected = v);
            _load();
          },
        ),
      ),
    );
  }

  Widget _buildStatTiles() {
    final now = DateTime.now();
    final thisMonthLabel = DateFormat('MMM yyyy').format(now);
    int thisMonth = 0;
    for (final m in _stats.byMonth) {
      if (m.label == thisMonthLabel) thisMonth = m.count;
    }
    final tiles = <Widget>[
      _statTile(
          _selected == null
              ? 'Number of Injuries'
              : 'Injuries — $_selected',
          _stats.totalIncidents,
          _color,
          Icons.personal_injury_outlined),
      _statTile('This Month', thisMonth, kcvoilet, Icons.today_outlined),
      if (widget.dimension != null && _selected == null)
        _statTile('${_dimensionLabel}s Affected',
            _dimensionList(_stats).length, kcStatGreen, Icons.numbers_outlined),
    ];
    return Wrap(spacing: 12, runSpacing: 12, children: tiles);
  }

  Widget _statTile(String label, int value, Color color, IconData icon) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kcVeryLightGrey),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$value',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: kcValueDark)),
                Text(label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: kcLabelGrey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chartCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kcVeryLightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: kcValueDark)),
          Text(subtitle,
              style: const TextStyle(fontSize: 11.5, color: kcLabelGrey)),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  static const _axisLabelStyle = TextStyle(fontSize: 11, color: kcLabelGrey);
  static const _dataLabelStyle = TextStyle(
      fontSize: 11, fontWeight: FontWeight.w600, color: kcValueDark);

  Widget _monthlyChart() {
    final data = _stats.byMonth;
    if (_stats.totalIncidents == 0) return _emptyChart();
    return SizedBox(
      height: 280,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(width: 1, color: kcVeryLightGrey),
          labelStyle: _axisLabelStyle,
        ),
        primaryYAxis: NumericAxis(
          interval: _yInterval(data),
          majorGridLines:
              const MajorGridLines(width: 0.6, color: kcVeryLightGrey),
          axisLine: const AxisLine(width: 0),
          labelStyle: _axisLabelStyle,
        ),
        tooltipBehavior: TooltipBehavior(enable: true, header: ''),
        series: <CartesianSeries<LabelCount, String>>[
          ColumnSeries<LabelCount, String>(
            dataSource: data,
            xValueMapper: (d, _) => d.label,
            yValueMapper: (d, _) => d.count,
            color: _color,
            width: 0.55,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(4)),
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.outer,
              textStyle: _dataLabelStyle,
            ),
          ),
        ],
      ),
    );
  }

  /// Vertical column chart, highest count first (left). The chart keeps a
  /// FIXED height: when the list grows beyond ~12 categories only the first
  /// 12 are visible and the user pans sideways INSIDE the chart to see the
  /// rest — the page itself never grows taller.
  Widget _barChart(List<LabelCount> source, Color color) {
    if (source.isEmpty || _stats.totalIncidents == 0) return _emptyChart();
    final scrollable = source.length > 12;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (scrollable)
          const Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Text('Drag the chart sideways to see more values →',
                style: TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: kcLabelGrey)),
          ),
        SizedBox(
          height: 320,
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: scrollable,
              zoomMode: ZoomMode.x,
            ),
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 1, color: kcVeryLightGrey),
              labelStyle: _axisLabelStyle,
              labelRotation: -45,
              // Fixed window of 12 categories, starting at the highest counts.
              autoScrollingDelta: scrollable ? 12 : null,
              autoScrollingMode: AutoScrollingMode.start,
            ),
            primaryYAxis: NumericAxis(
              interval: _yInterval(source),
              majorGridLines:
                  const MajorGridLines(width: 0.6, color: kcVeryLightGrey),
              axisLine: const AxisLine(width: 0),
              labelStyle: _axisLabelStyle,
            ),
            tooltipBehavior: TooltipBehavior(enable: true, header: ''),
            series: <CartesianSeries<LabelCount, String>>[
              ColumnSeries<LabelCount, String>(
                dataSource: source,
                xValueMapper: (d, _) => d.label,
                yValueMapper: (d, _) => d.count,
                color: color,
                width: 0.55,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.outer,
                  textStyle: _dataLabelStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _emptyChart() {
    return SizedBox(
      height: 180,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bar_chart,
                size: 40, color: kcLightGrey.withValues(alpha: 0.5)),
            const SizedBox(height: 8),
            const Text('No incidents in the selected period',
                style: TextStyle(fontSize: 12.5, color: kcLabelGrey)),
          ],
        ),
      ),
    );
  }

  /// Keep integer ticks on count axes.
  double? _yInterval(List<LabelCount> data) {
    var maxCount = 0;
    for (final d in data) {
      if (d.count > maxCount) maxCount = d.count;
    }
    return maxCount <= 6 ? 1 : null;
  }

}
