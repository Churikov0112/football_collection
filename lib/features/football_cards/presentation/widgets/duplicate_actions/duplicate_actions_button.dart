import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/services/localization/translator.dart';

import '../../../../../ui_kit/widgets/button/button.dart';
import '../../../../abstract/domain/models/card.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import 'duplicate_actions.dart';

class DuplicateActionsButton extends StatelessWidget {
  const DuplicateActionsButton({required this.card, super.key});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await openWhatToDoWithDuplicate(context: context, card: card);
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

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Button(
                onPressed: () async {
                  await openWhatToDoWithDuplicate(context: context, card: card);
                },
                text: AppGlossary.whatToDoWithDuplicate.translate(),
              ),
            ],
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
