import 'package:flutter/material.dart';

import '../frosted_glass_container/frosted_glass_container.dart';

class GlassButton extends StatelessWidget {
  const GlassButton({required this.onPressed, this.text, this.icon, super.key});

  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child:
          // DecoratedBox(
          //   decoration: BoxDecoration(
          //     borderRadius: const BorderRadius.all(Radius.circular(16)),
          //     color: Colors.pink.darken(),
          //   ),
          //   child:
          FrostedGlassContainer(
            blupColor: Colors.black26,
            blurFilterSigmaX: 10,
            blurFilterSigmaY: 10,
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.6),
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.01, 0.03, 0.96, 0.99],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: text != null
                    ? Text(
                        text!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                      )
                    : Icon(icon, size: 24, color: Colors.white),
              ),
            ),
          ),
    );
  }
}
