part of 'football_confederations_screen.dart';

class FootballConfederationsScreenPresenter extends StatefulWidget {
  static FootballConfederationsScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<FootballConfederationsScreenPresenterState>()!;
  }

  final Widget child;

  const FootballConfederationsScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<FootballConfederationsScreenPresenter> createState() => FootballConfederationsScreenPresenterState();
}

class FootballConfederationsScreenPresenterState extends State<FootballConfederationsScreenPresenter>
    with FootballConfederationsYandexAdsBannerMixin {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadBannerAd();
      getIt.get<AllCountriesBloc>().add(AllCountriesEventGet());
      getIt.get<AllFootballPlayersBloc>().add(AllFootballPlayersEventLoad());
      getIt.get<FootballConfederationsBloc>().add(FootballConfederationsEventGet());
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
