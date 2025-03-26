part of 'guess_transfer_value_less_more_screen.dart';

class GuessTransferValueLessMoreScreenPresenter extends StatefulWidget {
  static GuessTransferValueLessMoreScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GuessTransferValueLessMoreScreenPresenterState>()!;
  }

  final Widget child;

  const GuessTransferValueLessMoreScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<GuessTransferValueLessMoreScreenPresenter> createState() => GuessTransferValueLessMoreScreenPresenterState();
}

class GuessTransferValueLessMoreScreenPresenterState extends State<GuessTransferValueLessMoreScreenPresenter> {
  final random = Random();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<RandomPlayersBloc>().add(RandomPlayersEventGet(count: 2, hasTransferValue: true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
