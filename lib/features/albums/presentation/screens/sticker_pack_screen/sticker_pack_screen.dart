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
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:go_router/go_router.dart';
import 'package:o3d/o3d.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../confederations/domain/models/confederation.dart';
import '../../../../mini_games/presentation/widgets/balance_widget/balance_widget.dart';
import '../../../domain/models/player.dart';
import '../../blocs/stickerpacks_bloc/stickerpacks_bloc.dart';

part 'mixins/yandex_ads_mixin.dart';
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
              // backgroundColor: args.confederation?.color?.withOpacity(0.8),
              appBar: AppBar(
                // backgroundColor: args.confederation?.color,
                // foregroundColor: args.confederation != null ? Colors.white : null,
                title: Row(
                  children: [
                    const Text("Open Pack"),
                    const Spacer(),
                    const BalanceWidget(),
                  ],
                ),
              ),
              body: StreamBuilder<CombinedState>(
                stream: CombineLatestStream.combine3(
                  presenter.isWaitingConfirmStream$,
                  presenter.isUnpackingAnimationPlayingStream$,
                  presenter.isHidePacksAnimationPlayingStream$,
                  (waitingConfirm, unpacking, packsHiding) => CombinedState(waitingConfirm, unpacking, packsHiding),
                ),
                builder: (context, snapshot) {
                  final state = snapshot.data ?? CombinedState(false, false, false);

                  return BlocBuilder<StickerpacksBloc, StickerpacksState>(
                    builder: (context, stickerpackState) {
                      final packs = stickerpackState.packs ?? [];
                      if (packs.isEmpty) return const Center(child: CircularProgressIndicator());

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
                                      itemBuilder: (context, index) {
                                        final pack = packs[index];
                                        return GestureDetector(
                                          onTap: () {
                                            if (presenter.pack == null && !state.isWaitingConfirm) {
                                              if (packs[index].price == 0) {
                                                presenter.create3dModel(packs[index]);
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
                                                child: pack.imageAssetPath == null
                                                    ? Center(
                                                        child: Text(
                                                          pack.title,
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        pack.imageAssetPath!,
                                                        height: packHeight,
                                                        width: packWidth,
                                                        fit: BoxFit.fill,
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
                                  // Gallery3D(
                                  //   isClip: false,
                                  //   controller: presenter.gallery3dController,
                                  //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  //   itemConfig: const GalleryItemConfig(
                                  //     width: packWidth,
                                  //     height: packHeight + 70,
                                  //     isShowTransformMask: false,
                                  //   ),
                                  //   width: MediaQuery.of(context).size.width,
                                  //   height: 30 + packHeight + mq.padding.bottom,
                                  //   onClickItem: (index) {
                                  //     if (presenter.openedPack == null && !state.isWaitingConfirm) {
                                  //       if (packs[index].price == 0) {
                                  //         presenter.openPack(packs[index]);
                                  //       } else {
                                  //         presenter.requestBuyPackConfirm(packs[index]);
                                  //       }
                                  //     }
                                  //   },
                                  //   itemBuilder: (context, index) {
                                  //     final pack = packs[index];
                                  //     return Column(
                                  //       children: [
                                  //         SizedBox(
                                  //           height: packHeight,
                                  //           width: packWidth,
                                  //           child: pack.imageAssetPath == null
                                  //               ? Center(
                                  //                   child: Text(
                                  //                     pack.title,
                                  //                     style: TextStyle(color: Colors.white),
                                  //                   ),
                                  //                 )
                                  //               : Image.asset(
                                  //                   pack.imageAssetPath!,
                                  //                   height: packHeight,
                                  //                   width: packWidth,
                                  //                   fit: BoxFit.fill,
                                  //                 ),
                                  //         ),
                                  //         Text(
                                  //           pack.price > 0 ? "${pack.price} 🏆" : "Free",
                                  //           style: TextStyle(
                                  //             fontSize: 20,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     );
                                  //   },
                                  // ),
                                ),
                              );
                            },
                          ),
                          if (state.unpacking && presenter.pack?.players != null)
                            _PlayerCardsSwiper(players: presenter.pack!.players!),
                          if (state.packsHiding && presenter.pack != null)
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
                                    child: O3D.asset(
                                      src: 'assets/3d/pack-an.glb',
                                      controller: presenter.o3dController,
                                      autoPlay: false,
                                      disableTap: true,
                                      disableZoom: true,
                                      disablePan: true,
                                      cameraControls: false,
                                      onWebViewCreated: (value) async {
                                        await Future.delayed(const Duration(milliseconds: 330));
                                        presenter.openPack(); // run 3d model pack animation
                                      },
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
  final bool isWaitingConfirm;
  final bool unpacking;
  final bool packsHiding;

  CombinedState(
    this.isWaitingConfirm,
    this.unpacking,
    this.packsHiding,
  );
}
