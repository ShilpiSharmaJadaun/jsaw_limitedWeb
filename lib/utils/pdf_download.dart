import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as html;

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
