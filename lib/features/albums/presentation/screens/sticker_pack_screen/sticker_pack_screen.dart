// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/albums/domain/models/pack.dart';
import 'package:football_collection/features/albums/presentation/blocs/saved_players_bloc/saved_players_bloc.dart';
import 'package:football_collection/features/albums/presentation/widgets/saved_player_card.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:football_collection/features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:gif/gif.dart';
import 'package:go_router/go_router.dart';
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
                stream: CombineLatestStream.combine4(
                  presenter.isWaitingConfirmStream$,
                  presenter.isUnpackingStream$,
                  presenter.isPackSelectingStream$,
                  presenter.isPackOpenedStream$,
                  (waitingConfirm, unpacking, selecting, opened) =>
                      CombinedState(waitingConfirm, unpacking, selecting, opened),
                ),
                builder: (context, snapshot) {
                  final state = snapshot.data ?? CombinedState(false, false, false, false);

                  return BlocBuilder<StickerpacksBloc, StickerpacksState>(
                    builder: (context, stickerpackState) {
                      final packs = stickerpackState.packs ?? [];
                      if (packs.isEmpty) return const Center(child: CircularProgressIndicator());

                      return Stack(
                        children: [
                          AnimatedBuilder(
                            animation: presenter._selectPackAnimation,
                            builder: (context, child) {
                              final value = presenter._selectPackAnimation.value;
                              return Positioned(
                                bottom: -mq.size.height * value + 40,
                                left: 0,
                                right: 0,
                                child: Visibility.maintain(
                                  visible: !state.unpacking,
                                  child: Gallery3D(
                                    isClip: false,
                                    controller: presenter.gallery3dController,
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    itemConfig: const GalleryItemConfig(
                                      width: packWidth,
                                      height: packHeight + 40,
                                      isShowTransformMask: false,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: packHeight + mq.padding.bottom,
                                    onClickItem: (index) {
                                      if (presenter.openedPack == null && !state.isWaitingConfirm) {
                                        if (packs[index].price == 0) {
                                          presenter.getPack(packs[index]);
                                        } else {
                                          presenter.requestBuyPackConfirm(packs[index]);
                                        }
                                      }
                                    },
                                    itemBuilder: (context, index) {
                                      final pack = packs[index];
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: packHeight,
                                            width: packWidth,
                                            decoration: BoxDecoration(
                                              // image: pack.imageAssetPath != null
                                              //     ? DecorationImage(image: AssetImage(pack.imageAssetPath!))
                                              //     : null,
                                              color: pack.imageAssetPath == null ? Colors.purple : null,
                                              // border: Border.all(),
                                            ),
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
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          if (state.unpacking && presenter.openedPack?.players != null)
                            _PlayerCardsSwiper(players: presenter.openedPack!.players!),
                          if (state.selecting)
                            AnimatedBuilder(
                              animation: presenter._selectPackAnimation,
                              builder: (context, child) {
                                final value = presenter._selectPackAnimation.value;
                                return Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: -2 * packHeight + (2.5 * packHeight) * value,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (value == 1.0 && !(presenter._gifController?.isAnimating ?? false)) {
                                        presenter.unpackCards();
                                      }
                                    },
                                    child: Gif(
                                      fps: 30, // Уменьшенный FPS
                                      autostart: Autostart.no,
                                      image: const AssetImage("assets/gif/python_opt_50.gif"),
                                      controller: presenter._gifController,
                                      height: packHeight * 1.5,
                                      width: packWidth * 1.5,
                                      fit: BoxFit.cover,
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
  final bool selecting;
  final bool opened;

  CombinedState(
    this.isWaitingConfirm,
    this.unpacking,
    this.selecting,
    this.opened,
  );
}
