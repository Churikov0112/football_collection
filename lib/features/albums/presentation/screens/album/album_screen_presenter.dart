part of 'album_screen.dart';

class AlbumScreenPresenter extends StatefulWidget {
  static AlbumScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<AlbumScreenPresenterState>()!;
  }

  final Widget child;
  final CountryModel country;

  const AlbumScreenPresenter({
    required this.country,
    required this.child,
    super.key,
  });

  @override
  State<AlbumScreenPresenter> createState() => AlbumScreenPresenterState();
}

class AlbumScreenPresenterState extends State<AlbumScreenPresenter> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // getIt.get<AllPlayersBloc>().add(AllPlayersEventLoad());
      getIt.get<SavedPlayersBloc>().add(SavedPlayersEventLoad());
      getIt.get<CountryPlayersBloc>().add(CountryPlayersEventGet(countryCode: widget.country.code));
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
