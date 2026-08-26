import 'dart:ui' hide window;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/allMedicalOfficerList_bloc.dart';
import 'package:flutter/material.dart';
import 'package:jsaw_limited/bloc/completeMedicalResponse_bloc.dart';
import 'package:jsaw_limited/model/allMedicalOfficerList_model.dart';
import 'package:jsaw_limited/model/completeMedicalResponse_model.dart';
import 'package:jsaw_limited/pages/medical_Officer_page.dart';
import 'package:jsaw_limited/pages/medical_response_detail_page.dart';
import 'package:jsaw_limited/state/allMedicalOfficerList_state.dart';
import 'package:jsaw_limited/state/completeMedicalResponse_state.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web/web.dart' show window;
import '../bloc/all_filter_observation_bloc.dart';
import '../service/incident_service.dart';
import '../utils/app_color.dart';
import '../utils/progressive_image.dart';

class MedicalOfficerList extends StatefulWidget {
  const MedicalOfficerList({super.key});

  @override
  State<MedicalOfficerList> createState() => _MedicalOfficerListState();
}

class _MedicalOfficerListState extends State<MedicalOfficerList> {
  late CompleteMedicalResponseBloc completeMedicalResponseBloc;

  @override
  void initState() {
    super.initState();
    final incidentService = Provider.of<IncidentService>(context, listen: false);
    completeMedicalResponseBloc = CompleteMedicalResponseBloc(incidentService);
    completeMedicalResponseBloc.initState();
  }

  int currentPage = 0;
  late String raisedSessionID = window.localStorage.getItem('kRaisedSessionID') ?? "";

  // Tracker point 3: "Check Details" — when set, the read-only detail view of
  // the selected completed response is shown INLINE (inside the app shell).
  CompleteMedicalResponseModel? _selected;

  @override
  Widget build(BuildContext context) {
    if (_selected != null) {
      return MedicalResponseDetailPage(
        response: _selected!,
        onBack: () => setState(() => _selected = null),
      );
    }
    return  Scaffold(
      backgroundColor: kcDashboardBg1,
      body: _buildAllIncidentList(),
    );
  }

