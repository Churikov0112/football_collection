part of "../../card_widget_wrapper.dart";

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.card, required this.onSell, required this.onSellAll, required this.onShare});

  final CardModel card;

  final VoidCallback? onSell;
  final VoidCallback? onSellAll;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await openWhatToDoWithDuplicate(
          context: context,
          card: card,
          onSell: onSell,
          onSellAll: onSellAll,
          onShare: onShare,
        );
      },
      child: BlocBuilder<SavedCardsBloc, SavedCardsState>(
        bloc: getIt.get(),
        builder: (context, savedCardsState) {
          final savedCardsIds = savedCardsState.savedCardsIds ?? <String>[];
          int count = 0;
          for (final savedCardId in savedCardsIds) {
            if (card.cardId == savedCardId) {
              count++;
            }
          }

          if (count < 2) {
            return const SizedBox.shrink();
          }

          return DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.lightGreenAccent,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
            ),
            child: RotatedBox(
              quarterTurns: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Text(
                  "x$count",
                  style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
          // return DecoratedBox(
          //   decoration: BoxDecoration(
          //     color: Colors.lightGreenAccent,
          //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22)),
          //   ),

          //   child: SizedBox.square(
          //     dimension: 30,
          //     child: Center(
          //       child: Text(
          //         "x$count",
          //         style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
