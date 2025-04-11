import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../football_players_packs_screen.dart';

mixin FootballPlayersPacksYandexAdsRewardedMixin on State<FootballPlayersPacksScreenPresenter> {
  late final Future<RewardedAdLoader> _adLoader;
  RewardedAd? rewardedAd;

  BehaviorSubject<bool> isBannerAlreadyCreatedSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isBannerAlreadyCreatedStream$ => isBannerAlreadyCreatedSubject.stream;

  Future<void> createRewardedAdLoader() async {
    _adLoader = RewardedAdLoader.create(
      onAdLoaded: (ad) {
        rewardedAd = ad;
      },
    );
    _loadRewardedAd();
  }

  Future<void> _loadRewardedAd() async {
    final adLoader = await _adLoader;
    await adLoader.loadAd(
      adRequestConfiguration: AdRequestConfiguration(
        adUnitId: 'demo-rewarded-yandex', // adConfig.openPackAd, // 'demo-rewarded-yandex',
      ),
    );
  }

  Future<void> showRewardedAd(VoidCallback onRewarded) async {
    rewardedAd?.setAdEventListener(
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
