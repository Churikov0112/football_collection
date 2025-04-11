part of 'settings_screen.dart';

class SettingsScreenPresenter extends StatefulWidget {
  static SettingsScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<SettingsScreenPresenterState>()!;
  }

  final Widget child;

  const SettingsScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<SettingsScreenPresenter> createState() => SettingsScreenPresenterState();
}

class SettingsScreenPresenterState extends State<SettingsScreenPresenter> with SettingsYandexAdsBannerMixin {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadBannerAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
