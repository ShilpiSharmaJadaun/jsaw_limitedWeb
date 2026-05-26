import 'package:flutter/material.dart';

class ProgressiveImage extends StatelessWidget {
  const ProgressiveImage({
    super.key,
    required this.highUrl,
    this.lowUrl,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.width,
    this.height,
  });

  final String highUrl;
  final String? lowUrl;
  final BoxFit fit;
  final Alignment alignment;
  final double? width;
  final double? height;

  Widget _error(BuildContext _, Object __, StackTrace? ___) => Container(
        width: width,
        height: height,
        color: Colors.grey.shade100,
        alignment: Alignment.center,
        child: Icon(Icons.broken_image_outlined,
            color: Colors.grey.shade400, size: 48),
      );

  Widget _spinner() => Container(
        width: width,
        height: height,
        color: Colors.grey.shade100,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(strokeWidth: 2),
      );

  @override
  Widget build(BuildContext context) {
    final hasLow = (lowUrl ?? '').isNotEmpty;

    final Widget image = hasLow
        ? FadeInImage(
            placeholder: NetworkImage(lowUrl!),
            image: NetworkImage(highUrl),
            fadeInDuration: const Duration(milliseconds: 300),
            fadeOutDuration: const Duration(milliseconds: 300),
            fit: fit,
            alignment: alignment,
            width: width,
            height: height,
            imageErrorBuilder: _error,
            placeholderErrorBuilder: (_, __, ___) => const SizedBox.shrink(),
          )
        : Image.network(
            highUrl,
            fit: fit,
            alignment: alignment,
            width: width,
            height: height,
            loadingBuilder: (ctx, child, progress) {
              if (progress == null) return child;
              return const SizedBox.shrink();
            },
            errorBuilder: _error,
          );

    // Always-visible spinner beneath the image so callers see a loading
    // indicator while the network image is being fetched. The image is
    // painted on top and hides the spinner once it arrives.
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.grey.shade100,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
          image,
        ],
      ),
    );
  }
}
