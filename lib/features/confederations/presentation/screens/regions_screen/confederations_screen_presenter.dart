part of 'confederations_screen.dart';

class ConfederationsScreenPresenter extends StatefulWidget {
  static ConfederationsScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<ConfederationsScreenPresenterState>()!;
  }

  final Widget child;

  const ConfederationsScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<ConfederationsScreenPresenter> createState() => ConfederationsScreenPresenterState();
}

class ConfederationsScreenPresenterState extends State<ConfederationsScreenPresenter> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getIt.get<ConfederationsBloc>().add(ConfederationsEventGet());
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
