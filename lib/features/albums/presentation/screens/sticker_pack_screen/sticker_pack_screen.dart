// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/albums/domain/models/pack.dart';
import 'package:football_collection/features/albums/presentation/blocs/saved_players_bloc/saved_players_bloc.dart';
import 'package:football_collection/features/albums/presentation/widgets/saved_player_card.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:football_collection/features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import 'package:football_collection/services/log/log_service.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:go_router/go_router.dart';
import 'package:o3d/o3d.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../confederations/domain/models/confederation.dart';
import '../../../../mini_games/presentation/widgets/balance_widget/balance_widget.dart';
import '../../../domain/models/player.dart';
import '../../blocs/stickerpacks_bloc/stickerpacks_bloc.dart';

part 'sticker_pack_screen_presenter.dart';
part 'widgets/player_cards_swiper.dart';

const packHeight = 300.0;
const packWidth = 200.0;

class StickerpackScreenArgs {
  final CountryModel? country;
  final Confederations? confederation;
  const StickerpackScreenArgs({this.country, this.confederation});
}

class StickerpackScreen extends StatelessWidget {
  const StickerpackScreen({
    required this.args,
    super.key,
  });

  final StickerpackScreenArgs args;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => StickerpacksBloc(getIt.get()),
      child: StickerpackScreenPresenter(
        args: args,
        child: Builder(
          builder: (context) {
            final presenter = StickerpackScreenPresenter.of(context);

            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    const Text("Open Pack"),
                    const Spacer(),
                    const BalanceWidget(),
                  ],
                ),
              ),
              body: StreamBuilder<CombinedState>(
                stream: CombineLatestStream.combine5(
                  presenter.selectedPackIndexStream$,
                  presenter.show3dObjectStream$,
                  presenter.isWaitingConfirmStream$,
                  presenter.isUnpackingAnimationPlayingStream$,
                  presenter.isHidePacksAnimationPlayingStream$,
                  (selectedPackIndex, show3dObject, waitingConfirm, unpacking, packsHiding) =>
                      CombinedState(selectedPackIndex, show3dObject, waitingConfirm, unpacking, packsHiding),
                ),
                builder: (context, snapshot) {
                  final state = snapshot.data ?? CombinedState(0, false, false, false, false);

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
                                bottom: -mq.size.height * value + 50,
                                left: 0,
                                right: 0,
                                child: Visibility.maintain(
                                  visible: !state.unpacking,
                                  child: SizedBox(
                                    height: packHeight + 30,
                                    child: PageView.builder(
                                      itemCount: packs.length,
                                      controller: presenter.packsPageController,
                                      onPageChanged: (index) {
                                        presenter.setSelectedPackIndex(index);
                                      },
                                      itemBuilder: (context, index) {
                                        final pack = packs[index];
                                        return GestureDetector(
                                          onTap: () {
                                            if (!state.unpacking && !state.packsHiding && !state.isWaitingConfirm) {
                                              if (packs[index].price == 0) {
                                                presenter.openPack();
                                              } else {
                                                presenter.requestBuyPackConfirm(packs[index]);
                                              }
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: packHeight,
                                                width: packWidth,
                                                child: Stack(
                                                  children: [
                                                    Image.asset(
                                                      pack.imageAssetPath,
                                                      height: packHeight,
                                                      width: packWidth,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    if (pack.imageAssetPath == "assets/raster/packs/pack-general.png")
                                                      Positioned(
                                                        top: 32,
                                                        right: 16,
                                                        left: 16,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              pack.title,
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              emojiFlagByCountryName(pack.title) ?? "",
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: 32,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                pack.price > 0 ? "${pack.price} 🏆" : "Free",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
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
                                  child: SizedBox(
                                    height: 2 * packHeight,
                                    width: 2 * packWidth,
                                    child: Stack(
                                      children: [
                                        O3D.asset(
                                          src: selectedPack.glbAssetPath, // 'assets/3d/europe.glb',
                                          controller: presenter.o3dController,
                                          autoPlay: false,
                                          disableTap: true,
                                          disableZoom: true,
                                          disablePan: true,
                                          cameraControls: false,
                                        ),
                                        if (selectedPack.imageAssetPath == "assets/raster/packs/pack-general.png")
                                          Positioned(
                                            top: (2 * packHeight) / 4,
                                            right: 16,
                                            left: 16,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: packWidth,
                                                  child: Text(
                                                    selectedPack.title,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 32,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  emojiFlagByCountryName(selectedPack.title) ?? "",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 32),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
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

class CombinedState {
  final int selectedPackIndex;
  final bool show3dObject;
  final bool isWaitingConfirm;
  final bool unpacking;
  final bool packsHiding;

  CombinedState(
    this.selectedPackIndex,
    this.show3dObject,
    this.isWaitingConfirm,
    this.unpacking,
    this.packsHiding,
  );
}
