part of '../guess_player_join_date_screen.dart';

mixin GuessPlayerJoinDateYandexAdsBannerMixin on State<GuessPlayerJoinDateScreenPresenter> {
  late BannerAd banner;

  BehaviorSubject<bool> isBannerAlreadyCreatedSubject = BehaviorSubject.seeded(
    false,
  );
  Stream<bool> get isBannerAlreadyCreatedStream$ => isBannerAlreadyCreatedSubject.stream;

  BannerAdSize _getBannerAdSize() {
    final width = MediaQuery.of(context).size.width.round();
    return BannerAdSize.sticky(width: width);
  }

  BannerAd _createBanner() {
    return BannerAd(
      adUnitId: adConfig.miniGamesBottomBanner,
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
