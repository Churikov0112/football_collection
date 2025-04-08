import 'package:flutter/material.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/players/domain/models/player.dart';
import 'package:football_collection/features/players/presentation/blocs/all_players_bloc/all_players_bloc.dart';
import 'package:football_collection/features/players/presentation/blocs/saved_players_bloc/saved_players_bloc.dart';
import 'package:football_collection/services/toast/toast_service.dart';

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
                  decoration: InputDecoration(
                    hintText: "Cheat code here",
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: presenter.verifyCheatCode,
                        child: Text("Try"),
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
