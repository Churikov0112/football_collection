part of 'enter_cheat_code_screen.dart';

const _kDisposableCheatCodes = <String>[
  "MONEY", // 1000
  "RABONA", // 500,
  "BICYCLE", // 500,
  "TRIVELLA", // 500,
  "SCORPION", // 500,
  "RESPECT", // 500,
  "RIP", // 500,
  "HATTRICK", // 500,
  "POKER", // 4000
  "PENTATRICK", // 5000
  "DARKHORSE", // 1000
  "QUATERFINAL", // 1000
  "SEMIFINAL", // 1000
  "FINAL", // 1000
  "GOAT", // 10000 карточек криша,
  "23", // 1000 карточек рональдиньо если кто-то забьет 23 гола
  "KLOSE", // 1000
];

class EnterCheatCodeScreenPresenter extends StatefulWidget {
  static EnterCheatCodeScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<EnterCheatCodeScreenPresenterState>()!;
  }

  final Widget child;

  const EnterCheatCodeScreenPresenter({required this.child, super.key});

  @override
  State<EnterCheatCodeScreenPresenter> createState() => EnterCheatCodeScreenPresenterState();
}

class EnterCheatCodeScreenPresenterState extends State<EnterCheatCodeScreenPresenter> {
  final TextEditingController cheatCodeTextEditingController = TextEditingController();

  void verifyCheatCode() async {
    final cheatCode = cheatCodeTextEditingController.value.text;

    try {
      FirebaseAnalytics.instance.logEvent(name: "cheat_code_entered", parameters: {"cheat_code": cheatCode});
    } catch (e) {
      LogService.error(e.toString(), e);
    }

    cheatCodeTextEditingController.clear();

    // if (cheatCode.contains("CLUB ")) {
    //   final club = cheatCode.replaceAll("CLUB ", "");
    //   final allPlayers = getIt.get<AllFootballPlayersBloc>().state.allPlayers ?? [];
    //   final List<FootballPlayerCardModel> clubPlayers = [];
    //   for (final player in allPlayers) {
    //     if (player.clubName == club) {
    //       clubPlayers.add(player);
    //     }
    //   }
    //   if (clubPlayers.isNotEmpty) {
    //     getIt.get<SavedCardsBloc>().add(SavedCardsEventAddAll(cardIds: clubPlayers.map((e) => e.cardId).toList()));
    //     ToastService.showToast(title: AppGlossary.cheatCodeActivated.translate(), seconds: 2);
    //     return;
    //   }
    // }
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
    if (cheatCode == "ALL") {
      final repo = getIt.get<CommonFootballRepository>();
      final allCards = await repo.getAllCards(cardTypes: CardType.values.toSet());
      if (allCards.isNotEmpty) {
        getIt.get<SavedCardsBloc>().add(SavedCardsEventAddAll(cardIds: allCards.map((e) => e.cardId).toList()));
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
