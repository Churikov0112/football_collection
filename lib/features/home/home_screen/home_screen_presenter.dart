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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await Future.delayed(const Duration(milliseconds: 330), () async {
          await FirebaseService.init();
        });

        final language = getIt.get<LanguageBloc>().state.language;
        await FirebaseService.subscribeToTopic(language.englishName);
      } catch (e) {
        LogService.error(e.toString(), e);
      }

      try {
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(isTrackingAllowed);
        }
      } catch (e) {
        LogService.error(e.toString(), e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
