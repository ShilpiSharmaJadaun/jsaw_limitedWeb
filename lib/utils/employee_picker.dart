import 'package:flutter/material.dart';
import 'package:jsaw_limited/utils/app_color.dart';

/// Generic employee picker with the same look as the
/// "Root Cause – Inquired With" picker: searchable by name or employee code,
/// avatar initial, **Name** / "Emp Code: X" rows. Pure UI — the caller passes
/// whatever list it already has and gets the picked item back unchanged.
///
/// Returns the picked item, or null when dismissed.
Future<T?> showEmployeePicker<T>(
  BuildContext context, {
  required List<T> items,
  required String Function(T) name,
  required String Function(T) code,
  String title = 'Select Employee',
  String? Function(T)? subtitle,
  String Function(T)? extraSearch,
  Set<String> alreadySelected = const {},
  String emptyText = 'No matching employee',
}) {
  return showDialog<T>(
    context: context,
    builder: (_) => EmployeePickerSheet<T>(
      items: items,
      name: name,
      code: code,
      title: title,
      subtitle: subtitle,
      extraSearch: extraSearch,
      alreadySelected: alreadySelected,
      emptyText: emptyText,
    ),
  );
}

class EmployeePickerSheet<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) name;
  final String Function(T) code;
  final String title;
  final String? Function(T)? subtitle;

  /// Optional extra text (e.g. grade / work group) that the search box also
  /// matches against, in addition to name and code.
  final String Function(T)? extraSearch;
  final Set<String> alreadySelected;
  final String emptyText;

  const EmployeePickerSheet({
    super.key,
    required this.items,
    required this.name,
    required this.code,
    required this.title,
    this.subtitle,
    this.extraSearch,
    this.alreadySelected = const {},
    this.emptyText = 'No matching employee',
  });

  @override
  State<EmployeePickerSheet<T>> createState() => _EmployeePickerSheetState<T>();
}

class _EmployeePickerSheetState<T> extends State<EmployeePickerSheet<T>> {
  late List<T> _filtered;
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = widget.items;
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _onSearch(String q) {
    final query = q.trim().toLowerCase();
    setState(() {
      _filtered = query.isEmpty
          ? widget.items
          : widget.items
              .where((e) =>
                  widget.code(e).toLowerCase().contains(query) ||
                  widget.name(e).toLowerCase().contains(query) ||
                  (widget.extraSearch?.call(e).toLowerCase().contains(query) ??
                      false))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person_search_outlined,
                  color: kcvoilet, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(widget.title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _search,
            autofocus: true,
            onChanged: _onSearch,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Search by name or employee code…',
              prefixIcon: const Icon(Icons.search, size: 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 460,
        height: 420,
        child: _filtered.isEmpty
            ? Center(
                child: Text(widget.emptyText,
                    style: const TextStyle(color: kcLabelGrey)))
            : ListView.separated(
                itemCount: _filtered.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.grey.shade200),
                itemBuilder: (context, i) {
                  final e = _filtered[i];
                  final n = widget.name(e);
                  final c = widget.code(e);
                  final taken = widget.alreadySelected.contains(c);
                  final sub = widget.subtitle?.call(e);
                  return ListTile(
                    dense: true,
                    enabled: !taken,
                    leading: CircleAvatar(
                      radius: 16,
                      backgroundColor: kcvoilet.withOpacity(0.12),
                      child: Text(
                        n.trim().isEmpty ? '?' : n.trim()[0].toUpperCase(),
                        style: const TextStyle(
                            color: kcvoilet,
                            fontWeight: FontWeight.w700,
                            fontSize: 13),
                      ),
                    ),
                    title: Text(n,
                        style: const TextStyle(
                            fontSize: 13.5, fontWeight: FontWeight.w600)),
                    subtitle: Text(
                      sub == null || sub.isEmpty
                          ? 'Emp Code: $c'
                          : 'Emp Code: $c   •   $sub',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: taken
                        ? const Icon(Icons.check_circle,
                            color: kcobservationgreen, size: 18)
                        : null,
                    onTap: taken ? null : () => Navigator.pop(context, e),
                  );
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
