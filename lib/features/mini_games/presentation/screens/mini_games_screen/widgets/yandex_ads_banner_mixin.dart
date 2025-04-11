import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../mini_games_screen.dart';

mixin MiniGamesYandexAdsBannerMixin on State<MiniGamesScreenPresenter> {
  late BannerAd banner;

  BehaviorSubject<bool> isBannerAlreadyCreatedSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isBannerAlreadyCreatedStream$ => isBannerAlreadyCreatedSubject.stream;

  BannerAdSize _getBannerAdSize() {
    final width = MediaQuery.of(context).size.width.round();
    return BannerAdSize.sticky(width: width);
  }

  BannerAd _createBanner() {
    return BannerAd(
      adUnitId: "demo-banner-yandex", // adConfig.confederationsBottomBanner, // "demo-banner-yandex",
      adSize: _getBannerAdSize(),
      adRequest: const AdRequest(),
      onAdLoaded: () {
        if (!mounted) {
          banner.destroy();
          return;
        }
      },
    );
  }

  void loadBannerAd() async {
    isBannerAlreadyCreatedSubject.add(false);
    banner = _createBanner();
    isBannerAlreadyCreatedSubject.add(true);
  }
}
