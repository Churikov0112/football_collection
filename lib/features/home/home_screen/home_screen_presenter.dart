part of 'home_screen.dart';

class HomeScreenPresenter extends StatefulWidget {
  static HomeScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<HomeScreenPresenterState>()!;
  }

  final Widget child;

  const HomeScreenPresenter({required this.child, super.key});

  @override
  State<HomeScreenPresenter> createState() => HomeScreenPresenterState();
}

class HomeScreenPresenterState extends State<HomeScreenPresenter> {
  void _showNewGamePromoDialog() {
    showDialog(context: context, barrierDismissible: false, builder: (context) => const _NewGamePromoDialog());
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isDownloadClicked = getIt.get<PromoBloc>().state.isDownloadClicked ?? false;
      if (!isDownloadClicked) {
        _showNewGamePromoDialog();
      }
      // loadBannerAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
