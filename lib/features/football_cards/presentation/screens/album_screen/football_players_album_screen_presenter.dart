part of 'football_players_album_screen.dart';

class FootballPlayersAlbumScreenPresenter extends StatefulWidget {
  static FootballPlayersAlbumScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<FootballPlayersAlbumScreenPresenterState>()!;
  }

  final Widget child;

  const FootballPlayersAlbumScreenPresenter({required this.child, super.key});

  @override
  State<FootballPlayersAlbumScreenPresenter> createState() => FootballPlayersAlbumScreenPresenterState();
}

class FootballPlayersAlbumScreenPresenterState extends State<FootballPlayersAlbumScreenPresenter> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
