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

    try {
      FirebaseAnalytics.instance.logEvent(
        name: "cheat_code_entered",
        parameters: {
          "cheat_code": cheatCode,
        },
      );
    } catch (e) {
      LogService.error(e.toString(), e);
    }

    cheatCodeTextEditingController.clear();

    if (cheatCode.contains("CLUB ")) {
      final club = cheatCode.replaceAll("CLUB ", "");
      final allPlayers = getIt.get<AllFootballPlayersBloc>().state.allPlayers ?? [];
      final List<FootballPlayerModel> clubPlayers = [];
      for (final player in allPlayers) {
        if (player.currentClub == club) {
          clubPlayers.add(player);
        }
      }
      if (clubPlayers.isNotEmpty) {
        getIt.get<SavedCardsBloc>().add(SavedCardsEventAddAll(cardIds: clubPlayers.map((e) => e.cardId).toList()));
        ToastService.showToast(title: AppGlossary.cheatCodeActivated.translate(), seconds: 2);
        return;
      }
    }
    // TODO remove
    if (cheatCode.contains("BALANCE ")) {
      final balanceString = cheatCode.replaceAll("BALANCE ", "");
      final valueToAdd = int.tryParse(balanceString);
      if (valueToAdd is int && valueToAdd > 0) {
        getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: valueToAdd));
        ToastService.showToast(title: AppGlossary.cheatCodeActivated.translate(), seconds: 2);
        return;
      }
    }
    ToastService.showErrorToast(title: AppGlossary.cheatCodeNotFound.translate(), seconds: 2);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
