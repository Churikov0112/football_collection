part of 'mini_games_screen.dart';

class MiniGamesScreenPresenter extends StatefulWidget {
  static MiniGamesScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<MiniGamesScreenPresenterState>()!;
  }

  final Widget child;

  const MiniGamesScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<MiniGamesScreenPresenter> createState() => MiniGamesScreenPresenterState();
}

class MiniGamesScreenPresenterState extends State<MiniGamesScreenPresenter> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
