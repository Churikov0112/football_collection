// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:football_collection/features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import 'package:football_collection/features/players/domain/models/pack.dart';
import 'package:football_collection/features/players/presentation/blocs/saved_players_bloc/saved_players_bloc.dart';
import 'package:football_collection/features/players/presentation/screens/open_pack_screen/widgets/pack_3d_model.dart';
import 'package:football_collection/features/players/presentation/screens/open_pack_screen/widgets/packs_page_view.dart';
import 'package:football_collection/features/players/presentation/widgets/saved_player_card.dart';
import 'package:football_collection/services/log/log_service.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:o3d/o3d.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../confederations/domain/models/confederation.dart';
import '../../../../mini_games/presentation/widgets/balance_widget/balance_widget.dart';
import '../../../domain/models/player.dart';
import '../../blocs/stickerpacks_bloc/stickerpacks_bloc.dart';
import 'widgets/confirm_buy_pack_bs.dart';
import 'widgets/not_enoght_money_bs.dart';

part 'open_pack_screen_presenter.dart';
part 'widgets/player_cards_swiper.dart';

const packHeight = 300.0;
const packWidth = 200.0;

class OpenPackScreenArgs {
  final CountryModel? country;
  final Confederations? confederation;
  const OpenPackScreenArgs({this.country, this.confederation});
}

class OpenPackScreen extends StatelessWidget {
  const OpenPackScreen({
    required this.args,
    super.key,
  });

  final OpenPackScreenArgs args;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => StickerpacksBloc(getIt.get()),
      child: OpenPackScreenPresenter(
        args: args,
        child: Builder(
          builder: (context) {
            final presenter = OpenPackScreenPresenter.of(context);

            return Scaffold(
              appBar: AppBar(title: Row(children: [const Text("Open Pack"), const Spacer(), const BalanceWidget()])),
              body: StreamBuilder<OpenPackCombinedState>(
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

                  return BlocBuilder<StickerpacksBloc, StickerpacksState>(
                    builder: (context, stickerpackState) {
                      final packs = stickerpackState.packs ?? [];
                      if (packs.isEmpty) return const Center(child: CircularProgressIndicator());
                      final selectedPack = packs[state.selectedPackIndex];

                      return Stack(
                        children: [
                          AnimatedBuilder(
                            animation: presenter._hidePacksAnimation,
                            builder: (context, child) {
                              final value = presenter._hidePacksAnimation.value;
                              return Positioned(
                                bottom: -mq.size.height * value + mq.padding.bottom,
                                left: 0,
                                right: 0,
                                child: PacksPageView(state: state, packs: packs),
                              );
                            },
                          ),
                          if (state.unpacking) _PlayerCardsSwiper(players: selectedPack.players!),
                          if (state.show3dObject)
                            AnimatedBuilder(
                              animation: presenter._hidePacksAnimation,
                              builder: (context, child) {
                                final value = presenter._hidePacksAnimation.value;
                                return Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: -2 * packHeight + (2 * packHeight) * value,
                                  child: Pack3dModel(selectedPack: selectedPack),
                                );
                              },
                            ),
                        ],
                      );
                    },
                  );
                },
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
