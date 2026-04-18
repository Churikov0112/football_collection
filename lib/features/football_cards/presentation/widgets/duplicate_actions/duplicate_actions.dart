import 'package:flutter/material.dart' show Icons, showModalBottomSheet;
import 'package:flutter/widgets.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:go_router/go_router.dart';

import '../../../../../services/toast/toast_service.dart';
import '../../../../abstract/domain/models/card.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../../mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import '../card_image_wrapper/card_image_wrapper.dart';

Future<void> openWhatToDoWithDuplicate({
  required BuildContext context,
  required CardModel card,
  VoidCallback? onSell,
  VoidCallback? onSellAll,
  VoidCallback? onShare,
}) async {
  final whatToDo = await showModalBottomSheet<WhatToDoWithDuplicate>(
    context: context,
    builder: (context) => const DuplicateActionsWidget(),
  );

  if (whatToDo == WhatToDoWithDuplicate.qr) {
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
  if (whatToDo == WhatToDoWithDuplicate.sell) {
    onSell?.call();
    getIt.get<SavedCardsBloc>().add(SavedCardsEventRemove(cardId: card.cardId));
    getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: 1));
    ToastService.showToast(title: "${AppGlossary.balanceIncreased.translate()} + 1 🏆", seconds: 2);
  }

  if (whatToDo == WhatToDoWithDuplicate.sellAll) {
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
}

enum WhatToDoWithDuplicate { sellAll, sell, qr }

class DuplicateActionsWidget extends StatelessWidget {
  const DuplicateActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final savedCardsIds = getIt.get<SavedCardsBloc>().state.savedCardsIds ?? [];
    final savedCardsIdsSingle = [];
    final duplicates = [];
    for (final savedCardId in savedCardsIds) {
      if (!savedCardsIdsSingle.contains(savedCardId)) {
        savedCardsIdsSingle.add(savedCardId);
      } else {
        duplicates.add(savedCardId);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(AppGlossary.whatToDoWithDuplicate.translate(), textAlign: TextAlign.center),
          ),
          const SizedBox(height: 16),
          // Row(
          //   children: [
          //     Expanded(
          //       child: TextButton(
          //         onPressed: () {
          //           context.pop(false);
          //         },
          //         child: Text(AppGlossary.cancel.translate()),
          //       ),
          //     ),
          //     SizedBox(width: 12),
          //     Expanded(
          //       child: FilledButton(
          //         onPressed: () {
          //           context.pop(true);
          //         },
          //         child: Text(AppGlossary.confirm.translate()),
          //       ),
          //     ),
          //   ],
          // ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.pop(WhatToDoWithDuplicate.sellAll);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      border: Border.all(),
                    ),
                    child: SizedBox(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            Text("+ ${duplicates.length} 🏆"),
                            const SizedBox(height: 16),
                            Text(AppGlossary.sellAllDuplicates.translate(), textAlign: TextAlign.center),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.pop(WhatToDoWithDuplicate.sell);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      border: Border.all(),
                    ),
                    child: SizedBox(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            const Text("+ 1 🏆"),
                            const SizedBox(height: 16),
                            Text(AppGlossary.sell.translate(), textAlign: TextAlign.center),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.pop(WhatToDoWithDuplicate.qr);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      border: Border.all(),
                    ),
                    child: SizedBox(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            const Icon(Icons.qr_code),
                            const SizedBox(height: 16),
                            Text(AppGlossary.shareViaQr.translate(), textAlign: TextAlign.center),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: mq.padding.bottom + 16),
        ],
      ),
    );
  }
}
