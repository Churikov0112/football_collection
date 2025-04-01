part of 'players_screen.dart';

class PlayersScreenPresenter extends StatefulWidget {
  static PlayersScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<PlayersScreenPresenterState>()!;
  }

  final Widget child;
  final CountryModel country;

  const PlayersScreenPresenter({
    required this.country,
    required this.child,
    super.key,
  });

  @override
  State<PlayersScreenPresenter> createState() => PlayersScreenPresenterState();
}

class PlayersScreenPresenterState extends State<PlayersScreenPresenter> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // getIt.get<AllPlayersBloc>().add(AllPlayersEventLoad());
      // getIt.get<SavedPlayersBloc>().add(SavedPlayersEventLoad());
      getIt.get<CountryPlayersBloc>().add(CountryPlayersEventGet(countryId: widget.country.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
