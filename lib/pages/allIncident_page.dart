import 'dart:ui' hide window;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/allIncident_bloc.dart';
import 'package:jsaw_limited/bloc/allMedicalOfficerList_bloc.dart';
import 'package:flutter/material.dart';
import 'package:jsaw_limited/bloc/completeMedicalResponse_bloc.dart';
import 'package:jsaw_limited/model/allIncident_model.dart';
import 'package:jsaw_limited/model/allMedicalOfficerList_model.dart';
import 'package:jsaw_limited/model/completeMedicalResponse_model.dart';
import 'package:jsaw_limited/pages/medical_Officer_page.dart';
import 'package:jsaw_limited/state/allIncident_state.dart';
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

class AllIncidentPage extends StatefulWidget {
  const AllIncidentPage({super.key});

  @override
  State<AllIncidentPage> createState() => _AllIncidentPageState();
}

class _AllIncidentPageState extends State<AllIncidentPage> {

  late AllIncidentbloc allIncidentbloc;

  @override
  void initState() {
    super.initState();
    final incidentService = Provider.of<IncidentService>(context, listen: false);
    allIncidentbloc = AllIncidentbloc(incidentService);
    allIncidentbloc.initState("", "", "", "", "", "", "", 1);
  }

  int currentPage = 0;
  late String raisedSessionID = window.localStorage.getItem('kRaisedSessionID') ?? "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcDashboardBg1,
      body: Column(
        children: [
          Expanded(child: _buildAllIncidentList()),
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return BlocBuilder<AllIncidentbloc, AllIncidentState>(
      bloc: allIncidentbloc,
      builder: (_, state) {
        final isLoading = state.maybeWhen(loading: (_) => true, orElse: () => false);
        if (allIncidentbloc.totalElements == 0 && !isLoading) {
          return const SizedBox.shrink();
        }
        final cur = allIncidentbloc.currentPage;
        final total = allIncidentbloc.totalPages;
        final hasPrev = allIncidentbloc.hasPrevious && !isLoading;
        final hasNext = allIncidentbloc.hasNext && !isLoading;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: const BoxDecoration(
            color: kcWhite,
            border: Border(top: BorderSide(color: kcVeryLightGrey)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${allIncidentbloc.totalElements} record(s) • Page $cur of $total',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: kcLabelGrey,
                ),
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: hasPrev ? allIncidentbloc.previousPage : null,
                    icon: const Icon(Icons.chevron_left, size: 18),
                    label: const Text('Previous'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: kcvoilet,
                      side: const BorderSide(color: kcVeryLightGrey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: hasNext ? allIncidentbloc.nextPage : null,
                    icon: const Icon(Icons.chevron_right, size: 18),
                    label: const Text('Next'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: kcvoilet,
                      side: const BorderSide(color: kcVeryLightGrey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _buildAllIncidentList() {
    return BlocConsumer<AllIncidentbloc, AllIncidentState>(
      bloc: allIncidentbloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: (_) {
              return Center(
                child: Lottie.asset("assets/lottie/loading.json",
                    height: 80, width: 80),
              );
            },
            content: (model) =>
                model.isEmpty ? _buildEmpty('No incidents found') : _buildContent(model),
            success: (model) =>
                model.isEmpty ? _buildEmpty('No incidents found') : _buildContent(model),
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

  Widget _buildContent(List<AllIncidentModel> model) {
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
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
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
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ----- Image section -----
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 22.screenWidth,
                      height: 18.screenHeight,
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                        const SizedBox(height: 10),

                        // Injury type + Incident date
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  _buildIconBadge(
                                      Icons.medical_services_outlined,
                                      kcInfoInjury),
                                  const SizedBox(width: 8),
                                  _buildLabel("Injury :"),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      model[index].workInjury,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: kcValueDark,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                        const SizedBox(height: 12),

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
                                const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  model[index].descpOfIncident,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 2.screenWidth,
                                    color: kcValueDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
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
                                const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  model[index].medicalOfficerRemarks,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 2.screenWidth,
                                    color: kcValueDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildIconBadge(Icons.visibility_outlined,
                                kcInfoObservation),
                            const SizedBox(width: 8),
                            _buildLabel("Safety Remark :"),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  model[index].safetyRemarks,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 2.screenWidth,
                                    color: kcValueDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
          padding: EdgeInsets.symmetric(vertical: 0.4.screenHeight),
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
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color, size: 18),
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
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
        fontSize: 13,
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
          horizontal: 1.screenWidth, vertical: 0.3.screenHeight),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 3.5.screenHeight),
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
                    horizontal: 1.5.screenWidth,
                    vertical: 0.4.screenHeight,
                  ),
                  child: Text(
                    title,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 1.6.screenWidth,
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
