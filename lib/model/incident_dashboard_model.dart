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

/// One CAPA person past the target date without submitting compliance.
class OverdueCapa {
  final String incidentUniqueId;
  final String empUnqId;
  final String empName;
  final String targetDate;
  final int daysOverdue;
  final String status; // PENDING (never submitted) | REOPEN

  const OverdueCapa({
    required this.incidentUniqueId,
    required this.empUnqId,
    required this.empName,
    required this.targetDate,
    required this.daysOverdue,
    required this.status,
  });

  factory OverdueCapa.fromJson(Map<String, dynamic> json) => OverdueCapa(
        incidentUniqueId: (json['incidentUniqueId'] ?? '').toString(),
        empUnqId: (json['empUnqId'] ?? '').toString(),
        empName: (json['empName'] ?? '').toString(),
        targetDate: (json['targetDate'] ?? '').toString(),
        daysOverdue: (json['daysOverdue'] as num?)?.toInt() ?? 0,
        status: (json['status'] ?? '').toString(),
      );
}

class IncidentDashboardStats {
  final int totalIncidents;
  final List<LabelCount> byMonth;
  final List<LabelCount> byPlant;
  final List<LabelCount> byDepartment;
  final List<LabelCount> byNature;
  final List<LabelCount> byType;
  final List<LabelCount> byInjuryType; // safety remark's Type of Injury
  final List<LabelCount> byBodyPart; // an incident counts under each part
  final int capaPending;
  final int capaOverdue;
  final List<OverdueCapa> overdueCapas;

  const IncidentDashboardStats({
    this.totalIncidents = 0,
    this.byMonth = const [],
    this.byPlant = const [],
    this.byDepartment = const [],
    this.byNature = const [],
    this.byType = const [],
    this.byInjuryType = const [],
    this.byBodyPart = const [],
    this.capaPending = 0,
    this.capaOverdue = 0,
    this.overdueCapas = const [],
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
        byInjuryType: _list(json['byInjuryType']),
        byBodyPart: _list(json['byBodyPart']),
        capaPending: (json['capaPending'] as num?)?.toInt() ?? 0,
        capaOverdue: (json['capaOverdue'] as num?)?.toInt() ?? 0,
        overdueCapas: json['overdueCapas'] is List
            ? (json['overdueCapas'] as List)
                .map((e) => OverdueCapa.fromJson(Map<String, dynamic>.from(e as Map)))
                .toList()
            : const [],
      );
}
