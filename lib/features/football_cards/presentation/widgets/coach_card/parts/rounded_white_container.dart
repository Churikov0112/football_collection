part of '../football_coach_card.dart';

class _RoundedContainer extends StatelessWidget {
  const _RoundedContainer({
    required this.text,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.borderColor,
  });

  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: borderColor ?? Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: textColor),
        ),
      ),
    );
  }
}

class _FootRoundedContainer extends StatelessWidget {
  const _FootRoundedContainer({required this.text});

  final String text;

  AppGlossary? _footTermin(String? text) {
    if (text == null) return null;
    switch (text) {
      case "left":
        return AppGlossary.footLeft;
      case "right":
        return AppGlossary.footRight;
      case "both":
        return AppGlossary.footBoth;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final termin = _footTermin(text);
    if (termin == null) return const SizedBox.shrink();

    return Translator(
      termin: termin,
      builder: (value) => _RoundedContainer(text: value),
    );
  }
}
