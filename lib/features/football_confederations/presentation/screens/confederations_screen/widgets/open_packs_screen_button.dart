import 'package:flutter/material.dart';
import 'package:football_collection/ui_kit/effects/touchable_scale.dart';
import 'package:football_collection/ui_kit/widgets/glass_button/glass_button.dart';

import '../../../../../../services/localization/translator.dart';

class OpenPacksScreenButton extends StatelessWidget {
  const OpenPacksScreenButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Translator(
      termin: AppGlossary.openPack,
      builder: (value) => GlassButton(onPressed: onPressed, text: value),
    );
    return TouchableScale(
      onPressed: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.style),
              const SizedBox(width: 10),
              Translator(
                termin: AppGlossary.openPack,
                builder: (value) => Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
