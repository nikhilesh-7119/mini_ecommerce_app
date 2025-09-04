import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//to show the big image as well as using cached network image
class DetailImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  const DetailImage({required this.imageUrl, required this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        child: AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
