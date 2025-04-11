part of 'football_players_album_screen.dart';

class FootballPlayersAlbumScreenPresenter extends StatefulWidget {
  static FootballPlayersAlbumScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<FootballPlayersAlbumScreenPresenterState>()!;
  }

  final Widget child;
  final CountryModel country;

  const FootballPlayersAlbumScreenPresenter({
    required this.country,
    required this.child,
    super.key,
  });

  @override
  State<FootballPlayersAlbumScreenPresenter> createState() => FootballPlayersAlbumScreenPresenterState();
}

class FootballPlayersAlbumScreenPresenterState extends State<FootballPlayersAlbumScreenPresenter>
    with FootballPlayersAlbumYandexAdsBannerMixin {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadBannerAd();
      // getIt.get<AllPlayersBloc>().add(AllPlayersEventLoad());
      // getIt.get<SavedCardsBloc>().add(SavedCardsEventLoad());
      getIt.get<CountryFootballPlayersBloc>().add(CountryFootballPlayersEventGet(countryId: widget.country.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
