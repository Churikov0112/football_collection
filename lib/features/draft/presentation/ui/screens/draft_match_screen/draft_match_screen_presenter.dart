part of 'draft_match_screen.dart';

class DraftMatchScreenPresenter extends StatefulWidget {
  static DraftMatchScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<DraftMatchScreenPresenterState>()!;
  }

  final Widget child;

  const DraftMatchScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<DraftMatchScreenPresenter> createState() => DraftMatchScreenPresenterState();
}

class DraftMatchScreenPresenterState extends State<DraftMatchScreenPresenter> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
