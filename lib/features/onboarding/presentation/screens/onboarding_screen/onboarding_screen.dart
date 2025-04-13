import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/abstract/presentation/blocs/first_launch_bloc/first_launch_bloc.dart';
import 'package:football_collection/features/football_players/presentation/blocs/random_football_players_bloc/random_football_players_bloc.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../abstract/domain/models/card.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../../football_confederations/presentation/screens/confederations_screen/widgets/open_packs_screen_button.dart';
import '../../../../football_players/domain/models/player.dart';
import '../../../../football_players/presentation/screens/packs_screen/football_players_packs_screen.dart';
import '../../../../football_players/presentation/widgets/football_player_card.dart';
import '../../../../settings/presentation/ui/screens/settings_screen/widgets/select_language.dart';

part 'onboarding_screen_presenter.dart';
part 'widgets/cards_swiper.dart';
part 'widgets/page0.dart';
part 'widgets/page1.dart';
part 'widgets/page2.dart';
part 'widgets/page3.dart';
part 'widgets/page4.dart';
part 'widgets/page5.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomFootballPlayersBloc(getIt.get()),
      child: OnboardingScreenPresenter(
        child: Builder(
          builder: (context) {
            final presenter = OnboardingScreenPresenter.of(context);

            return Scaffold(
              body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: presenter.onboardingController,
                children: [
                  _OnboardingPage0(),
                  _OnboardingPage1(),
                  _OnboardingPage2(),
                  _OnboardingPage3(),
                  _OnboardingPage4(),
                  _OnboardingPage5(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
