import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/albums/presentation/blocs/saved_players_bloc/saved_players_bloc.dart';
import 'package:football_collection/features/albums/presentation/widgets/saved_player_card.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:gif/gif.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/models/player.dart';
import '../../blocs/stickerpack_bloc/stickerpack_bloc.dart';

part 'mixins/yandex_ads_mixin.dart';
part 'sticker_pack_screen_presenter.dart';
part 'widgets/player_cards_swiper.dart';

const packHeight = 300.0;
const packWidth = 200.0;

class StickerpackScreen extends StatefulWidget {
  const StickerpackScreen({
    required this.country,
    super.key,
  });

  final CountryModel? country;

  @override
  State<StickerpackScreen> createState() => _StickerpackScreenState();
}

class _StickerpackScreenState extends State<StickerpackScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // final backgroundHeight = mq.size.height - mq.padding.top - mq.padding.bottom - 56;

    if (!mounted) return const SizedBox.shrink();

    return BlocProvider(
      create: (context) => StickerpackBloc(getIt.get()),
      child: StickerpackScreenPresenter(
        country: widget.country,
        child: Builder(
          builder: (context) {
            final presenter = StickerpackScreenPresenter.of(context);

            return Scaffold(
              backgroundColor: Colors.amber,
              appBar: AppBar(title: Text("Open Pack")),
              body: StreamBuilder<bool>(
                stream: presenter.isUnpackingStream$,
                builder: (context, isUnpackingSnapshot) {
                  return StreamBuilder<bool>(
                    stream: presenter.isPackSelectingStream$,
                    builder: (context, isPackSelectingSnapshot) {
                      return StreamBuilder<bool>(
                        stream: presenter.isPackOpenedStream$,
                        builder: (context, isPackOpenedSnapshot) {
                          return BlocBuilder<StickerpackBloc, StickerpackState>(
                            builder: (context, stickerpackState) {
                              final pack = stickerpackState.pack ?? [];
                              if (pack.isEmpty) return const Center(child: CircularProgressIndicator());

                              // if (isPackOpenedSnapshot.data ?? false) {
                              //   return ;
                              // }

                              return Stack(
                                children: [
                                  // Карусель изначально снизу экрана
                                  if (isUnpackingSnapshot.data == false)
                                    AnimatedBuilder(
                                      animation: presenter._selectPackAnimation,
                                      builder: (context, child) {
                                        final value = presenter._selectPackAnimation.value;
                                        return Positioned(
                                          bottom: -mq.size.height * value,
                                          child: Gallery3D(
                                            isClip: false,
                                            controller: presenter.gallery3dController,
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                            itemConfig: const GalleryItemConfig(
                                              width: packWidth,
                                              height: packHeight,
                                              isShowTransformMask: false,
                                            ),
                                            width: MediaQuery.of(context).size.width,
                                            height: packHeight + mq.padding.bottom,
                                            onClickItem: (index) {
                                              presenter.selectPack();
                                            },
                                            itemBuilder: (context, index) {
                                              return Image.asset("assets/raster/packs/pack_asia.jpg");
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  // AnimatedBuilder(
                                  //   animation: presenter._selectPackAnimation,
                                  //   builder: (context, child) {
                                  //     return Positioned(
                                  //       bottom: 0.5 * packHeight,
                                  //       child: _PlayerCardsSwiper(pack: pack),
                                  //     );
                                  //   },
                                  // ),
                                  if (isUnpackingSnapshot.data == true) _PlayerCardsSwiper(pack: pack),
                                  // if (isPackSelectingSnapshot.data == false)
                                  //   AnimatedBuilder(
                                  //     animation: presenter._selectPackAnimation,
                                  //     builder: (context, child) {
                                  //       return Positioned(
                                  //         right: 0,
                                  //         left: 0,
                                  //         bottom:
                                  //             -packHeight + (1.5 * packHeight) * presenter._selectPackAnimation.value,
                                  //         child: GestureDetector(
                                  //           onTap: () {
                                  //             // presenter._animationController.reverse();
                                  //presenter.openPack();
                                  //           },
                                  //           child: Image.asset(
                                  //             "assets/raster/packs/pack_asia.jpg",
                                  //             height: packHeight,
                                  //             width: packWidth,
                                  //           ),
                                  //         ),
                                  //       );
                                  //     },
                                  //   )
                                  // else
                                  if (isPackSelectingSnapshot.data == true)
                                    AnimatedBuilder(
                                      animation: presenter._selectPackAnimation,
                                      builder: (context, child) {
                                        final value = presenter._selectPackAnimation.value;
                                        return Positioned(
                                          right: 0,
                                          left: 0,
                                          bottom: -2 * packHeight + (2.2 * packHeight) * value,
                                          child: GestureDetector(
                                            onTap: () {
                                              if (value == 1.0 && !presenter.gifController.isAnimating) {
                                                presenter.unpackCards();
                                              }
                                            },
                                            child: Gif(
                                              fps: 30,
                                              autostart: Autostart.no,
                                              image: const AssetImage("assets/gif/ImageToStl.com_card-pack.glb.gif"),
                                              controller: presenter.gifController,
                                              height: packHeight * 2,
                                              width: packWidth * 2,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          // Flutter3DViewer(
                                          //   src: presenter.srcGlb,
                                          //   controller: presenter.flutter3dController,
                                          //   //If you pass 'true' the flutter_3d_controller will add gesture interceptor layer
                                          //   //to prevent gesture recognizers from malfunctioning on iOS and some Android devices.
                                          //   // the default value is true
                                          //   activeGestureInterceptor: false,
                                          //   //If you don't pass progressBarColor, the color of defaultLoadingProgressBar will be grey.
                                          //   //You can set your custom color or use [Colors.transparent] for hiding loadingProgressBar.
                                          //   progressBarColor: Colors.transparent,
                                          //   //You can disable viewer touch response by setting 'enableTouch' to 'false'
                                          //   enableTouch: false,
                                          //   //This callBack will return the loading progress value between 0 and 1.0
                                          //   onProgress: (double progressValue) {
                                          //     debugPrint('model loading progress : $progressValue');
                                          //   },
                                          //   //This callBack will call after model loaded successfully and will return model address
                                          //   onLoad: (String modelAddress) async {
                                          //     // debugPrint('model loaded : $modelAddress');
                                          //     presenter.unpackCards();
                                          //   },

                                          //   //this callBack will call when model failed to load and will return failure error
                                          //   onError: (String error) {
                                          //     debugPrint('model failed to load : $error');
                                          //   },
                                          //   //You can have full control of 3d model animations, textures and camera

                                          //   //src: 'assets/business_man.glb', //3D model with different animations
                                          //   //src: 'assets/sheen_chair.glb', //3D model with different textures
                                          //   //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // 3D model from URL
                                          // ),
                                        );
                                      },
                                    ),
                                ],
                              );
                            },
                          );
                        },
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
