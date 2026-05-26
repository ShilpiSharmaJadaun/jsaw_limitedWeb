import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/priorityUpdate_bloc.dart';
import 'package:jsaw_limited/state/priorityUpdate_state.dart';
import 'package:provider/provider.dart';

import '../bloc/priority_bloc.dart';
import '../model/priority_model.dart';
import '../service/observation_service.dart';
import '../state/priority_state.dart';
import '../utils/app_color.dart';

class PriorityChangesPage extends StatefulWidget {
  const PriorityChangesPage({super.key});

  @override
  State<PriorityChangesPage> createState() => _PriorityChangesPageState();
}

class _PriorityChangesPageState extends State<PriorityChangesPage> {
  late final PriorityBloc priorityBloc;
  late final PriorityUpdateBloc priorityUpdateBloc;

  // One controller per priority — keyed by status name so they survive rebuilds.
  final Map<String, TextEditingController> _editControllers = {};

  @override
  void initState() {
    super.initState();
    final observationService =
        Provider.of<ObservationService>(context, listen: false);
    priorityBloc = PriorityBloc(observationService);
    priorityUpdateBloc = PriorityUpdateBloc(observationService);
    priorityBloc.initState();
  }

  @override
  void dispose() {
    for (final c in _editControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _controllerFor(String key) {
    return _editControllers.putIfAbsent(key, () => TextEditingController());
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1080),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocConsumer<PriorityUpdateBloc, PriorityUpdateState>(
                  bloc: priorityUpdateBloc,
                  listener: (_, state) {
                    state.maybeWhen(
                      success: (_, message) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(message ?? 'Updated successfully'),
                          backgroundColor: const Color(0xFF10B981),
                        ));
                      },
                      failed: (_, message) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(message),
                          backgroundColor: kcRed,
                        ));
                      },
                      orElse: () {},
                    );
                  },
                  builder: (_, __) => _buildPriorityList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============ Priority list ============
  Widget _buildPriorityList() {
    return BlocBuilder<PriorityBloc, PriorityState>(
      bloc: priorityBloc,
      builder: (_, state) => state.when(
        loading: (_) => const Padding(
          padding: EdgeInsets.all(40),
          child: Center(child: CircularProgressIndicator()),
        ),
        content: _renderCards,
        success: _renderCards,
        failed: (form, msg) => Column(
          children: [
            _renderCards(form),
            if (msg.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(msg,
                    style: const TextStyle(color: kcRed, fontSize: 12)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _renderCards(List<PriorityModel> priorities) {
    if (priorities.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: const [
            Icon(Icons.flag_outlined, size: 56, color: kcLabelGrey),
            SizedBox(height: 8),
            Text('No priorities configured',
                style: TextStyle(color: kcLabelGrey)),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final p in priorities) _priorityCard(p),
      ],
    );
  }

  // ============ Card per priority ============
  Widget _priorityCard(PriorityModel p) {
    final color = _hexToColor(p.priorityStatusColour);
    final controller = _controllerFor(p.priorityStatusName);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.18), color.withOpacity(0.04)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.flag, color: kcWhite, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.priorityStatusName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: color,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.schedule,
                              size: 12, color: kcLabelGrey),
                          const SizedBox(width: 4),
                          Text(
                            'Current deadline: ',
                            style: const TextStyle(
                                fontSize: 11,
                                color: kcLabelGrey,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            p.priorityStatusDeadline.isEmpty
                                ? '—'
                                : p.priorityStatusDeadline,
                            style: const TextStyle(
                                fontSize: 12,
                                color: kcValueDark,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: LayoutBuilder(
              builder: (ctx, c) {
                final wide = c.maxWidth > 540;
                final field = _deadlineField(controller, color);
                final button = _updateButton(p, controller, color);
                if (wide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: field),
                      const SizedBox(width: 12),
                      button,
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    field,
                    const SizedBox(height: 10),
                    button,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _deadlineField(TextEditingController controller, Color color) {
    return TextField(
      controller: controller,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: kcValueDark),
      decoration: InputDecoration(
        isDense: true,
        hintText: 'New deadline (e.g. 24 hours)',
        prefixIcon: Icon(Icons.update, size: 18, color: color),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        filled: true,
        fillColor: kcDashboardBg1,
        hintStyle: const TextStyle(
            fontSize: 12, color: kcMediumGrey, fontWeight: FontWeight.w500),
        border: _border(color, focused: false),
        enabledBorder: _border(color, focused: false),
        focusedBorder: _border(color, focused: true),
      ),
    );
  }

  Widget _updateButton(
      PriorityModel p, TextEditingController controller, Color color) {
    return BlocBuilder<PriorityUpdateBloc, PriorityUpdateState>(
      bloc: priorityUpdateBloc,
      builder: (_, state) {
        final loading = state.maybeWhen(
          loading: (_) => true,
          orElse: () => false,
        );
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.75)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.32),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: kcWhite,
              padding:
                  const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: loading
                ? null
                : () async {
                    if (controller.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please enter a new deadline first.'),
                          backgroundColor: kcRed,
                        ),
                      );
                      return;
                    }
                    final data = {
                      'priorityStatusName': p.priorityStatusName,
                      'priorityStatusDeadline': controller.text.trim(),
                    };
                    await priorityUpdateBloc.initState(data);
                    if (!mounted) return;
                    priorityBloc.initState();
                    controller.clear();
                  },
            icon: loading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(kcWhite),
                    ),
                  )
                : const Icon(Icons.check_circle_outline, size: 18),
            label: const Text('Update',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3)),
          ),
        );
      },
    );
  }

  OutlineInputBorder _border(Color color, {required bool focused}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: focused ? color : Colors.grey.shade300,
        width: focused ? 1.4 : 1,
      ),
    );
  }

  Color _hexToColor(String hexString) {
    if (hexString.isEmpty) return kcLightGrey;
    var s = hexString.replaceFirst('#', '');
    if (s.length == 6) s = 'FF$s';
    try {
      return Color(int.parse(s, radix: 16));
    } catch (_) {
      return kcLightGrey;
    }
  }
}
