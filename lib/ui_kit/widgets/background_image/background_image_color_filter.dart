import 'package:flutter/material.dart';

class BackgroundImageColorFilter extends StatelessWidget {
  const BackgroundImageColorFilter({
    required this.color,
    super.key,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color?.withAlpha(50),
        ),
      ),
    );
  }
}
