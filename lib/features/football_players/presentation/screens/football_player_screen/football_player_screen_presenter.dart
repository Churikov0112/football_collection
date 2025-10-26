part of 'football_player_screen.dart';

class FootballPlayerScreenPresenter extends StatefulWidget {
  static FootballPlayerScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<FootballPlayerScreenPresenterState>()!;
  }

  final Widget child;

  const FootballPlayerScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<FootballPlayerScreenPresenter> createState() => FootballPlayerScreenPresenterState();
}

class FootballPlayerScreenPresenterState extends State<FootballPlayerScreenPresenter> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
