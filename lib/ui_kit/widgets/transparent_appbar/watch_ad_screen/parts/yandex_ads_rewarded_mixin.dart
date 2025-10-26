import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../../../../../config/ad_config.dart';
import '../watch_ad_screen.dart';

mixin WatchYandexAdsRewardedMixin on State<WatchAdScreenPresenter> {
  late final Future<RewardedAdLoader> _adLoader;
  RewardedAd? rewardedAd;

  Future<void> createRewardedAdLoader() async {
    _adLoader = RewardedAdLoader.create(
      onAdLoaded: (ad) {
        rewardedAd = ad;
      },
    );
    await _loadRewardedAd();
  }

  Future<void> _loadRewardedAd() async {
    final adLoader = await _adLoader;
    await adLoader.loadAd(
      adRequestConfiguration: AdRequestConfiguration(
        adUnitId: adConfig.openPackRewardedAd, // 'demo-rewarded-yandex',
      ),
    );
  }

  Future<void> showRewardedAd(VoidCallback onRewarded) async {
    await rewardedAd?.setAdEventListener(
      eventListener: RewardedAdEventListener(
        onAdFailedToShow: (error) {
          rewardedAd?.destroy();
          rewardedAd = null;
          _loadRewardedAd();
        },
        onAdDismissed: () {
          rewardedAd?.destroy();
          rewardedAd = null;
          _loadRewardedAd();
        },
        onRewarded: (reward) {},
      ),
    );

    await rewardedAd?.show();
    final reward = await rewardedAd?.waitForDismiss();
    if (reward != null) {
      onRewarded.call();
    }
  }
}
