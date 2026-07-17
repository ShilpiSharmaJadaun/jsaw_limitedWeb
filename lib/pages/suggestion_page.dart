import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsaw_limited/bloc/suggestion_bloc.dart';
import 'package:jsaw_limited/bloc/suggestion_feedback_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jsaw_limited/model/complaint_reply_model.dart';
import 'package:jsaw_limited/model/raised_feedback_model.dart';
import 'package:jsaw_limited/state/suggestion_feedback_state.dart';
import 'package:jsaw_limited/state/suggestion_state.dart';
import 'package:jsaw_limited/utils/progressive_image.dart';
import 'package:provider/provider.dart';
import '../bloc/priority_bloc.dart';
import '../model/priority_model.dart';
import '../service/constant.dart';
import '../service/observation_service.dart';
import '../state/priority_state.dart';
import '../utils/app_color.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'image_picker.dart';
import 'package:web/web.dart' as html;
import 'dart:io' as io;

class SuggestionFeedbackPage extends StatefulWidget {
  const SuggestionFeedbackPage({super.key});

  @override
  State<SuggestionFeedbackPage> createState() => _SuggestionFeedbackPageState();
}

class _SuggestionFeedbackPageState extends State<SuggestionFeedbackPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    tabController.dispose();
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
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: kcWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: tabController,
              labelColor: kcOrange,
              unselectedLabelColor: kcLabelGrey,
              indicatorColor: kcOrange,
              indicatorWeight: 3,
              tabs: const [
                Tab(
                  icon: Icon(Icons.edit_note_outlined),
                  text: 'Create Complaint',
                ),
                Tab(
                  icon: Icon(Icons.inbox_outlined),
                  text: 'Raised Complaints',
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              decoration: BoxDecoration(
                color: kcWhite,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TabBarView(
                controller: tabController,
                children: const [
                  SuggestionPage(),
                  RaisedSuggestionPage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController suggestionController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();

  late String priorityColor = "";
  late final PriorityBloc priorityBloc;
  late final SaveSuggestionBloc saveSuggestionBloc;
  final ValueNotifier<String> priority = ValueNotifier("Select Priority");
  final GlobalKey<ImagePickerPageState> _imagePickerKey =
      GlobalKey<ImagePickerPageState>();

  Uint8List? _selectedImage;

  void _onImagePicked(dynamic image, [Uint8List? webImageBytes]) {
    setState(() => _selectedImage = webImageBytes);
  }

  @override
  void initState() {
    super.initState();
    final observationService =
        Provider.of<ObservationService>(context, listen: false);
    priorityBloc = PriorityBloc(observationService);
    saveSuggestionBloc = SaveSuggestionBloc(observationService);
    priorityBloc.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    suggestionController.dispose();
    dateTimeController.dispose();
    priority.dispose();
    super.dispose();
  }

  String determineOperatingSystem() {
    if (kIsWeb) {
      return html.window.navigator.userAgent.contains('Mobi')
          ? 'Mobile Web'
          : 'Desktop Web';
    } else if (io.Platform.isAndroid) return 'Android';
    else if (io.Platform.isIOS) return 'iOS';
    else if (io.Platform.isWindows) return 'Windows';
    else if (io.Platform.isMacOS) return 'macOS';
    else if (io.Platform.isLinux) return 'Linux';
    return 'Unknown';
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: now,
    );
    if (selectedDate == null) return;
    if (!mounted) return;
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime == null) return;
    final fullDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    final clampedDateTime = fullDateTime.isAfter(now) ? now : fullDateTime;
    dateTimeController.text =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(clampedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          final twoCol = constraints.maxWidth > 880;
          final imageCard = _imageCard();
          final formCard = _formCard();
          if (twoCol) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: imageCard),
                const SizedBox(width: 16),
                Expanded(flex: 6, child: formCard),
              ],
            );
          }
          return Column(
            children: [
              imageCard,
              const SizedBox(height: 16),
              formCard,
            ],
          );
        },
      ),
    );
  }

  // ============ Cards ============
  Widget _imageCard() {
    return _sectionCard(
      title: 'Attach a screenshot',
      subtitle: 'Helps us understand the issue at a glance',
      icon: Icons.image_outlined,
      accent: const Color(0xFFEC4899),
      child: ImagePickerPage(
          key: _imagePickerKey, onImagePicked: _onImagePicked),
    );
  }

  Widget _formCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionCard(
          title: 'Title',
          subtitle: 'A short summary of what happened',
          icon: Icons.title_outlined,
          accent: const Color(0xFF3B82F6),
          child: _modernTextField(
              titleController, 'e.g. App crashes when saving observation', 1,
              maxLength: 255),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _sectionCard(
                title: 'When did it happen?',
                icon: Icons.event_outlined,
                accent: const Color(0xFF8B5CF6),
                child: _timeField(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _sectionCard(
                title: 'Priority',
                icon: Icons.flag_outlined,
                accent: const Color(0xFFF59E0B),
                child: _buildPriority(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _sectionCard(
          title: 'Description',
          subtitle: 'Steps to reproduce, expected vs actual behaviour…',
          icon: Icons.description_outlined,
          accent: const Color(0xFF10B981),
          child: _modernTextField(
              suggestionController, 'Describe the issue in detail…', 6),
        ),
        const SizedBox(height: 18),
        _buildSubmit(),
      ],
    );
  }

  // ============ Section card shell ============
  Widget _sectionCard({
    required String title,
    String? subtitle,
    required IconData icon,
    required Color accent,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: kcValueDark)),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(subtitle,
                            style: const TextStyle(
                                fontSize: 11,
                                color: kcLabelGrey,
                                fontWeight: FontWeight.w500)),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: child,
          ),
        ],
      ),
    );
  }

  // ============ Time field ============
  Widget _timeField() {
    return GestureDetector(
      onTap: () => _selectDateTime(context),
      child: AbsorbPointer(
        child: TextField(
          controller: dateTimeController,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: kcValueDark),
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Pick date & time',
            prefixIcon:
                const Icon(Icons.schedule, size: 18, color: Color(0xFF8B5CF6)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            filled: true,
            fillColor: kcDashboardBg1,
            border: _roundedBorder(),
            enabledBorder: _roundedBorder(),
            focusedBorder: _roundedBorder(focused: true),
          ),
        ),
      ),
    );
  }

  // ============ Priority chip ============
  Widget _buildPriority() {
    return BlocConsumer<PriorityBloc, PriorityState>(
      bloc: priorityBloc,
      listener: (_, state) {},
      builder: (_, state) => state.when(
        loading: (_) => const SizedBox(
            height: 44,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
        content: _priorityChip,
        success: _priorityChip,
        failed: (form, __) => _priorityChip(form),
      ),
    );
  }

  Widget _priorityChip(List<PriorityModel> priorityModel) {
    return InkWell(
      onTap: () => _buildPriorityDialog(priorityModel),
      borderRadius: BorderRadius.circular(10),
      child: ValueListenableBuilder<String>(
        valueListenable: priority,
        builder: (context, value, _) {
          final selected = value != 'Select Priority';
          final color = selected ? hexToColor(priorityColor) : kcLightGrey;
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: selected
                  ? color.withOpacity(0.10)
                  : kcDashboardBg1,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: selected ? color : Colors.grey.shade300,
                  width: selected ? 1.4 : 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      color: selected ? color : kcLabelGrey,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.arrow_drop_down,
                    color: selected ? color : kcLabelGrey),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _buildPriorityDialog(List<PriorityModel> priorityModel) {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 8, 8),
                child: Row(
                  children: [
                    const Icon(Icons.flag_outlined,
                        color: Color(0xFFF59E0B), size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text('Select priority',
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
              const Divider(height: 1),
              ListView.builder(
                shrinkWrap: true,
                itemCount: priorityModel.length,
                itemBuilder: (_, i) {
                  final p = priorityModel[i];
                  final color = hexToColor(p.priorityStatusColour);
                  return InkWell(
                    onTap: () {
                      priority.value = p.priorityStatusName;
                      priorityColor = p.priorityStatusColour;
                      Navigator.pop(ctx);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(p.priorityStatusName,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: color,
                                    fontWeight: FontWeight.w700)),
                          ),
                          Text(p.priorityStatusDeadline,
                              style: const TextStyle(
                                  fontSize: 11, color: kcLabelGrey)),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // ============ Submit ============
  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: kcRed),
    );
  }

  Widget _buildSubmit() {
    return BlocConsumer<SaveSuggestionBloc, SaveSuggestionState>(
      bloc: saveSuggestionBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message ?? 'Complaint submitted successfully'),
              backgroundColor: kcobservationgreen,
            ));
            titleController.clear();
            suggestionController.clear();
            dateTimeController.clear();
            priority.value = 'Select Priority';
            priorityColor = '';
            setState(() => _selectedImage = null);
            _imagePickerKey.currentState?.clearImage();
            RaisedSuggestionPage.refresh?.call();
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
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: (_) => true,
          orElse: () => false,
        );
        return SizedBox(
          height: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF059669)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF10B981).withOpacity(0.32),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: isLoading
                  ? null
                  : () async {
                      if (titleController.text.trim().isEmpty) {
                        _showValidationError('Please enter a title.');
                        return;
                      }
                      if (suggestionController.text.trim().isEmpty) {
                        _showValidationError('Please enter a description.');
                        return;
                      }
                      if (dateTimeController.text.trim().isEmpty) {
                        _showValidationError(
                            'Please pick when it happened.');
                        return;
                      }
                      if (priority.value == 'Select Priority') {
                        _showValidationError('Please select a priority.');
                        return;
                      }
                      if (_selectedImage == null) {
                        _showValidationError(
                            'Please attach a screenshot first.');
                        return;
                      }
                      await saveSuggestionBloc.saveSuggestion(
                          _selectedImage!,
                          titleController.text,
                          suggestionController.text,
                          dateTimeController.text,
                          appVersion,
                          determineOperatingSystem(),
                          priority.value,
                          html.window.localStorage.getItem('kEmployeeCode') ??
                              '',
                          html.window.localStorage.getItem('kEmployeename') ??
                              '',
                          'pending');
                    },
              icon: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(kcWhite),
                      ),
                    )
                  : const Icon(Icons.send_outlined, color: kcWhite),
              label: const Text(
                'Submit Complaint',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: kcWhite,
                    letterSpacing: 0.3),
              ),
            ),
          ),
        );
      },
    );
  }

  // ============ Shared field ============
  Widget _modernTextField(
      TextEditingController controller, String hint, int lines,
      {int? maxLength}) {
    return TextField(
      controller: controller,
      maxLines: lines == 1 ? 1 : null,
      minLines: lines,
      maxLength: maxLength,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: kcValueDark),
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        counterText: maxLength != null ? '' : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        filled: true,
        fillColor: kcDashboardBg1,
        hintStyle: const TextStyle(
            fontSize: 12, color: kcMediumGrey, fontWeight: FontWeight.w500),
        border: _roundedBorder(),
        enabledBorder: _roundedBorder(),
        focusedBorder: _roundedBorder(focused: true),
      ),
    );
  }

  OutlineInputBorder _roundedBorder({bool focused = false}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
            color: focused ? kcvoilet : Colors.grey.shade300,
            width: focused ? 1.4 : 1),
      );

  Color hexToColor(String hexString) {
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

class RaisedSuggestionPage extends StatefulWidget {
  const RaisedSuggestionPage({super.key});

  /// Called by SuggestionPage after a successful submit to refresh the list
  /// from the sibling tab without sharing a bloc.
  static void Function()? refresh;

  @override
  State<RaisedSuggestionPage> createState() => _RaisedSuggestionPageState();
}

class _RaisedSuggestionPageState extends State<RaisedSuggestionPage> {
  late final SuggestionFeedbackBloc suggestionFeedbackBloc;

  @override
  void initState() {
    super.initState();
    final observationService =
        Provider.of<ObservationService>(context, listen: false);
    suggestionFeedbackBloc = SuggestionFeedbackBloc(observationService);
    suggestionFeedbackBloc.initState();
    RaisedSuggestionPage.refresh = () {
      if (mounted) suggestionFeedbackBloc.initState();
    };
  }

  @override
  void dispose() {
    RaisedSuggestionPage.refresh = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kcWhite,
      child: BlocConsumer<SuggestionFeedbackBloc, SuggestionFeedbackState>(
        bloc: suggestionFeedbackBloc,
        listener: (_, state) {},
        builder: (_, state) => state.when(
          loading: _loading,
          content: _list,
          success: _list,
          failed: (form, __) => _list(form),
        ),
      ),
    );
  }

  Widget _loading(List<SuggestionFeedbackModel> _) =>
      const Center(child: CircularProgressIndicator());

  Widget _list(List<SuggestionFeedbackModel> model) {
    if (model.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.inbox_outlined, color: kcLabelGrey, size: 56),
              SizedBox(height: 8),
              Text('No complaints yet',
                  style: TextStyle(
                      color: kcLabelGrey, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: model.length,
      itemBuilder: (_, i) => ComplaintCard(item: model[i]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Complaint card — StatefulWidget so it owns the reply thread + input state.
// viewerType: 'customer' (Write Us tab) or 'admin' (support team page)
// ─────────────────────────────────────────────────────────────────────────────
class ComplaintCard extends StatefulWidget {
  const ComplaintCard(
      {required this.item, this.viewerType = 'customer', this.onDeleted});
  final SuggestionFeedbackModel item;
  final String viewerType;
  final VoidCallback? onDeleted;

  @override
  State<ComplaintCard> createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  late List<ComplaintReplyModel> _replies;
  final TextEditingController _replyController = TextEditingController();
  final TextEditingController _resolutionController = TextEditingController();
  bool _sending = false;
  bool _deleting = false;
  bool _savingResolution = false;
  bool _showResolutionInput = false;
  Uint8List? _selectedReplyImage;
  late String _localResolution;

  @override
  void initState() {
    super.initState();
    _replies = List.from(widget.item.replies);
    _localResolution = widget.item.solutionRemark;
  }

  @override
  void dispose() {
    _replyController.dispose();
    _resolutionController.dispose();
    super.dispose();
  }

  Future<void> _saveResolution() async {
    final text = _resolutionController.text.trim();
    if (text.isEmpty) return;
    setState(() => _savingResolution = true);
    try {
      final service = Provider.of<ObservationService>(context, listen: false);
      await service.closeComplaint(widget.item.id, text);
      if (!mounted) return;
      setState(() {
        _localResolution = text;
        _showResolutionInput = false;
        _savingResolution = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _savingResolution = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save: $e'), backgroundColor: kcRed),
      );
    }
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Color(0xFFEF4444), size: 22),
            SizedBox(width: 8),
            Text('Delete Complaint',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          ],
        ),
        content: const Text(
          'This will permanently delete the complaint, all replies, and all attachments. This cannot be undone.',
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Delete',
                style: TextStyle(
                    color: kcWhite, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _deleting = true);
    try {
      final service = Provider.of<ObservationService>(context, listen: false);
      await service.deleteComplaint(widget.item.id);
      if (!mounted) return;
      widget.onDeleted?.call();
    } catch (e) {
      if (!mounted) return;
      setState(() => _deleting = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Delete failed: $e'),
        backgroundColor: kcRed,
      ));
    }
  }

  Future<void> _pickReplyImage() async {
    try {
      final picked = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 90);
      if (picked == null) return;
      final bytes = await picked.readAsBytes();
      if (mounted) setState(() => _selectedReplyImage = bytes);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not select image: $e'), backgroundColor: kcRed),
      );
    }
  }

  bool get _isClosed =>
      widget.item.status.toLowerCase() == 'closed' ||
      widget.item.status.toLowerCase() == 'resolved';

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFF59E0B);
      case 'resolved':
      case 'closed':
      case 'success':
        return const Color(0xFF10B981);
      case 'inprogress':
      case 'in progress':
        return const Color(0xFF3B82F6);
      default:
        return const Color(0xFFEF4444);
    }
  }

  Future<void> _sendReply() async {
    final msg = _replyController.text.trim();
    if (msg.isEmpty && _selectedReplyImage == null) return;
    setState(() => _sending = true);
    final imageToSend = _selectedReplyImage;
    try {
      final service =
          Provider.of<ObservationService>(context, listen: false);
      final empCode =
          html.window.localStorage.getItem('kEmployeeCode') ?? '';
      final empName =
          html.window.localStorage.getItem('kEmployeename') ?? '';
      final saved = await service.addComplaintReply(
        complaintId: widget.item.id,
        senderType: widget.viewerType,
        senderName: empName.isNotEmpty ? empName : empCode,
        message: msg,
        imageBytes: imageToSend,
      );
      _replyController.clear();
      setState(() {
        _replies.add(saved);
        _selectedReplyImage = null;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString().replaceFirst('Exception: ', '')),
        backgroundColor: kcRed,
      ));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final statusColor = _statusColor(item.status);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(14),
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
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (ctx, c) {
            final wide = c.maxWidth > 640;
            final image = ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: wide ? 200 : double.infinity,
                height: 170,
                child: ProgressiveImage(
                  highUrl: item.highQualityImageUrl.isNotEmpty
                      ? item.highQualityImageUrl
                      : item.attachments,
                  lowUrl: item.lowQualityImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
            final content = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.complaintNumber.isNotEmpty) ...[
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: kcvoilet.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: kcvoilet.withOpacity(0.30)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                                Icons.confirmation_number_outlined,
                                size: 14,
                                color: kcvoilet),
                            const SizedBox(width: 6),
                            Text(item.complaintNumber,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: kcvoilet,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.3)),
                          ],
                        ),
                      ),
                      if (widget.viewerType == 'admin') ...[
                        const Spacer(),
                        _deleting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFFEF4444)))
                            : IconButton(
                                tooltip: 'Delete complaint',
                                icon: const Icon(Icons.delete_outline,
                                    color: Color(0xFFEF4444), size: 20),
                                onPressed: _confirmDelete,
                              ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _statusChip(item.status, statusColor),
                    _chip(Icons.event_outlined, const Color(0xFF8B5CF6),
                        'Occurred: ${item.dateTimeOfOccurrence}'),
                    if (item.closingTicketDate.isNotEmpty)
                      _chip(Icons.event_available_outlined,
                          const Color(0xFF10B981),
                          'Closed: ${item.closingTicketDate}'),
                  ],
                ),
                const SizedBox(height: 10),
                _kvRow(Icons.title_outlined, const Color(0xFF3B82F6),
                    'Issue', item.issueTitle),
                const SizedBox(height: 8),
                _kvRow(Icons.description_outlined, const Color(0xFF10B981),
                    'Description', item.issueDescription,
                    maxLines: 3),
                if (_localResolution.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _resolutionBlock(_localResolution),
                ],
                if (widget.viewerType == 'admin') ...[
                  const SizedBox(height: 8),
                  _resolutionAdminSection(),
                ],
                // ── Reply thread ──────────────────────────────────────
                if (_replies.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _threadDivider(),
                  const SizedBox(height: 8),
                  ..._replies.map(_replyBubble),
                ],
                // ── Reply input (hidden once closed) ──────────────────
                if (!_isClosed) ...[
                  const SizedBox(height: 12),
                  _replyInput(),
                ] else if (_isClosed) ...[
                  const SizedBox(height: 10),
                  _closedNote(),
                ],
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _chip(Icons.devices_outlined, const Color(0xFFEC4899),
                        item.operatingSystem),
                    _chip(Icons.tag, const Color(0xFFF59E0B),
                        'v${item.softwareVersion}'),
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
                  Expanded(child: content),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                image,
                const SizedBox(height: 12),
                content,
              ],
            );
          },
        ),
      ),
    );
  }

  // ── Thread divider ──────────────────────────────────────────────────────
  Widget _threadDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        const SizedBox(width: 8),
        const Text('Conversation',
            style: TextStyle(
                fontSize: 11,
                color: kcLabelGrey,
                fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      ],
    );
  }

  // ── Reply bubble (chat style) ───────────────────────────────────────────
  Widget _replyBubble(ComplaintReplyModel reply) {
    // "isMe" = the bubble belongs to whoever is currently viewing
    final isMe = reply.senderType == widget.viewerType;
    const adminColor = Color(0xFF10B981);
    const customerColor = Color(0xFF3B82F6);
    // Admin bubbles always green, customer bubbles always blue
    final color = reply.senderType == 'admin' ? adminColor : customerColor;
    String label;
    if (isMe) {
      label = 'You';
    } else if (reply.senderType == 'admin') {
      label = 'Support Team';
    } else {
      label = reply.senderName.isNotEmpty ? reply.senderName : 'Customer';
    }
    final isAdmin = reply.senderType == 'admin'; // kept for icon
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.09),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: Radius.circular(isMe ? 12 : 2),
                bottomRight: Radius.circular(isMe ? 2 : 12),
              ),
              border: Border.all(color: color.withOpacity(0.25)),
            ),
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isAdmin
                          ? Icons.support_agent
                          : Icons.person_outline,
                      size: 12,
                      color: color,
                    ),
                    const SizedBox(width: 4),
                    Text(label,
                        style: TextStyle(
                            fontSize: 10,
                            color: color,
                            fontWeight: FontWeight.w700)),
                    if (reply.createdAt.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Text(reply.createdAt,
                          style: const TextStyle(
                              fontSize: 10, color: kcLabelGrey)),
                    ],
                  ],
                ),
                if (reply.message.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(reply.message,
                      style: const TextStyle(
                          fontSize: 13,
                          color: kcValueDark,
                          fontWeight: FontWeight.w500)),
                ],
                if (reply.attachment.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      reply.attachment,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(Icons.broken_image_outlined,
                              size: 18, color: kcLabelGrey),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Reply input ─────────────────────────────────────────────────────────
  Widget _replyInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Image preview
        if (_selectedReplyImage != null) ...[
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(
                  _selectedReplyImage!,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => setState(() => _selectedReplyImage = null),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close,
                        size: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Attach button
            Tooltip(
              message: 'Attach image',
              child: InkWell(
                onTap: _sending ? null : _pickReplyImage,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _selectedReplyImage != null
                        ? const Color(0xFF3B82F6).withOpacity(0.12)
                        : kcDashboardBg1,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _selectedReplyImage != null
                          ? const Color(0xFF3B82F6)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Icon(
                    Icons.attach_file,
                    size: 18,
                    color: _selectedReplyImage != null
                        ? const Color(0xFF3B82F6)
                        : kcLabelGrey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _replyController,
                minLines: 1,
                maxLines: 4,
                style: const TextStyle(fontSize: 13, color: kcValueDark),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Write a follow-up message…',
                  hintStyle:
                      const TextStyle(fontSize: 12, color: kcLabelGrey),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  filled: true,
                  fillColor: kcDashboardBg1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color(0xFF3B82F6), width: 1.4),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 42,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 0),
                  elevation: 0,
                ),
                onPressed: _sending ? null : _sendReply,
                child: _sending
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(kcWhite)))
                    : const Icon(Icons.send_rounded,
                        color: kcWhite, size: 18),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Closed note ─────────────────────────────────────────────────────────
  Widget _closedNote() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock_outline, size: 13, color: kcLabelGrey),
          SizedBox(width: 6),
          Text('This complaint is closed — replies are disabled.',
              style: TextStyle(fontSize: 11, color: kcLabelGrey)),
        ],
      ),
    );
  }

  // ── Reusable chip widgets ────────────────────────────────────────────────
  Widget _statusChip(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            status.isEmpty ? '—' : status,
            style: TextStyle(
                color: color, fontWeight: FontWeight.w700, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _chip(IconData icon, Color color, String text) {
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
          Text(text,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 11)),
        ],
      ),
    );
  }

  Widget _resolutionAdminSection() {
    const color = Color(0xFF10B981);
    if (_showResolutionInput) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _localResolution.isEmpty ? 'Provide Resolution' : 'Edit Resolution',
              style: const TextStyle(
                  fontSize: 11, color: color, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _resolutionController,
              maxLines: 3,
              style: const TextStyle(fontSize: 13, color: kcValueDark),
              decoration: InputDecoration(
                hintText: 'Describe the resolution / fix applied…',
                hintStyle: TextStyle(color: kcLabelGrey, fontSize: 12),
                filled: true,
                fillColor: kcWhite,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: color.withOpacity(0.3))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: color, width: 1.5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: color.withOpacity(0.25))),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _savingResolution
                      ? null
                      : () => setState(() => _showResolutionInput = false),
                  child: const Text('Cancel',
                      style: TextStyle(color: kcLabelGrey, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: _savingResolution ? null : _saveResolution,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: _savingResolution
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: kcWhite))
                        : const Text('Save',
                            style: TextStyle(
                                color: kcWhite,
                                fontSize: 12,
                                fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    // Button row — "Provide Resolution" or "Edit Resolution"
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () {
          _resolutionController.text = _localResolution;
          setState(() => _showResolutionInput = true);
        },
        icon: Icon(
          _localResolution.isEmpty
              ? Icons.check_circle_outline
              : Icons.edit_outlined,
          size: 15,
          color: color,
        ),
        label: Text(
          _localResolution.isEmpty ? 'Provide Resolution' : 'Edit Resolution',
          style: const TextStyle(
              color: color, fontSize: 12, fontWeight: FontWeight.w700),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          backgroundColor: color.withOpacity(0.08),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _resolutionBlock(String remark) {
    const color = Color(0xFF10B981);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.check_circle_outline, color: color, size: 14),
              SizedBox(width: 6),
              Text('Resolution',
                  style: TextStyle(
                      fontSize: 11,
                      color: color,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 4),
          Text(remark,
              style: const TextStyle(
                  fontSize: 13,
                  color: kcValueDark,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _kvRow(IconData icon, Color color, String label, String value,
      {int maxLines = 2}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 14),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 11,
                      color: kcLabelGrey,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(
                value.isEmpty ? '—' : value,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 13,
                    color: kcValueDark,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
