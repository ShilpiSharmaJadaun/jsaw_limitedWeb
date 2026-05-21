import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsaw_limited/bloc/compliance_bloc.dart';
import 'package:jsaw_limited/state/compliance_state.dart';
import 'package:jsaw_limited/utils/page_header.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:provider/provider.dart';
import 'package:web/web.dart' as html;
import '../service/observation_service.dart';
import '../utils/app_color.dart';
import 'image_picker.dart';

class CompliancePageBottomSheet extends StatefulWidget {
  const CompliancePageBottomSheet({
    super.key,
    required this.unqIdnNo,
    required this.raisedByUnqID,
  });

  final String unqIdnNo;
  final String raisedByUnqID;

  @override
  State<CompliancePageBottomSheet> createState() =>
      _CompliancePageBottomSheetState();
}

class _CompliancePageBottomSheetState extends State<CompliancePageBottomSheet> {
  TextEditingController observationController = TextEditingController();
  TextEditingController actionTakenController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  late ComplianceBloc complianceBloc;

  @override
  void initState() {
    super.initState();
    final observationService =
    Provider.of<ObservationService>(context, listen: false);
    complianceBloc = ComplianceBloc(observationService);
    // Ensure focus is reset when the page is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PageHeader("Compliance"),
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: SizedBox(
                        width: 400,
                        height: 400,
                        child: ImagePickerPage(onImagePicked: _onImagePicked),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/responsibility.png",
                          scale: 20,
                        ),
                        _buildHeadingText("Action Taken"),
                        _buildActionTakenTextFiled(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/responsibility.png",
                          scale: 20,
                        ),
                        _buildHeadingText("Remark"),
                        _buildRemarkTextFiled(),
                      ],
                    ),
                  ),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Uint8List? _selectedImage;

  void _onImagePicked(dynamic image, [Uint8List? webImageBytes]) {
    setState(() {
      _selectedImage = webImageBytes;
    });
  }

  Widget _buildObservationTextFiled() {
    return SizedBox(
      width: 400,
      child: TextField(
        controller: observationController,
        textAlign: TextAlign.start,
        maxLines: null,
        minLines: 1,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: kcvoilet),
        decoration: InputDecoration(
          hintText: "Write Observation",
          contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
          hintStyle: const TextStyle(fontSize: 12, color: kcMediumGrey),
          fillColor: Colors.transparent,
          filled: true,
          border: _border(),
          focusedBorder: _border(),
          enabledBorder: _border(),
        ),
      ),
    );
  }

  Widget _buildActionTakenTextFiled() {
    return SizedBox(
      width: 400,
      child: TextField(
        controller: actionTakenController,
        textAlign: TextAlign.start,
        maxLines: null,
        minLines: 1,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: kcvoilet),
        decoration: InputDecoration(
          hintText: "Write Action Taken",
          contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
          hintStyle: const TextStyle(fontSize: 12, color: kcMediumGrey),
          fillColor: Colors.transparent,
          filled: true,
          border: _border(),
          focusedBorder: _border(),
          enabledBorder: _border(),
        ),
      ),
    );
  }

  Widget _buildRemarkTextFiled() {
    return SizedBox(
      width: 400,
      child: TextField(
        controller: remarkController,
        textAlign: TextAlign.start,
        maxLines: null,
        minLines: 1,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: kcvoilet),
        decoration: InputDecoration(
          hintText: "Write Remark",
          contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
          hintStyle: const TextStyle(fontSize: 12, color: kcMediumGrey),
          fillColor: Colors.transparent,
          filled: true,
          border: _border(),
          focusedBorder: _border(),
          enabledBorder: _border(),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<ComplianceBloc, ComplianceState>(
      bloc: complianceBloc,
      listener: (_, state) {
        state.maybeWhen(
          success: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message ?? "Data Saved Successfully"),
            ));
            Navigator.of(context).pop(); // Close the bottom sheet after success
          },
          failed: (_, message) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: (_) {
            return const Center(child: CircularProgressIndicator());
          },
          orElse: () {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_selectedImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select an image")),
                      );
                    } else {
                      // Call the API function
                      complianceBloc.saveObservation(
                        _selectedImage!,
                        widget.unqIdnNo,
                        observationController.text,
                        actionTakenController.text,
                        "COMPLIANCE",
                        remarkController.text,
                        html.window.localStorage.getItem('kEmployeeCode')!,
                        html.window.localStorage.getItem('kEmployeename')!,
                        html.window.localStorage.getItem('kUserEmail')!,
                        widget.raisedByUnqID,
                      );
                      clearFormValues();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: kcobservationgreen),
                  child: const Text("Send Compliance", style: TextStyle(color: kcWhite),),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void clearFormValues() {
    // Reset ValueNotifier values
    _selectedImage?.clear();
    observationController.clear();
    actionTakenController.clear();
    remarkController.clear();
  }

  Widget _buildHeadingText(String title) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 100,
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }

  OutlineInputBorder _border() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: kcDarkGreyColor, width: 1.5),
  );
}
