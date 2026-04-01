part of "../../card_image_wrapper.dart";

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
        final whatToDo = await showModalBottomSheet<_WhatToDoWithDuplicate>(
          context: context,
          builder: (context) => _WhatToDoWithDuplicateBottomSheet(),
        );

        if (whatToDo == _WhatToDoWithDuplicate.qr) {
          onShare?.call();
          await showModalBottomSheet(
            context: context,
            builder: (context) => CardQrBottomSheet(card: card),
          ).timeout(
            const Duration(milliseconds: 300),
            onTimeout: () async {
              getIt.get<SavedCardsBloc>().add(SavedCardsEventRemove(cardId: card.cardId));
              return true;
            },
          );
        }
        if (whatToDo == _WhatToDoWithDuplicate.sell) {
          onSell?.call();
          getIt.get<SavedCardsBloc>().add(SavedCardsEventRemove(cardId: card.cardId));
          getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: 1));
          ToastService.showToast(title: "${AppGlossary.balanceIncreased.translate()} + 1 🏆", seconds: 2);
        }

        if (whatToDo == _WhatToDoWithDuplicate.sellAll) {
          final savedCardsIds = getIt.get<SavedCardsBloc>().state.savedCardsIds ?? <String>[];
          final savedCardsIdsSingle = <String>[];
          final duplicates = <String>[];
          for (final savedCardId in savedCardsIds) {
            if (!savedCardsIdsSingle.contains(savedCardId)) {
              savedCardsIdsSingle.add(savedCardId);
            } else {
              duplicates.add(savedCardId);
            }
          }
          getIt.get<SavedCardsBloc>().add(SavedCardsEventRemoveAll(cardIds: duplicates));
          getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: duplicates.length));
          ToastService.showToast(
            title: "${AppGlossary.balanceIncreased.translate()} + ${duplicates.length} 🏆",
            seconds: 2,
          );
          onSellAll?.call();
        }
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

          return Container(
            height: 64,
            width: 64,
            color: Colors.green,
            child: Center(child: Text("x$count")),
          );
        },
      ),
    );
  }
}
