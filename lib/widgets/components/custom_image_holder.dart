import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../utils/color.dart';

class CustomImageHolder extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final bool isCircle;
  final Widget errorWidget;

  const CustomImageHolder(
      {Key? key,
      required this.imageUrl,
      required this.height,
      required this.width,
      this.isCircle = true,
      required this.errorWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: BorderRadius.circular(isCircle ? 00 : 16),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => const SizedBox(
        height: 32,
        width: 32,
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
      errorWidget: (context, url, error) => errorWidget,
    );
  }
}
