import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SharedNetworkImageWidget extends StatelessWidget {

  final String imageUrl;
  final BoxFit? fit;
  const SharedNetworkImageWidget({
    required this.imageUrl,
    this.fit,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      fadeInCurve: Curves.easeIn,
      cacheKey: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const Center(child: CupertinoActivityIndicator(),),
      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error_outline),),
    );
  }
}
