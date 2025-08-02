// import 'package:flutter/material.dart';
// import 'package:football_collection/config/ad_config.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:yandex_mobileads/mobile_ads.dart';

// import '../football_players_packs_screen.dart';

// mixin FootballPlayersPacksYandexAdsBannerMixin on State<FootballPlayersPacksScreenPresenter> {
//   late BannerAd banner;

//   BehaviorSubject<bool> isBannerAlreadyCreatedSubject = BehaviorSubject.seeded(false);
//   Stream<bool> get isBannerAlreadyCreatedStream$ => isBannerAlreadyCreatedSubject.stream;

//   BannerAdSize _getBannerAdSize() {
//     final width = MediaQuery.of(context).size.width.round();
//     return BannerAdSize.sticky(width: width);
//   }

//   BannerAd _createBanner() {
//     return BannerAd(
//       adUnitId: adConfig.openPackBottomBanner, // "demo-banner-yandex",
//       adSize: _getBannerAdSize(),
//       adRequest: const AdRequest(),
//       onAdLoaded: () {
//         if (!mounted) {
//           banner.destroy();
//           return;
//         }
//       },
//     );
//   }

//   void loadBannerAd() async {
//     isBannerAlreadyCreatedSubject.add(false);
//     // await Future.delayed(const Duration(milliseconds: 300));
//     banner = _createBanner();
//     isBannerAlreadyCreatedSubject.add(true);
//   }
// }
