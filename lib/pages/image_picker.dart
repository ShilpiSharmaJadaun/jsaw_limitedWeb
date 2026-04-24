import 'package:flutter/material.dart';
import 'dart:io' show File; // For mobile platforms
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  final Function(dynamic, [Uint8List?]) onImagePicked;

  const ImagePickerPage({required this.onImagePicked, Key? key}) : super(key: key);

  @override
  State<ImagePickerPage> createState() => ImagePickerPageState(); // Make this public
}

class ImagePickerPageState extends State<ImagePickerPage> { // No underscore here
  dynamic _image;
  Uint8List? _webImageBytes;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (pickedImage != null) {
        setState(() {
          _isLoading = true;
        });

        if (kIsWeb) {
          final bytes = await pickedImage.readAsBytes();
          setState(() {
            _image = pickedImage.path;
            _webImageBytes = bytes;
          });
          widget.onImagePicked(_image, _webImageBytes);
        } else {
          setState(() {
            _image = File(pickedImage.path);
          });
          widget.onImagePicked(_image);
        }
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void clearImage() {
    setState(() {
      _image = null;
      _webImageBytes = null;
    });
    Future.delayed(Duration.zero, () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _isLoading
            ? Padding(
          padding: const EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        )
            : (_image != null || _webImageBytes != null)
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: kIsWeb
              ? (_webImageBytes != null
              ? Image.memory(
            _webImageBytes!,
            width: 1000,
            height: 300,
            fit: BoxFit.contain,
          )
              : Container())
              : (_image != null
              ? Image.file(
            _image,
            width: 1000,
            height: 300,
            fit: BoxFit.contain,
          )
              : Container()),
        )
            : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 300,
            width: 1000,
            color: Colors.grey,
            child: Center(
              child: Text(
                "Select Image",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.photo_library_outlined, size: 20, color: Color(0xFF8B5CF6)),
          label: const Text(
            "Open Gallery",
            style: TextStyle(
              color: Color(0xFF8B5CF6),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEDE9FE),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}

