part of 'get_card_by_qr_screen.dart';

class GetCardByQrScreenPresenter extends StatefulWidget {
  static GetCardByQrScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GetCardByQrScreenPresenterState>()!;
  }

  final Widget child;

  const GetCardByQrScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<GetCardByQrScreenPresenter> createState() => GetCardByQrScreenPresenterState();
}

class GetCardByQrScreenPresenterState extends State<GetCardByQrScreenPresenter> with WidgetsBindingObserver {
  StreamSubscription<Object?>? _subscription;

  final detectionTrottler = Throttling(
    duration: const Duration(seconds: 3),
  );

  final MobileScannerController mobileScannerController = MobileScannerController(
    autoStart: false,
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    detectionTimeoutMs: 3000,
    formats: [
      BarcodeFormat.qrCode,
    ],
  );

  @override
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = mobileScannerController.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    unawaited(mobileScannerController.start());
  }

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
        _subscription = mobileScannerController.barcodes.listen(_handleBarcode);

        unawaited(mobileScannerController.start());
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(mobileScannerController.stop());
    }
  }

  void _handleBarcode(BarcodeCapture capture) {
    detectionTrottler.throttle(() {
      if (mounted) {
        final value = capture.barcodes.firstOrNull?.rawValue;
        if (value == null) {
          return;
        }
        final savedCards = getIt.get<SavedCardsBloc>().state.savedCardsIds ?? [];
        if (savedCards.contains(value)) {
          ToastService.showToast(title: AppGlossary.alreadyInCollection.translate());
          return;
        }
        getIt.get<SavedCardsBloc>().add(SavedCardsEventAdd(cardId: value));
        ToastService.showToast(title: AppGlossary.addedToCollection.translate());
      }
    });
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.

    detectionTrottler.close();

    // Finally, dispose of the controller.
    await mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
