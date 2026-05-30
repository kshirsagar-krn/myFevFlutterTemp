import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/constant/app_color.dart';

class CustomShimmer extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final Widget? shimmerSkeleton;
  final Color? baseColor;
  final Color? highlightColor;

  const CustomShimmer({
    super.key,
    required this.isLoading,
    required this.child,
    this.shimmerSkeleton,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Shimmer.fromColors(
      // Uses your AppColors or defaults to standard grey
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[100]!,
      // If no specific skeleton is provided, it shimmers the actual child
      child: shimmerSkeleton ?? child,
    );
  }
}

class ShimmerCartTile extends StatelessWidget {
  final double isHeight;
  final double isWidth;
  final double isRadius;
  final Color? baseColor;
  final Color? highlightColor;
  const ShimmerCartTile({
    super.key,
    this.isHeight = 20,
    this.isWidth = 20,
    this.isRadius = 10,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      baseColor: baseColor ?? AppColor.lightBorder,
      highlightColor: highlightColor,
      isLoading: true,
      child: Container(
        height: isHeight,
        width: isWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isRadius),
          color: AppColor.lightBorder,
        ),
      ),
    );
  }
}
