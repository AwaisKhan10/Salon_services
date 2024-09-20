import 'package:flutter/material.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class CircleImagePlaceholder extends StatelessWidget {
  const CircleImagePlaceholder(
      {Key? key, this.backgroundImage, required this.radius})
      : super(key: key);
  final ImageProvider<Object>? backgroundImage;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: StyldColors.black,
      foregroundColor: StyldColors.black,
      backgroundImage: backgroundImage,
      radius: radius,
    );
  }
}
