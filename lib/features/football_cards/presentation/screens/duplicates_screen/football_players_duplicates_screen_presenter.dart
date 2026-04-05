part of 'football_players_duplicates_screen.dart';

class FootballPlayersDuplicatesScreenPresenter extends StatefulWidget {
  static FootballPlayersDuplicatesScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<FootballPlayersDuplicatesScreenPresenterState>()!;
  }

  final Widget child;

  const FootballPlayersDuplicatesScreenPresenter({required this.child, super.key});

  @override
  State<FootballPlayersDuplicatesScreenPresenter> createState() => FootballPlayersDuplicatesScreenPresenterState();
}

class FootballPlayersDuplicatesScreenPresenterState extends State<FootballPlayersDuplicatesScreenPresenter> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
