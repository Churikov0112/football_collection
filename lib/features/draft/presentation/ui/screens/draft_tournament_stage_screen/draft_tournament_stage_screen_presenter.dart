part of 'draft_tournament_stage_screen.dart';

class DraftTournamentStageScreenPresenter extends StatefulWidget {
  static DraftTournamentStageScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<DraftTournamentStageScreenPresenterState>()!;
  }

  final Widget child;
  // final DraftTournamentStateScreenArgs args;

  const DraftTournamentStageScreenPresenter({
    // required this.args,
    required this.child,
    super.key,
  });

  @override
  State<DraftTournamentStageScreenPresenter> createState() => DraftTournamentStageScreenPresenterState();
}

class DraftTournamentStageScreenPresenterState extends State<DraftTournamentStageScreenPresenter> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
