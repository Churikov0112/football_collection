import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fc_26_england/features/abstract/presentation/utils/ratings.dart';
import 'package:fc_26_england/features/draft/presentation/blocs/draft_tournament_bloc/draft_tournament_bloc.dart';
import 'package:fc_26_england/features/football_players/domain/models/player_card.dart';
import 'package:fc_26_england/features/football_players/presentation/screens/football_player_screen/football_player_screen.dart';
import 'package:fc_26_england/ui_kit/colors/colors.dart';
import 'package:fc_26_england/ui_kit/widgets/glass_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../di/di.dart';
import '../../../../../../services/localization/translator.dart';
import '../../../../../../services/navigation/bottom_sheet_controller/bottom_sheet_controller.dart';
import '../../../../../../services/navigation/go_router/navigation.dart';
import '../../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../../../football_competitions/presentation/blocs/all_football_competitions_bloc/all_football_competitions_bloc.dart';
import '../../../../../football_players/domain/models/position.dart';
import '../../../../../football_players/presentation/blocs/all_football_players_bloc/all_football_players_bloc.dart';
import '../../../../domain/models/player.dart';
import '../../../../domain/models/position_weights.dart';
import '../../../../domain/models/schemes.dart';
import '../../../../domain/models/schemes_connections.dart';
import '../../../../domain/models/team.dart';
import '../draft_players_screen/draft_players_screen.dart';
import 'widgets/player_card/draft_football_player_card.dart';

part 'draft_screen_presenter.dart';
part 'widgets/appbar.dart';
part 'widgets/choose_captain_message.dart';
part 'widgets/next_button.dart';
part 'widgets/scheme.dart';
part 'widgets/scheme_selector.dart';
part 'widgets/squad_rating.dart';

class DraftScreen extends StatelessWidget {
  const DraftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DraftScreenPresenter(
      child: Builder(
        builder: (context) {
          final presenter = DraftScreenPresenter.of(context);

          return PopScope(
            canPop: false,
            child: Scaffold(
              body: StreamBuilder(
                stream: presenter.draftPage$,
                builder: (context, draftPageSnapshot) {
                  final page = draftPageSnapshot.data;

                  return Column(
                    children: [
                      const _AppBar(),
                      const Expanded(child: _Scheme()),
                      const SizedBox(height: 16),
                      if (page == 1)
                        const _SchemeSelector()
                      else if (page == 2)
                        const _ChooseCaptainMessage()
                      else if (page == 3)
                        const _SquadRating(),
                      const SizedBox(height: 16),

                      // Padding(
                      //   padding: const EdgeInsets.all(16),
                      //   child: _ConfirmTeamButton(),
                      // ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
