import 'dart:ui' hide window;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/allMedicalOfficerList_bloc.dart';
import 'package:flutter/material.dart';
import 'package:jsaw_limited/bloc/downloadPdf_bloc.dart';
import 'package:jsaw_limited/bloc/safetyRemarkList_bloc.dart';
import 'package:jsaw_limited/model/allMedicalOfficerList_model.dart';
import 'package:jsaw_limited/model/safetyRemarkList_model.dart';
import 'package:jsaw_limited/pages/medical_Officer_page.dart';
import 'package:jsaw_limited/pages/safety_remark_page.dart';
import 'package:jsaw_limited/state/allMedicalOfficerList_state.dart';
import 'package:jsaw_limited/state/downloadPdf_state.dart';
import 'package:jsaw_limited/state/safetyRemarkList_state.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:js_interop';
import 'package:web/web.dart' show window;
import '../bloc/all_filter_observation_bloc.dart';
import '../service/incident_service.dart';
import '../utils/progressive_image.dart';
import '../utils/app_color.dart';
import 'package:web/web.dart' as html;

class SafetyRemarkPendingApprovalPage extends StatefulWidget {
  const SafetyRemarkPendingApprovalPage({super.key});

  @override
  State<SafetyRemarkPendingApprovalPage> createState() => _SafetyRemarkPendingApprovalPageState();
}

class _SafetyRemarkPendingApprovalPageState extends State<SafetyRemarkPendingApprovalPage> {

  late SafetyRemarkListBloc safetyRemarkListBloc;
  late DownloadPdfBloc downloadPdfBloc;
  late final AllFilterObservationBloc allFilterObservationBloc;

  @override
  void initState() {
    super.initState();
    final incidentService = Provider.of<IncidentService>(context, listen: false);
    safetyRemarkListBloc = SafetyRemarkListBloc(incidentService);
    safetyRemarkListBloc.initState();
    downloadPdfBloc = DownloadPdfBloc(incidentService);
  }

  int currentPage = 0;
  late String raisedSessionID = window.localStorage.getItem('kRaisedSessionID') ?? "";

  // When set, the Safety Remark form is shown INLINE (inside the app shell)
  // instead of being pushed as a separate full-screen route.
  SafetyRemarkListModel? _selectedModel;

  @override
  Widget build(BuildContext context) {
    if (_selectedModel != null) {
      final selected = _selectedModel!;
      return SafetyRemarkPage(
        safetyRemarkListModel: selected,
        onClose: (refresh) {
          setState(() => _selectedModel = null);
          if (refresh) {
            safetyRemarkListBloc
                .removeByIncidentUniqueId(selected.incidentUniqueId);
          }
        },
      );
    }
    return Scaffold(
      backgroundColor: kcDashboardBg1,
      body: _buildAllIncidentList(),
    );
  }

  _buildAllIncidentList() {
    return BlocConsumer<SafetyRemarkListBloc, SafetyRemarkListState>(
      bloc: safetyRemarkListBloc,
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            loading: (_) {
              return Center(
                child: Lottie.asset("assets/lottie/loading.json",
                    height: 80, width: 80),
              );
            },
            content: _buildContent,
            success: _buildContent,
            failed: (form, __) => _buildContent(form));
      },
    );
  }

  Widget _buildContent(List<SafetyRemarkListModel> model) {
    return BlocListener<DownloadPdfBloc, DownloadPdfState>(
      bloc: downloadPdfBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (uniqueId, bytes) {
            final safeName =
            uniqueId.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
            final blob = html.Blob(
              [bytes.toJS].toJS,
              html.BlobPropertyBag(type: 'application/pdf'),
            );
            final url = html.URL.createObjectURL(blob);
            html.HTMLAnchorElement()
              ..href = url
              ..setAttribute('download', '$safeName.pdf')
              ..click();
            html.URL.revokeObjectURL(url);
          },
          failed: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                duration: const Duration(seconds: 3),
              ),
            );
          },
          orElse: () {},
        );
      },
      child: Container(
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
                              BlocBuilder<DownloadPdfBloc, DownloadPdfState>(
                                bloc: downloadPdfBloc,
                                builder: (context, downloadState) {
                                  final uid = model[index].incidentUniqueId;
                                  final isDownloading =
                                  downloadState.maybeWhen(
                                    loading: (loadingUid) => loadingUid == uid,
                                    orElse: () => false,
                                  );
                                  return IconButton(
                                    tooltip: isDownloading
                                        ? 'Downloading…'
                                        : 'Download PDF',
                                    onPressed: isDownloading
                                        ? null
                                        : () => downloadPdfBloc
                                        .downloadByUid(uid),
                                    icon: isDownloading
                                        ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                        AlwaysStoppedAnimation(
                                            kcPdfIconRed),
                                      ),
                                    )
                                        : const Icon(
                                      Icons.cloud_download_outlined,
                                      color: kcPdfIconRed,
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() => _selectedModel = model[index]);
                                  },
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_sharp)),
                            ],
                          ),
                          const SizedBox(height: 4),



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