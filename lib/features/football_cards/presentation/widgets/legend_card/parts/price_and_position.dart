part of '../football_legend_card.dart';

class _PriceAndPosition extends StatelessWidget {
  const _PriceAndPosition({required this.legend, required this.marketValueVisibility});

  final FootballLegendCardModel legend;
  final CardElementVisibility marketValueVisibility;

  @override
  Widget build(BuildContext context) {
    final positionBackgroundColor = footballPlayerPositionToColor(legend.position);
    final shortPosition = footballPlayerPositionToShort(legend.position) ?? legend.position;

    return Wrap(
      spacing: 4,
      children: [
        if (legend.marketValue != null && marketValueVisibility != .none)
          _RoundedContainer(text: marketValueVisibility == .quest ? "?" : beautifyTransferValue(legend.marketValue!)),
        if (shortPosition != null)
          _RoundedContainer(
            text: shortPosition,
            backgroundColor: positionBackgroundColor,
            textColor: positionBackgroundColor != null ? Colors.white : null,
            borderColor: positionBackgroundColor != null ? Colors.white : null, // positionBackgroundColor,
          ),
      ],
    );
  }
}
