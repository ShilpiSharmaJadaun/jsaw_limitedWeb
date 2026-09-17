import 'dart:js_interop';
import 'dart:typed_data';
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:web/web.dart' as html;

/// Hands [bytes] to the browser as an .xlsx download (Flutter web).
void saveXlsxBytes(String fileName, Uint8List bytes) {
  final safeName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  final blob = html.Blob(
    [bytes.toJS].toJS,
    html.BlobPropertyBag(
        type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
  );
  final url = html.URL.createObjectURL(blob);
  html.HTMLAnchorElement()
    ..href = url
    ..setAttribute('download', safeName)
    ..click();
  html.URL.revokeObjectURL(url);
}

/// Hands [bytes] to the browser as a file download (Flutter web).
void savePdfBytes(String fileName, Uint8List bytes) {
  final safeName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  final blob = html.Blob(
    [bytes.toJS].toJS,
    html.BlobPropertyBag(type: 'application/pdf'),
  );
  final url = html.URL.createObjectURL(blob);
  html.HTMLAnchorElement()
    ..href = url
    ..setAttribute('download', safeName)
    ..click();
  html.URL.revokeObjectURL(url);
}

/// Shows [bytes] in an in-app PDF viewer dialog (browser's built-in viewer in
/// an iframe), so documents can be CHECKED without downloading (customer
/// request Sep-2026). A Download button in the header still saves the file.
Future<void> showPdfViewer(
    BuildContext context, String title, String fileName, Uint8List bytes) {
  final blob = html.Blob(
    [bytes.toJS].toJS,
    html.BlobPropertyBag(type: 'application/pdf'),
  );
  final url = html.URL.createObjectURL(blob);
  final viewType = 'pdf-viewer-${DateTime.now().microsecondsSinceEpoch}';
  ui_web.platformViewRegistry.registerViewFactory(viewType, (int _) {
    return html.HTMLIFrameElement()
      ..src = url
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%';
  });
  return showDialog(
    context: context,
    builder: (ctx) {
      final size = MediaQuery.of(ctx).size;
      return Dialog(
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: size.width * 0.9,
          height: size.height * 0.92,
          child: Column(
            children: [
              Container(
                color: const Color(0xFF604ADD),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf_outlined,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Download',
                      onPressed: () => savePdfBytes(fileName, bytes),
                      icon: const Icon(Icons.download_outlined,
                          color: Colors.white, size: 20),
                    ),
                    IconButton(
                      tooltip: 'Close',
                      onPressed: () => Navigator.of(ctx).pop(),
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 20),
                    ),
                  ],
                ),
              ),
              Expanded(child: HtmlElementView(viewType: viewType)),
            ],
          ),
        ),
      );
    },
  ).whenComplete(() => html.URL.revokeObjectURL(url));
}
