part of 'guess_transfer_value_screen.dart';

class GuessTransferValueScreenPresenter extends StatefulWidget {
  static GuessTransferValueScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GuessTransferValueScreenPresenterState>()!;
  }

  final Widget child;

  const GuessTransferValueScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<GuessTransferValueScreenPresenter> createState() => GuessTransferValueScreenPresenterState();
}

class GuessTransferValueScreenPresenterState extends State<GuessTransferValueScreenPresenter> {
  final random = Random();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<RandomPlayersBloc>().add(RandomPlayersEventGet(count: 1, hasTransferValue: true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
