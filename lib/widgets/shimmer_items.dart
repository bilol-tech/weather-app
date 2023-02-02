import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItems extends StatelessWidget {
  final double height, width;
  const ShimmerItems({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
          child: Container(
            width: width,
            height: height,
            color: Colors.grey,
          ),
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100),
    );
  }
}
