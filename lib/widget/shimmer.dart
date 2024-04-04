import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shapeBorder;

  ShimmerWidget.rectangular(
      {this.width = double.infinity, required this.height, super.key})
      : shapeBorder = RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        );

  const ShimmerWidget.circular(
      {required this.height,
      required this.width,
      this.shapeBorder = const CircleBorder(),
      super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[300]!,
            shape: shapeBorder,
          ),
        ),
      );
}

class ShimmerWidgetText extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final double? fontSize;

  const ShimmerWidgetText(
      {super.key, this.height, this.width, required this.text, this.fontSize});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        child: Container(
          width: width,
          height: height,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize ?? 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
