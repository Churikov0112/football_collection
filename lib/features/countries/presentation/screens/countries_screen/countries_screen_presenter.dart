part of 'countries_screen.dart';

class FootballCountriesScreenPresenter extends StatefulWidget {
  static FootballCountriesScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<FootballCountriesScreenPresenterState>()!;
  }

  final Widget child;
  final FootballConfederations confederation;

  const FootballCountriesScreenPresenter({
    required this.confederation,
    required this.child,
    super.key,
  });

  @override
  State<FootballCountriesScreenPresenter> createState() => FootballCountriesScreenPresenterState();
}

class FootballCountriesScreenPresenterState extends State<FootballCountriesScreenPresenter>
    with FootballCountriesYandexAdsBannerMixin {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadBannerAd();
      getIt
          .get<FootballConfederationCountriesBloc>()
          .add(FootballConfederationCountriesEventGet(confederation: widget.confederation));
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
