part of '../small_draft_football_player_card.dart';

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
        borderRadius: const BorderRadius.all(Radius.circular(16)),
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
