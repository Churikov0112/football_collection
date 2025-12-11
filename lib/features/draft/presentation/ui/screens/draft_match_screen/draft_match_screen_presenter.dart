part of 'draft_match_screen.dart';

class DraftMatchScreenPresenter extends StatefulWidget {
  static DraftMatchScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<DraftMatchScreenPresenterState>()!;
  }

  final Widget child;

  const DraftMatchScreenPresenter({required this.child, super.key});

  @override
  State<DraftMatchScreenPresenter> createState() => DraftMatchScreenPresenterState();
}

class DraftMatchScreenPresenterState extends State<DraftMatchScreenPresenter> {
  final BehaviorSubject<bool?> _matchFinishedSubject = BehaviorSubject();
  Stream<bool?> get matchFinished$ => _matchFinishedSubject.stream;

  final BehaviorSubject<bool?> _matchWonSubject = BehaviorSubject();
  Stream<bool?> get matchWon$ => _matchWonSubject.stream;

  final BehaviorSubject<(int, int)?> _scoreSubject = BehaviorSubject();
  Stream<(int, int)?> get score$ => _scoreSubject.stream;

  void setMatchFinished() {
    _matchFinishedSubject.add(true);
  }

  void setMatchWon(bool won) {
    _matchWonSubject.add(won);
  }

  void setScore(int userTeam, int opponentTeam) {
    _scoreSubject.add((userTeam, opponentTeam));
  }

  @override
  void dispose() {
    _matchFinishedSubject.close();
    _matchWonSubject.close();
    _scoreSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
