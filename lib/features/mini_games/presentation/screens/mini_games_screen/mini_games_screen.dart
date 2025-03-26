import 'dart:math';

import 'package:flutter/material.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:go_router/go_router.dart';

part 'mini_games_screen_presenter.dart';
part 'widgets/mini_games_list.dart';

class MiniGamesScreen extends StatelessWidget {
  const MiniGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return MiniGamesScreenPresenter(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mini-Games"),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(),
          child: Column(
            children: [
              const _MiniGamesList(),
            ],
          ),
        ),
      ),
    );
  }
}
