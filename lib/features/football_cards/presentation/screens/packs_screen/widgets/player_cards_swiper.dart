part of '../football_players_packs_screen.dart';

class _PlayerCardsSwiper extends StatefulWidget {
  final List<CardModel> cards;
  final String packName;

  const _PlayerCardsSwiper({required this.cards, required this.packName});

  @override
  State<_PlayerCardsSwiper> createState() => _PlayerCardsSwiperState();
}

class _PlayerCardsSwiperState extends State<_PlayerCardsSwiper> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final firstCard = widget.cards.firstOrNull;
        if (firstCard != null) checkConfetti(firstCard);
      }
    });
  }

  Future<void> checkConfetti(CardModel card) async {
    final settings = getIt.get<SettingsBloc>().state;
    if (!settings.enableConfetti) return;

    if (card is FootballPlayerCardModel) {
      final needConfetti = (card.maxMarketValue ?? 0) >= 50000000;
      if (needConfetti) {
        Confetti.launch(context, options: const ConfettiOptions(particleCount: 100, spread: 70, y: 0.6));
      }
    }

    if (card is FootballLegendCardModel || card is FootballTeamEmblemCardModel) {
      Confetti.launch(
        context,
        options: const ConfettiOptions(particleCount: 100, spread: 70, y: 0.6, colors: goldConfettiColors),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final presenter = FootballPlayersPacksScreenPresenter.of(context);

    final backgroundHeight = mq.size.height - mq.padding.top - mq.padding.bottom - 56;

    return CardSwiper(
      onEnd: () => presenter.showReceivedCards(widget.cards, widget.packName),
      padding: EdgeInsets.only(
        left: (mq.size.width - packWidth * 1) / 2,
        right: (mq.size.width - packWidth * 1) / 2,
        top: (backgroundHeight - packHeight / 3) / 2,
      ),
      isLoop: false,
      numberOfCardsDisplayed: 2,
      backCardOffset: Offset(20, 20),
      cardsCount: widget.cards.length,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
        final card = widget.cards[index];
        final isNewCard = presenter._newCardIdsForOpenedPack.contains(card.cardId);

        if (card is FootballPlayerCardModel) {
          return FootballPlayerCardWidget(
            height: packHeight * 1,
            width: packWidth * 1,
            player: card,
            badge: isNewCard ? .showNew : .none,
          );
        }
        if (card is FootballLegendCardModel) {
          return FootballLegendCardWidget(
            height: packHeight * 1,
            width: packWidth * 1,
            legend: card,
            badge: isNewCard ? .showNew : .none,
          );
        }
        if (card is FootballCoachCardModel) {
          return FootballCoachCardWidget(
            height: packHeight * 1,
            width: packWidth * 1,
            coach: card,
            badge: isNewCard ? .showNew : .none,
          );
        }
        if (card is FootballTeamEmblemCardModel) {
          return FootballTeamEmblemCardWidget(
            height: packHeight * 1,
            width: packWidth * 1,
            emblem: card,
            badge: isNewCard ? .showNew : .none,
          );
        }
        return SizedBox.shrink();
      },
      onSwipe: (previousIndex, currentIndex, direction) async {
        final currentCard = currentIndex != null ? widget.cards[currentIndex] : null;
        if (currentCard != null) {
          unawaited(checkConfetti(currentCard));
        }
        return true;
      },
    );
  }
}
