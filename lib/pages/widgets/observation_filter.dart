import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/utils/app_color.dart';

/// Shared filter UI for the observation tabs (Received / Raised / All) so every
/// tab uses one identical design theme. Extracted from the All Observation tab.
///
/// Pieces:
///  - [FilterSearchNotifier] : searchable list backing the picker dialog.
///  - [LoadingChip]          : placeholder shown while a dropdown's data loads.
///  - [FilterDropdownChip]   : the styled dropdown trigger field.
///  - [showObservationPicker]: the violet-header searchable picker dialog.
///  - [ObservationFilterDialog] : the full filter modal (header + sections + actions).

class FilterSearchNotifier<T> extends ValueNotifier<List<T>> {
  FilterSearchNotifier(super.value, {required this.filter}) {
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

/// Loading placeholder that matches the dropdown chip footprint.
class LoadingChip extends StatelessWidget {
  const LoadingChip({super.key});

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

/// Styled dropdown trigger chip — shows the current [notifier] value (or
/// [placeholder]) and a trailing chevron. Tapping fires [onTap] (typically
/// opening [showObservationPicker]).
class FilterDropdownChip extends StatelessWidget {
  final ValueNotifier<String> notifier;
  final String placeholder;
  final VoidCallback onTap;
  final double width;

  const FilterDropdownChip({
    super.key,
    required this.notifier,
    required this.placeholder,
    required this.onTap,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
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
}

/// Violet-header searchable picker dialog. Pass the [items], how to [label]
/// and [filter] them, and what to do [onSelect].
Future<void> showObservationPicker<T>({
  required BuildContext context,
  required String title,
  required List<T> items,
  required String Function(T) label,
  required void Function(T) onSelect,
  required bool Function(T, String) filter,
}) {
  final notifier = FilterSearchNotifier<T>(items, filter: filter);
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 340,
        height: 520,
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
              decoration: const BoxDecoration(
                color: kcvoilet,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                  hintStyle: const TextStyle(color: kcLightGrey, fontSize: 14),
                  prefixIcon:
                      const Icon(Icons.search, color: kcLightGrey, size: 18),
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
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (_, i) => ListTile(
                          dense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          title: Text(label(list[i]),
                              style: const TextStyle(
                                  fontSize: 14, color: kcValueDark)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          hoverColor: kcvoilet.withValues(alpha: 0.06),
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

/// The full filter modal: violet header, grouped sections of [FilterDropdownChip]
/// fields, and Clear / Apply actions. Field widgets and callbacks are injected so
/// each tab keeps its own data wiring.
class ObservationFilterDialog extends StatelessWidget {
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

  const ObservationFilterDialog({
    super.key,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: SizedBox(
        width: 380,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
              decoration: const BoxDecoration(
                color: kcvoilet,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                    icon: const Icon(Icons.close, color: kcWhite, size: 20),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            // Body
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _filterSection('Date Range', [
                      _buildDateField(context, 'Start Date', startDateInput),
                      const SizedBox(height: 8),
                      _buildDateField(context, 'End Date', endDateInput),
                    ]),
                    _filterSection('Location', [
                      plantWidget,
                      const SizedBox(height: 8),
                      departWidget,
                      const SizedBox(height: 8),
                      locationWidget
                    ]),
                    _filterSection('Classification',
                        [statusWidget, const SizedBox(height: 8), hazardWidget]),
                    _filterSection('Observation ID', [uniqueIdWidget]),
                  ],
                ),
              ),
            ),
            // Actions
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: kcVeryLightGrey, width: 1)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onClear,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kcLightGrey,
                        side: const BorderSide(color: kcVeryLightGrey),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.clear_all_rounded, size: 16),
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
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.check_rounded, size: 16),
                      label: const Text('Apply Filters',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14)),
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

  Widget _buildDateField(
      BuildContext context, String hint, TextEditingController controller) {
    return SizedBox(
      height: 44,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 14, color: kcValueDark),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: kcLightGrey, fontSize: 14),
          prefixIcon: const Icon(Icons.calendar_month_outlined,
              size: 18, color: kcLightGrey),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          filled: true,
          fillColor: kcWhite,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1, color: kcVeryLightGrey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1.5, color: kcvoilet)),
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
                    start: DateTime.now().subtract(const Duration(days: 7)),
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
