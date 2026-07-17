import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/suggestion_feedback_bloc.dart';
import 'package:jsaw_limited/model/raised_feedback_model.dart';
import 'package:jsaw_limited/pages/suggestion_page.dart';
import 'package:jsaw_limited/state/suggestion_feedback_state.dart';
import 'package:provider/provider.dart';
import '../service/observation_service.dart';
import '../utils/app_color.dart';

class AdminComplaintsPage extends StatefulWidget {
  const AdminComplaintsPage({super.key});

  @override
  State<AdminComplaintsPage> createState() => _AdminComplaintsPageState();
}

class _AdminComplaintsPageState extends State<AdminComplaintsPage> {
  late final SuggestionFeedbackBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SuggestionFeedbackBloc(
        Provider.of<ObservationService>(context, listen: false));
    _bloc.initState();
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: BoxDecoration(
                color: kcWhite,
                borderRadius: BorderRadius.circular(14),
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.support_agent,
                        color: Color(0xFF10B981), size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Complaint Management',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: kcValueDark)),
                      Text('Review and reply to all raised complaints',
                          style: TextStyle(
                              fontSize: 11,
                              color: kcLabelGrey,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Refresh',
                    icon: const Icon(Icons.refresh_rounded,
                        color: kcLabelGrey, size: 20),
                    onPressed: () => _bloc.initState(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Complaints list
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              decoration: BoxDecoration(
                color: kcWhite,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: BlocConsumer<SuggestionFeedbackBloc, SuggestionFeedbackState>(
                bloc: _bloc,
                listener: (_, __) {},
                builder: (_, state) => state.when(
                  loading: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  content: _list,
                  success: _list,
                  failed: (list, __) => _list(list),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(List<SuggestionFeedbackModel> items) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.inbox_outlined, color: kcLabelGrey, size: 56),
            SizedBox(height: 8),
            Text('No complaints raised yet',
                style: TextStyle(
                    color: kcLabelGrey, fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (_, i) =>
          ComplaintCard(
              item: items[i],
              viewerType: 'admin',
              onDeleted: () => _bloc.initState()),
    );
  }
}
