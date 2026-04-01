part of '../../card_image_wrapper.dart';

enum _WhatToDoWithDuplicate { sellAll, sell, qr }

class _WhatToDoWithDuplicateBottomSheet extends StatelessWidget {
  const _WhatToDoWithDuplicateBottomSheet();

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
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(AppGlossary.whatToDoWithDuplicate.translate(), textAlign: TextAlign.center),
          ),
          SizedBox(height: 16),
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
                    context.pop(_WhatToDoWithDuplicate.sellAll);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
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
                    context.pop(_WhatToDoWithDuplicate.sell);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
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
                            Text("+ 1 🏆"),
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
                    context.pop(_WhatToDoWithDuplicate.qr);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
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
                            Icon(Icons.qr_code),
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
