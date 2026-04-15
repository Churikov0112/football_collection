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

class SettingsScreenPresenterState extends State<SettingsScreenPresenter> {
  // @override
  // void initState() {
  //   super.initState();
  //   SchedulerBinding.instance.addPostFrameCallback((_) {
  //     loadBannerAd();
  //   });
  // }

  void toggleEnableVibration(bool enabled) {
    if (enabled) {
      unawaited(HapticFeedback.lightImpact());
    }
    final settingsState = getIt.get<SettingsBloc>().state;
    getIt.get<SettingsBloc>().add(
      SettingsEventSet(
        enableVibration: enabled,
        enableConfetti: settingsState.enableConfetti,
        enablePackManualRotate: settingsState.enablePackManualRotate,
        enablePackAutoRotate: settingsState.enablePackAutoRotate,
        packAutoRotatePerSecond: settingsState.packAutoRotatePerSecond,
        packManualRotateSensitivity: settingsState.packManualRotateSensitivity,
        autoRotatePerSecond: settingsState.packAutoRotatePerSecond,
      ),
    );
  }

  void toggleEnableConfetti(bool enabled) {
    if (enabled) {
      Confetti.launch(context, options: const ConfettiOptions(particleCount: 100, spread: 70, y: 0.6));
    }
    final settingsState = getIt.get<SettingsBloc>().state;
    getIt.get<SettingsBloc>().add(
      SettingsEventSet(
        enableVibration: settingsState.enableVibration,
        enableConfetti: enabled,
        enablePackManualRotate: settingsState.enablePackManualRotate,
        enablePackAutoRotate: settingsState.enablePackAutoRotate,
        packAutoRotatePerSecond: settingsState.packAutoRotatePerSecond,
        packManualRotateSensitivity: settingsState.packManualRotateSensitivity,
        autoRotatePerSecond: settingsState.packAutoRotatePerSecond,
      ),
    );
  }

  void togglePackManualRotate(bool value) {
    final settingsState = getIt.get<SettingsBloc>().state;
    getIt.get<SettingsBloc>().add(
      SettingsEventSet(
        enableVibration: settingsState.enableVibration,
        enableConfetti: settingsState.enableConfetti,
        enablePackManualRotate: value,
        enablePackAutoRotate: settingsState.enablePackAutoRotate,
        packAutoRotatePerSecond: settingsState.packAutoRotatePerSecond,
        packManualRotateSensitivity: settingsState.packManualRotateSensitivity,
        autoRotatePerSecond: settingsState.packAutoRotatePerSecond,
      ),
    );
  }

  void togglePackAutoRotate(bool value) {
    final settingsState = getIt.get<SettingsBloc>().state;
    getIt.get<SettingsBloc>().add(
      SettingsEventSet(
        enableVibration: settingsState.enableVibration,
        enableConfetti: settingsState.enableConfetti,
        enablePackManualRotate: settingsState.enablePackManualRotate,
        enablePackAutoRotate: value,
        packAutoRotatePerSecond: settingsState.packAutoRotatePerSecond,
        packManualRotateSensitivity: settingsState.packManualRotateSensitivity,
        autoRotatePerSecond: settingsState.packAutoRotatePerSecond,
      ),
    );
  }

  // void changeTrackAutoRotateSpeed(double value) {
  //   final settingsState = getIt.get<SettingsBloc>().state;
  //   getIt.get<SettingsBloc>().add(
  //     SettingsEventSet(
  //       enableVibration: settingsState.enableVibration,
  //       enableConfetti: settingsState.enableConfetti,
  //       enablePackManualRotate: settingsState.enablePackManualRotate,
  //       enablePackAutoRotate: settingsState.enablePackAutoRotate,
  //       packAutoRotatePerSecond: value.round(),
  //       packManualRotateSensitivity: settingsState.packManualRotateSensitivity,
  //       autoRotatePerSecond: settingsState.packAutoRotatePerSecond,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
