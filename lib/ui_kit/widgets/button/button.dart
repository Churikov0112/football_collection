import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({required this.onPressed, this.text, this.icon, super.key});

  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;

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
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: theme.colorScheme.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: text != null
                    ? Text(
                        text!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                      )
                    : Icon(icon, size: 24, color: Colors.black),
              ),
            ),
          ),
    );
  }
}
