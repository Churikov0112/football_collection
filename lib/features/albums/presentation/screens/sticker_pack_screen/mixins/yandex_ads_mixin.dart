part of '../sticker_pack_screen.dart';

mixin _YandexAdsMixin {
// // ! ads start ----------------------------------------------------------------

//   // late BannerAd banner;
//   // var isBannerAlreadyCreated = false;
//   // late final Future<RewardedAdLoader> _adLoader;
//   // RewardedAd? _ad;

//   // BannerAdSize _getBannerAdSize() {
//   //   final width = MediaQuery.of(context).size.width.round();
//   //   return BannerAdSize.sticky(width: width);
//   // }

//   // BannerAd _createBanner() {
//   //   return BannerAd(
//   //     adUnitId: adConfig.packBottomBanner, // "demo-banner-yandex",
//   //     adSize: _getBannerAdSize(),
//   //     adRequest: const AdRequest(),
//   //     onAdLoaded: () {
//   //       if (!mounted) {
//   //         banner.destroy();
//   //         return;
//   //       }
//   //     },
//   //   );
//   // }

//   // void _loadAd() async {
//   //   banner = _createBanner();
//   //   setState(() {
//   //     isBannerAlreadyCreated = true;
//   //   });
//   // }

//   // Future<RewardedAdLoader> _createRewardedAdLoader() {
//   //   return RewardedAdLoader.create(
//   //     onAdLoaded: (rewardedAd) {
//   //       _ad = rewardedAd;
//   //     },
//   //   );
//   // }

//   // Future<void> _loadRewardedAd() async {
//   //   final adLoader = await _adLoader;
//   //   await adLoader.loadAd(
//   //     adRequestConfiguration: AdRequestConfiguration(
//   //       adUnitId: adConfig.openPackAd, // 'demo-rewarded-yandex',
//   //     ),
//   //   );
//   // }

//   // Future<void> _showRewardedAd() async {
//   //   _ad?.setAdEventListener(
//   //     eventListener: RewardedAdEventListener(
//   //       onAdFailedToShow: (error) {
//   //         _ad?.destroy();
//   //         _ad = null;
//   //         _loadRewardedAd();
//   //       },
//   //       onAdDismissed: () {
//   //         _ad?.destroy();
//   //         _ad = null;
//   //         _loadRewardedAd();
//   //       },
//   //       onRewarded: (reward) {},
//   //     ),
//   //   );

//   //   await _ad?.show();
//   //   final reward = await _ad?.waitForDismiss();
//   //   if (reward != null) {
//   //     _openPack();
//   //   }
//   // }

//   // ! ads end ---------------------------------------------------------------
// }
}
