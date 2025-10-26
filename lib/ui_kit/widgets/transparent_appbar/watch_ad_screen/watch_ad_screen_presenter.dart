part of 'watch_ad_screen.dart';

class WatchAdScreenPresenter extends StatefulWidget {
  static WatchAdScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<WatchAdScreenPresenterState>()!;
  }

  final Widget child;

  const WatchAdScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<WatchAdScreenPresenter> createState() => WatchAdScreenPresenterState();
}

class WatchAdScreenPresenterState extends State<WatchAdScreenPresenter> with WatchYandexAdsRewardedMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        // loadBannerAd();
        await createRewardedAdLoader();
      },
    );
  }

  @override
  void dispose() {
    rewardedAd?.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
