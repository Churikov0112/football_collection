part of 'enter_cheat_code_screen.dart';

class EnterCheatCodeScreenPresenter extends StatefulWidget {
  static EnterCheatCodeScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<EnterCheatCodeScreenPresenterState>()!;
  }

  final Widget child;

  const EnterCheatCodeScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<EnterCheatCodeScreenPresenter> createState() => EnterCheatCodeScreenPresenterState();
}

class EnterCheatCodeScreenPresenterState extends State<EnterCheatCodeScreenPresenter> {
  final TextEditingController cheatCodeTextEditingController = TextEditingController();

  void verifyCheatCode() {
    final cheatCode = cheatCodeTextEditingController.value.text;
    cheatCodeTextEditingController.clear();

    if (cheatCode.contains("CLUB ")) {
      final club = cheatCode.replaceAll("CLUB ", "");
      final allPlayers = getIt.get<AllPlayersBloc>().state.allPlayers ?? [];
      final List<PlayerModel> clubPlayers = [];
      for (final player in allPlayers) {
        if (player.currentClub == club) {
          clubPlayers.add(player);
        }
      }
      if (clubPlayers.isNotEmpty) {
        getIt.get<SavedPlayersBloc>().add(SavedPlayersEventAddAll(playerIds: clubPlayers.map((e) => e.id).toList()));
        ToastService.showToast(title: AppGlossary.cheatCodeActivated.translate());
        return;
      }
    }
    ToastService.showErrorToast(title: AppGlossary.cheatCodeNotFound.translate());
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
