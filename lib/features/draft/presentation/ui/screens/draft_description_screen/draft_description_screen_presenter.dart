part of 'draft_description_screen.dart';

class DraftDescriptionScreenPresenter extends StatefulWidget {
  static DraftDescriptionScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<DraftDescriptionScreenPresenterState>()!;
  }

  final Widget child;

  const DraftDescriptionScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<DraftDescriptionScreenPresenter> createState() => DraftDescriptionScreenPresenterState();
}

class DraftDescriptionScreenPresenterState extends State<DraftDescriptionScreenPresenter> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
