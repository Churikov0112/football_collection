part of 'draft_players_screen.dart';

class DraftPlayersScreenPresenter extends StatefulWidget {
  static DraftPlayersScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<DraftPlayersScreenPresenterState>()!;
  }

  final Widget child;
  final DraftPlayersScreenArguments args;

  const DraftPlayersScreenPresenter({
    required this.args,
    required this.child,
    super.key,
  });

  @override
  State<DraftPlayersScreenPresenter> createState() => DraftPlayersScreenPresenterState();
}

class DraftPlayersScreenPresenterState extends State<DraftPlayersScreenPresenter> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
