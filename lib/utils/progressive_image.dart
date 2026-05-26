import 'package:flutter/material.dart';

import 'app_color.dart';
import 'image_lightbox.dart';

class ProgressiveImage extends StatelessWidget {
  const ProgressiveImage({
    super.key,
    required this.highUrl,
    this.lowUrl,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.expandable = true,
    this.showExpandHint = true,
  });

  final String highUrl;
  final String? lowUrl;
  final BoxFit fit;
  final Alignment alignment;
  final double? width;
  final double? height;

  /// When true (default), tapping the image opens it in a full-screen
  /// pinch-zoomable lightbox. Set to false to keep the image static.
  final bool expandable;

  /// When true (default), a small "Expand" pill is overlaid on the image's
  /// top-right corner so users discover the tap target.
  final bool showExpandHint;

  Widget _error(BuildContext _, Object __, StackTrace? ___) => Container(
        width: width,
        height: height,
        color: Colors.grey.shade100,
        alignment: Alignment.center,
        child: Icon(Icons.broken_image_outlined,
            color: Colors.grey.shade400, size: 48),
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

    final body = SizedBox(
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
          if (expandable && showExpandHint && highUrl.isNotEmpty)
            const Positioned(
              right: 6,
              top: 6,
              child: _ExpandPill(),
            ),
        ],
      ),
    );

    if (!expandable || highUrl.isEmpty) return body;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          showImageLightbox(context, highUrl: highUrl, lowUrl: lowUrl),
      child: body,
    );
  }
}

class _ExpandPill extends StatelessWidget {
  const _ExpandPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.zoom_in, size: 11, color: kcWhite),
          SizedBox(width: 3),
          Text(
            'Expand',
            style: TextStyle(
                color: kcWhite, fontSize: 10, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