  _buildAllIncidentList() {
    return BlocConsumer<CompleteMedicalResponseBloc, CompleteMedicalResponseState>(
      bloc: completeMedicalResponseBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: (_) {
              return Center(
                child: Lottie.asset("assets/lottie/loading.json",
                    height: 80, width: 80),
              );
            },
            content: (model) => model.isEmpty
                ? _buildEmpty('No completed medical responses found')
                : _buildContent(model),
            success: (model) => model.isEmpty
                ? _buildEmpty('No completed medical responses found')
                : _buildContent(model),
            failed: (_, msg) => _buildEmpty(msg));
      },
    );
  }

  Widget _buildEmpty(String message) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kcDashboardBg1, kcDashboardBg2],
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline, size: 64, color: kcLightGrey),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: kcValueDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<CompleteMedicalResponseModel> model) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kcDashboardBg1, kcDashboardBg2],
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: model.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ----- Image section -----
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 16.screenWidth,
                      height: 12.screenHeight,
                      child: ProgressiveImage(
                        highUrl: model[index].imageUrl,
                        lowUrl: model[index].lowQualityImageUrl,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // ----- Content section -----
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Top row: 3 columns of grouped info
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoSection(
                                    icon: Icons.tag,
                                    iconColor: kcvoilet,
                                    label: "Incident ID",
                                    value: model[index].incidentUniqueId,
                                    valueColor: kcValueDark,
                                  ),
                                  _buildInfoSection(
                                    icon: Icons.person_outline_rounded,
                                    iconColor: kcStatBlue,
                                    label: "Employee Name / Code",
                                    value:
                                    "${model[index].employeeName} (${model[index].employeeCode})",
                                    valueColor: kcValueDark,
                                  ),
                                  _buildInfoSection(
                                    icon: Icons.factory_outlined,
                                    iconColor: kcInfoPlant,
                                    label: "Plant / Dept",
                                    value: model[index].plant,
                                    valueColor: kcValueDark,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoSection(
                                    icon: Icons.engineering_outlined,
                                    iconColor: kcInfoContractor,
                                    label: "Contractor Name",
                                    value: model[index].contractorName,
                                    valueColor: kcValueDark,
                                  ),
                                  _buildInfoSection(
                                    icon: Icons.location_on_outlined,
                                    iconColor: kcInfoLocation,
                                    label: "Location",
                                    value: model[index].location,
                                    valueColor: kcValueDark,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoSection(
                                    icon:  Icons.warning_amber_rounded,
                                    iconColor: kcStatAmber,
                                    label: "Incident Type",
                                    value: model[index].incidentType,
                                    valueColor: kcRed,
                                  ),
                                  _buildInfoSection(
                                    icon: Icons.assignment_ind_outlined,
                                    iconColor: kcInfoResponsibility,
                                    label: "Responsibility",
                                    value: model[index].responsibleShiftEngg,
                                    valueColor: kcmegenta,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Soft gradient divider
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.grey.shade300,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),

                        // FIR Date with pill chip
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Row(
                              children: [
                                _buildIconBadge(Icons.event_note_outlined, kcInfoFir),
                                const SizedBox(width: 8),
                                _buildLabel("FIR Date :"),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: _buildPillBadge(model[index].firDateTime, kcInfoFir),
                                ),
                              ],
                            )),

                            const SizedBox(width: 8),
                            Expanded(
                              child: Row(
                                children: [
                                  _buildIconBadge(Icons.calendar_today_rounded, kcInfoDate),
                                  const SizedBox(width: 8),
                                  _buildLabel("Date :"),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: _buildPillBadge(
                                      model[index].incidentDateTime,
                                      kcStatAmber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Observations
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildIconBadge(Icons.visibility_outlined,
                                kcInfoObservation),
                            const SizedBox(width: 8),
                            _buildLabel("Description :"),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  model[index].descpOfIncident,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 1.8.screenWidth,
                                    color: kcValueDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildIconBadge(Icons.visibility_outlined,
                                kcInfoObservation),
                            const SizedBox(width: 8),
                            _buildLabel("Medical Officer Remark :"),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  model[index].medicalOfficerRemarks,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 1.8.screenWidth,
                                    color: kcValueDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Check Details (tracker point 3) — opens the read-only
                        // view of the submitted medical assessment.
                        Align(
                          alignment: Alignment.centerRight,
                          child: _buildCheckDetailsButton(
                            () => setState(() => _selected = model[index]),
                          ),
                        ),

                        // // Plant
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     _buildIconBadge(
                        //         Icons.precision_manufacturing_outlined,
                        //         kcInfoPlant),
                        //     const SizedBox(width: 8),
                        //     _buildLabel("Plant :"),
                        //     const SizedBox(width: 8),
                        //     Expanded(
                        //       child: Padding(
                        //         padding:
                        //         const EdgeInsets.symmetric(vertical: 4),
                        //         child: Text(
                        //           model[index].plant,
                        //           maxLines: 5,
                        //           overflow: TextOverflow.ellipsis,
                        //           style: const TextStyle(
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 14,
                        //             color: kcValueDark,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------- Reusable building blocks ----------

  /// Pill-style "Check Details" button (bottom-right of each completed card).
  Widget _buildCheckDetailsButton(VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: kcStatBlue,
        foregroundColor: kcWhite,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      icon: const Icon(Icons.fact_check_outlined, size: 16),
      label: const Text(
        'Check Details',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5),
      ),
    );
  }

  /// Builds an info group: colored icon + label + colored-accent value card.
  Widget _buildInfoSection({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.15.screenHeight),
          child: Row(
            children: [
              _buildIconBadge(icon, iconColor),
              const SizedBox(width: 6),
              _buildLabel("$label :"),
            ],
          ),
        ),
        _buildTextBox(value, valueColor, accentColor: iconColor),
      ],
    );
  }

  /// Colored circular icon badge — colorful icon on a tinted square background.
  Widget _buildIconBadge(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 15),
    );
  }

  /// Pill-style chip for short emphasized values like dates.
  Widget _buildPillBadge(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  /// Compact label (replaces the old grey heading text).
  Widget _buildLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
        color: kcLabelGrey,
      ),
    );
  }

  /// Kept for backwards-compatibility if referenced elsewhere.
  _buildHeadingText(String title) {
    return Padding(
      padding: EdgeInsets.all(1.screenWidth),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 2.2.screenWidth,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  /// Value card with a left-edge colored accent bar matching its icon color.
  Widget _buildTextBox(String title, Color color, {Color? accentColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 1.screenWidth, vertical: 0.15.screenHeight),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 2.4.screenHeight),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: (accentColor ?? Colors.black).withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (accentColor != null)
                Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 1.2.screenWidth,
                    vertical: 0.2.screenHeight,
                  ),
                  child: Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 1.5.screenWidth,
                      color: color,
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

  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }

}


