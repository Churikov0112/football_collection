// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/abstract/domain/models/pack.dart';
import 'package:football_collection/features/abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import 'package:football_collection/features/abstract/presentation/blocs/settings_bloc/settings_bloc.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';
import 'package:football_collection/features/football_cards/domain/cards/team_emblem_card.dart';
import 'package:football_collection/features/football_cards/presentation/screens/packs_screen/widgets/yandex_ads_rewarded_mixin.dart';
import 'package:football_collection/features/leaderboard/presentation/blocs/leaderboard_country_bloc/leaderboard_country_bloc.dart';
import 'package:football_collection/features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import 'package:football_collection/services/firebase/firestore_service.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/log/log_service.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:o3d/o3d.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../services/navigation/navigation.dart';
import '../../../../../ui_kit/colors/colors.dart';
import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../../abstract/domain/models/card.dart';
import '../../../../football_confederations/domain/models/football_confederation.dart';
import '../../../domain/cards/coach_card.dart';
import '../../../domain/cards/legend_card.dart';
import '../../../domain/cards/player_card.dart';
import '../../blocs/football_players_packs_bloc/football_players_packs_bloc.dart';
import '../../widgets/coach_card/football_coach_card.dart';
import '../../widgets/legend_card/football_legend_card.dart';
import '../../widgets/player_card/football_player_card.dart';
import '../../widgets/team_emblem_card/football_team_emblem_card.dart';
import 'football_players_pack_results_screen.dart';
import 'widgets/confirm_buy_pack_bs.dart';
import 'widgets/not_enoght_money_bs.dart';
import 'widgets/pack_3d_model.dart';
import 'widgets/packs_page_view.dart';

part 'football_players_packs_screen_presenter.dart';
part 'widgets/player_cards_swiper.dart';

const packHeight = 300.0;
const packWidth = 200.0;

class FootballPlayersPacksScreenArgs {
  final FootballNationalTeamModel? country;
  final FootballConfederations? confederation;
  const FootballPlayersPacksScreenArgs({this.country, this.confederation});
}

class FootballPlayersPacksScreen extends StatelessWidget {
  const FootballPlayersPacksScreen({required this.args, super.key});

  final FootballPlayersPacksScreenArgs args;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => FootballPlayersPacksBloc(getIt.get()),
      child: FootballPlayersPacksScreenPresenter(
        args: args,
        child: Builder(
          builder: (context) {
            final presenter = FootballPlayersPacksScreenPresenter.of(context);

            return Scaffold(
              body: DecoratedBox(
                decoration: BoxDecoration(),
                child: StreamBuilder<OpenPackCombinedState>(
                  stream: CombineLatestStream.combine5(
                    presenter.selectedPackIndexStream$,
                    presenter.show3dObjectStream$,
                    presenter.isWaitingConfirmStream$,
                    presenter.isUnpackingAnimationPlayingStream$,
                    presenter.isHidePacksAnimationPlayingStream$,
                    (selectedPackIndex, show3dObject, waitingConfirm, unpacking, packsHiding) =>
                        OpenPackCombinedState(selectedPackIndex, show3dObject, waitingConfirm, unpacking, packsHiding),
                  ),
                  builder: (context, snapshot) {
                    final state = snapshot.data ?? OpenPackCombinedState(0, false, false, false, false);

                    return BlocBuilder<FootballPlayersPacksBloc, FootballPlayersPacksState>(
                      builder: (context, stickerpackState) {
                        final packs = stickerpackState.packs ?? [];
                        if (packs.isEmpty) return const Center(child: CircularProgressIndicator());
                        final selectedPack = packs[state.selectedPackIndex];

                        return Stack(
                          children: [
                            BackgroundImage(),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Translator(
                                termin: AppGlossary.openPack,
                                builder: (value) => TransparentAppbar(title: value),
                              ),
                            ),
                            AnimatedBuilder(
                              animation: presenter._hidePacksAnimation,
                              builder: (context, child) {
                                final value = presenter._hidePacksAnimation.value;
                                return Positioned(
                                  bottom: -mq.size.height * value + mq.padding.bottom + 16,
                                  left: 0,
                                  right: 0,
                                  child: PacksPageView(state: state, packs: packs),
                                );
                              },
                            ),
                            if (state.unpacking)
                              _PlayerCardsSwiper(cards: selectedPack.cards!, packName: selectedPack.title),
                            if (state.show3dObject)
                              AnimatedBuilder(
                                animation: presenter._hidePacksAnimation,
                                builder: (context, child) {
                                  final value = presenter._hidePacksAnimation.value;
                                  return Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: -2 * packHeight + (2.1 * packHeight) * value,
                                    child: Pack3dModel(selectedPack: selectedPack),
                                  );
                                },
                              ),
                            // Positioned(
                            //   bottom: mq.padding.bottom,
                            //   right: 0,
                            //   left: 0,
                            //   child: StreamBuilder<bool>(
                            //     stream: presenter.isBannerAlreadyCreatedStream$,
                            //     builder: (context, isBannerAlreadyCreatedSnapshot) {
                            //       if (isBannerAlreadyCreatedSnapshot.data != true) return const SizedBox();
                            //       return AdWidget(
                            //         bannerAd: presenter.banner,
                            //       );
                            //     },
                            //   ),
                            // ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class OpenPackCombinedState {
  final int selectedPackIndex;
  final bool show3dObject;
  final bool isWaitingConfirm;
  final bool unpacking;
  final bool packsHiding;

  OpenPackCombinedState(
    this.selectedPackIndex,
    this.show3dObject,
    this.isWaitingConfirm,
    this.unpacking,
    this.packsHiding,
  );
}
