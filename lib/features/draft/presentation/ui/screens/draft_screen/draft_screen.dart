import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/features/draft/domain/models/ratings.dart';
import 'package:football_collection/features/draft/presentation/ui/screens/draft_screen/widgets/small_player_card/small_draft_football_player_card.dart';
import 'package:football_collection/features/football_confederations/domain/models/football_confederation.dart';
import 'package:football_collection/ui_kit/colors/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../di/di.dart';
import '../../../../../../services/localization/translator.dart';
import '../../../../../../services/navigation/bottom_sheet_controller/bottom_sheet_controller.dart';
import '../../../../../../services/navigation/navigation.dart';
import '../../../../../../ui_kit/widgets/glass_button/glass_button.dart';
import '../../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../../../abstract/presentation/blocs/utils/ratings.dart';
import '../../../../../football_cards/domain/cards/player_card.dart';
import '../../../../../football_cards/presentation/blocs/all_countries_bloc/all_countries_bloc.dart';
import '../../../../../football_cards/presentation/blocs/all_football_players_bloc/all_football_players_bloc.dart';
import '../../../../domain/models/player.dart';
import '../../../../domain/models/position.dart';
import '../../../../domain/models/position_weights.dart';
import '../../../../domain/models/schemes.dart';
import '../../../../domain/models/schemes_connections.dart';
import '../../../../domain/models/team.dart';
import '../../../blocs/draft_tournament_bloc/draft_tournament_bloc.dart';
import '../draft_players_screen/draft_players_screen.dart';
import 'widgets/player_card/parts/rating_tag.dart';

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
