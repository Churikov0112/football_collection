part of 'enter_cheat_code_screen.dart';

enum DisposableCheatCode {
  money(code: "MONEY"),
  rabona(code: "RABONA"),
  bicycle(code: "BICYCLE"),
  trivella(code: "TRIVELLA"),
  scorpion(code: "SCORPION"),
  respect(code: "RESPECT"),
  rip(code: "RIP"),
  hatrick(code: "HATTRICK"),
  poker(code: "POKER"),
  pentatrick(code: "PENTATRICK"),
  darkhorse(code: "DARKHORSE"),
  quaterfinal(code: "QUATERFINAL"),
  semifinal(code: "SEMIFINAL"),
  $final(code: "FINAL"),
  goat(code: "GOAT"),
  ronaldinho23(code: "RONALDINHO23"),
  klose(code: "KLOSE")
  ;

  const DisposableCheatCode({required this.code});

  final String code;
}

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

  Future<void> verifyCheatCode() async {
    final cheatCode = cheatCodeTextEditingController.value.text;

    try {
      unawaited(FirebaseAnalytics.instance.logEvent(name: "cheat_code_entered", parameters: {"cheat_code": cheatCode}));
    } catch (e) {
      LogService.error(e.toString(), e);
    }

    cheatCodeTextEditingController.clear();

    final cheatCodesHistoryBloc = getIt.get<CheatCodesHistoryBloc>();
    // проверка на одноразовость
    if (DisposableCheatCode.values.map((e) => e.code).toList().contains(cheatCode)) {
      // проверка, что код еще не использовался
      final cheatCodesHistory = cheatCodesHistoryBloc.state.history ?? [];
      if (cheatCodesHistory.contains(cheatCode)) {
        ToastService.showToast(title: AppGlossary.cheatCodeAlreadyUsed.translate(), seconds: 2);
        return;
      } else {
        if (cheatCode == DisposableCheatCode.money.code) {
          _increaseBalance(1000);
        }
        if (cheatCode == DisposableCheatCode.rabona.code) {
          _increaseBalance(500);
        }
        if (cheatCode == DisposableCheatCode.bicycle.code) {
          _increaseBalance(500);
        }
        if (cheatCode == DisposableCheatCode.trivella.code) {
          _increaseBalance(500);
        }
        if (cheatCode == DisposableCheatCode.scorpion.code) {
          _increaseBalance(500);
        }
        if (cheatCode == DisposableCheatCode.respect.code) {
          _increaseBalance(500);
        }
        if (cheatCode == DisposableCheatCode.rip.code) {
          _increaseBalance(500);
        }
        if (cheatCode == DisposableCheatCode.hatrick.code) {
          _increaseBalance(500);
        }
        if (cheatCode == DisposableCheatCode.poker.code) {
          _increaseBalance(4000);
        }
        if (cheatCode == DisposableCheatCode.pentatrick.code) {
          _increaseBalance(5000);
        }
        if (cheatCode == DisposableCheatCode.darkhorse.code) {
          _increaseBalance(1000);
        }
        if (cheatCode == DisposableCheatCode.quaterfinal.code) {
          _increaseBalance(1000);
        }
        if (cheatCode == DisposableCheatCode.semifinal.code) {
          _increaseBalance(1000);
        }
        if (cheatCode == DisposableCheatCode.$final.code) {
          _increaseBalance(1000);
        }
        if (cheatCode == DisposableCheatCode.goat.code) {
          _increaseBalance(10000);
          _getCard("8198");
        }
        if (cheatCode == DisposableCheatCode.ronaldinho23.code) {
          _increaseBalance(10000);
          _getCard("3373");
        }
        if (cheatCode == DisposableCheatCode.klose.code) {
          _increaseBalance(1000);
          _getCard("10");
        }

        _onCheatCodeVerified(cheatCode);
        return;
      }
    }

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

    final repo = getIt.get<CommonFootballRepository>();
    final savedCardsIds = getIt.get<SavedCardsBloc>().state.savedCardsIds ?? [];

    if (cheatCode.contains(CardType.player.name) ||
        cheatCode.contains(CardType.legend.name) ||
        cheatCode.contains(CardType.coach.name) ||
        cheatCode.contains(CardType.emblem.name)) {
      final cards = await repo.getCards(
        id: cheatCode,
        cardTypes: {
          if (cheatCode.contains(CardType.player.name)) ...{.player},
          if (cheatCode.contains(CardType.legend.name)) ...{.legend},
          if (cheatCode.contains(CardType.coach.name)) ...{.coach},
          if (cheatCode.contains(CardType.emblem.name)) ...{.emblem},
        },
      );
      final cardId = cards.firstOrNull?.cardId;
      if (cardId == null) {
        ToastService.showErrorToast(title: AppGlossary.cheatCodeNotFound.translate(), seconds: 2);
        return;
      } else {
        if (savedCardsIds.contains(cardId)) {
          ToastService.showErrorToast(title: AppGlossary.alreadyInCollection.translate(), seconds: 2);
          return;
        }
        getIt.get<SavedCardsBloc>().add(SavedCardsEventAdd(cardId: cardId));
        _onCheatCodeVerified(cheatCode);
        return;
      }
    }

    if (kDebugMode) {
      if (cheatCode.contains("BALANCE ")) {
        final balanceString = cheatCode.replaceAll("BALANCE ", "");
        final valueToAdd = int.tryParse(balanceString);
        if (valueToAdd is int && valueToAdd > 0) {
          getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: valueToAdd));
          _onCheatCodeVerified(cheatCode);
          return;
        }
      }
      if (cheatCode == "ALL") {
        final repo = getIt.get<CommonFootballRepository>();
        final allCards = await repo.getCards(cardTypes: CardType.values.toSet());
        if (allCards.isNotEmpty) {
          getIt.get<SavedCardsBloc>().add(SavedCardsEventAddAll(cardIds: allCards.map((e) => e.cardId).toList()));
          _onCheatCodeVerified(cheatCode);
          return;
        }
      }
    }

    ToastService.showErrorToast(title: AppGlossary.cheatCodeNotFound.translate(), seconds: 2);
  }

  void _increaseBalance(int amount) {
    getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: amount));
  }

  void _getCard(String id) {
    getIt.get<SavedCardsBloc>().add(SavedCardsEventAdd(cardId: id));
  }

  void _onCheatCodeVerified(String code) {
    getIt.get<CheatCodesHistoryBloc>().add(CheatCodesHistoryEventAdd(code: code));
    ToastService.showToast(title: AppGlossary.cheatCodeActivated.translate(), seconds: 2);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
