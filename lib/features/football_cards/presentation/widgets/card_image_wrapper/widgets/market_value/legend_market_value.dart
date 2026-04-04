part of '../../card_image_wrapper.dart';

class _LegendMarketValue extends StatelessWidget {
  const _LegendMarketValue({required this.legend});

  final FootballLegendCardModel legend;

  @override
  Widget build(BuildContext context) {
    final value = legend.marketValue;
    if (value == null) {
      return const SizedBox.shrink();
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent,
        borderRadius: BorderRadius.only(topRight: .circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
        child: Text(
          beautifyTransferValue(value),
          style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
