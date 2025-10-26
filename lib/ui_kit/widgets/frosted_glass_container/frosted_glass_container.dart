// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/widgets.dart';

class FrostedGlassContainer extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final double blurFilterSigmaX;
  final double blurFilterSigmaY;
  final Color blupColor;
  final Gradient? gradient;

  const FrostedGlassContainer({
    required this.blupColor,
    required this.child,
    this.borderRadius = BorderRadius.zero,
    this.blurFilterSigmaX = 10.0,
    this.blurFilterSigmaY = 10.0,
    this.gradient,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final result = DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: gradient != null ? const EdgeInsets.all(1.5) : EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurFilterSigmaX,
              sigmaY: blurFilterSigmaY,
              tileMode: TileMode.repeated,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: blupColor,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );

    return result;
  }
}
