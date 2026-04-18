import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({required this.onPressed, this.text, this.icon, this.primary = true, super.key});

  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child:
          // DecoratedBox(
          //   decoration: BoxDecoration(
          //     borderRadius: const BorderRadius.all(Radius.circular(16)),
          //     color: Colors.pink.darken(),
          //   ),
          //   child:
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const .all(.circular(16)),
              color: primary ? theme.colorScheme.primary : Colors.grey,
            ),
            child: Padding(
              padding: const .all(16),
              child: Center(
                child: text != null
                    ? Text(
                        text!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: .bold,
                          fontSize: 16,
                          color: primary ? Colors.black : Colors.white,
                        ),
                      )
                    : Icon(icon, size: 24, color: primary ? Colors.black : Colors.white),
              ),
            ),
          ),
    );
  }
}
