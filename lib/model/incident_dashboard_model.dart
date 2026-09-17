/// Aggregated counts for the Incident Dashboard
/// (incidentReport/getDashboardStats).
class LabelCount {
  final String label;
  final int count;

  const LabelCount({required this.label, required this.count});

  factory LabelCount.fromJson(Map<String, dynamic> json) => LabelCount(
        label: (json['label'] ?? '').toString(),
        count: (json['count'] as num?)?.toInt() ?? 0,
      );
}

class IncidentDashboardStats {
  final int totalIncidents;
  final List<LabelCount> byMonth;
  final List<LabelCount> byPlant;
  final List<LabelCount> byDepartment;
  final List<LabelCount> byNature;
  final List<LabelCount> byType;

  const IncidentDashboardStats({
    this.totalIncidents = 0,
    this.byMonth = const [],
    this.byPlant = const [],
    this.byDepartment = const [],
    this.byNature = const [],
    this.byType = const [],
  });

  static List<LabelCount> _list(dynamic v) => v is List
      ? v
          .map((e) => LabelCount.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList()
      : const [];

  factory IncidentDashboardStats.fromJson(Map<String, dynamic> json) =>
      IncidentDashboardStats(
        totalIncidents: (json['totalIncidents'] as num?)?.toInt() ?? 0,
        byMonth: _list(json['byMonth']),
        byPlant: _list(json['byPlant']),
        byDepartment: _list(json['byDepartment']),
        byNature: _list(json['byNature']),
        byType: _list(json['byType']),
      );
}
