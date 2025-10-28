import 'package:flutter/material.dart';
import 'package:football_collection/features/draft/domain/models/ratings.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../services/navigation/bottom_sheet_controller/bottom_sheet_controller.dart';
import '../../../../../../ui_kit/effects/touchable_scale.dart';
import '../../../../../football_players/domain/models/player.dart';
import '../../../../../football_players/presentation/screens/football_player_screen/football_player_screen.dart';
import '../../../../domain/models/player.dart';
import '../../../../domain/models/position.dart';
import '../../../../domain/models/position_weights.dart';
import '../../../../domain/models/stats.dart';
import '../draft_screen/widgets/player_card/draft_football_player_card.dart';

part 'draft_players_screen_presenter.dart';
part 'widgets/draft_players_list.dart';

class DraftPlayersScreenArguments {
  final FootballPlayerAbstractPosition position;
  final List<String> playersIdsToExclude;
  final List<FootballPlayerCardModel> draftPlayers;

  DraftPlayersScreenArguments({required this.playersIdsToExclude, required this.position, required this.draftPlayers});
}

class DraftPlayersScreen extends StatelessWidget {
  final DraftPlayersScreenArguments args;

  const DraftPlayersScreen({required this.args, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const playerPhotoAspectRatio = 4 / 3; // height / width
    final playerPhotoWidth = size.width * 0.3;
    final playerPhotoHeight = playerPhotoWidth * playerPhotoAspectRatio;

    return DraftPlayersScreenPresenter(
      args: args,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 26, 26, 26)),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [SizedBox(height: playerPhotoHeight + 60, child: const _DraftPlayersList())],
          ),
        ),
      ),
    );
  }
}
