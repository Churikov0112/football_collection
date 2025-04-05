part of 'get_player_by_qr_screen.dart';

class GetPlayerByQrScreenPresenter extends StatefulWidget {
  static GetPlayerByQrScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GetPlayerByQrScreenPresenterState>()!;
  }

  final Widget child;

  const GetPlayerByQrScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<GetPlayerByQrScreenPresenter> createState() => GetPlayerByQrScreenPresenterState();
}

class GetPlayerByQrScreenPresenterState extends State<GetPlayerByQrScreenPresenter> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
