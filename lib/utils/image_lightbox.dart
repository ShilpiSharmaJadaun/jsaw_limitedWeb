import 'package:flutter/material.dart';

import 'app_color.dart';

/// Opens the given network image in a full-screen, pinch-zoomable dialog.
/// Pass [lowUrl] for a progressive blur-up placeholder while [highUrl] loads.
void showImageLightbox(
  BuildContext context, {
  required String highUrl,
  String? lowUrl,
}) {
  if (highUrl.isEmpty) return;
  final hasLow = (lowUrl ?? '').isNotEmpty;

  final Widget content = hasLow
      ? FadeInImage(
          placeholder: NetworkImage(lowUrl!),
          image: NetworkImage(highUrl),
          fadeInDuration: const Duration(milliseconds: 300),
          fadeOutDuration: const Duration(milliseconds: 300),
          fit: BoxFit.contain,
          imageErrorBuilder: (_, __, ___) => const Padding(
            padding: EdgeInsets.all(40),
            child: Text('Image unavailable',
                style: TextStyle(color: Colors.white)),
          ),
          placeholderErrorBuilder: (_, __, ___) => const Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(),
          ),
        )
      : Image.network(
          highUrl,
          fit: BoxFit.contain,
          loadingBuilder: (ctx, child, progress) {
            if (progress == null) return child;
            return const Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(),
            );
          },
          errorBuilder: (_, __, ___) => const Padding(
            padding: EdgeInsets.all(40),
            child: Text('Image unavailable',
                style: TextStyle(color: Colors.white)),
          ),
        );

  showDialog<void>(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          InteractiveViewer(
            minScale: 0.5,
            maxScale: 4,
            child: Center(child: content),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: Colors.black54,
              shape: const CircleBorder(),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Drop-in wrapper that makes any child tappable to open the image lightbox.
class ExpandableImage extends StatelessWidget {
  final String highUrl;
  final String? lowUrl;
  final Widget child;
  final bool showHint;

  const ExpandableImage({
    super.key,
    required this.highUrl,
    required this.child,
    this.lowUrl,
    this.showHint = true,
  });

  @override
  Widget build(BuildContext context) {
    if (highUrl.isEmpty) return child;
    return GestureDetector(
      onTap: () =>
          showImageLightbox(context, highUrl: highUrl, lowUrl: lowUrl),
      child: Stack(
        children: [
          child,
          if (showHint)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                          color: kcWhite,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
