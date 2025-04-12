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
  late BehaviorSubject<bool> enableVibrationOnPackOpeningSubject;
  Stream<bool> get enableVibrationOnPackOpeningStream$ => enableVibrationOnPackOpeningSubject.stream;

  @override
  void initState() {
    final settingsState = getIt.get<SettingsBloc>().state;
    enableVibrationOnPackOpeningSubject = BehaviorSubject.seeded(settingsState.enableVibrationOnPackOpening);
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadBannerAd();
    });
  }

  void toggleEnableVibrationOnPackOpening(bool value) {
    enableVibrationOnPackOpeningSubject.add(value);
    // final settingsState = getIt.get<SettingsBloc>().state;
    getIt.get<SettingsBloc>().add(
          SettingsEventSet(
            enableVibrationOnPackOpening: value,
          ),
        );
  }

  @override
  void dispose() {
    enableVibrationOnPackOpeningSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
