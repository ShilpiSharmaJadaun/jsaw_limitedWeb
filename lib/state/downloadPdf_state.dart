import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'downloadPdf_state.freezed.dart';

@freezed
class DownloadPdfState with _$DownloadPdfState {
  const factory DownloadPdfState.idle() = _Idle;
  const factory DownloadPdfState.loading(String uniqueId) = _Loading;
  const factory DownloadPdfState.success(String uniqueId, Uint8List bytes) =
      _Success;
  const factory DownloadPdfState.failed(String uniqueId, String message) =
      _Failed;

  factory DownloadPdfState.initial() => const DownloadPdfState.idle();
}
