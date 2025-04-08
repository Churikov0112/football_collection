part of 'get_player_by_qr_screen.dart';

class GetPlayerByQrScreenPresenter extends StatefulWidget {
  static GetPlayerByQrScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GetPlayerByQrScreenPresenterState>()!;
  }

  final Widget child;

  const GetPlayerByQrScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<GetPlayerByQrScreenPresenter> createState() => GetPlayerByQrScreenPresenterState();
}

class GetPlayerByQrScreenPresenterState extends State<GetPlayerByQrScreenPresenter> with WidgetsBindingObserver {
  StreamSubscription<Object?>? _subscription;

  MobileScannerController mobileScannerController = MobileScannerController(
    facing: CameraFacing.back,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!mobileScannerController.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = mobileScannerController.barcodes.listen(handleBarcode);

        unawaited(mobileScannerController.start());
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(mobileScannerController.stop());
    }
  }

  void handleBarcode(BarcodeCapture capture) {
    final value = capture.barcodes.firstOrNull?.rawValue;
    if (value == null) return;
    final savedPlayers = getIt.get<SavedPlayersBloc>().state.savedIds ?? [];
    if (savedPlayers.contains(value)) return;
    getIt.get<SavedPlayersBloc>().add(SavedPlayersEventAdd(playerId: value));
    ToastService.showToast(title: "Player added to collection");
  }

  @override
  void dispose() {
    _subscription?.cancel();
    mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
