import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
// import 'package:football_collection/features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';

import '../../../../../services/log/log_service.dart';
import '../../../../football_cards/domain/cards/player_card.dart';
import '../../../../football_cards/presentation/blocs/all_football_players_bloc/all_football_players_bloc.dart';
import '../../../../mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';

part 'enter_cheat_code_screen_presenter.dart';

class EnterCheatCodeScreen extends StatelessWidget {
  const EnterCheatCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return EnterCheatCodeScreenPresenter(
      child: Builder(
        builder: (context) {
          final presenter = EnterCheatCodeScreenPresenter.of(context);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16),
                TextField(
                  controller: presenter.cheatCodeTextEditingController,
                  decoration: InputDecoration(hintText: AppGlossary.cheatCodeHere.translate()),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: presenter.verifyCheatCode,
                        child: Text(AppGlossary.confirm.translate()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: mq.viewInsets.bottom + 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
