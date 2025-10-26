part of '../football_players_packs_screen.dart';

class _PlayerCardsSwiper extends StatefulWidget {
  final List<CardModel> cards;

  const _PlayerCardsSwiper({required this.cards});

  @override
  State<_PlayerCardsSwiper> createState() => _PlayerCardsSwiperState();
}

class _PlayerCardsSwiperState extends State<_PlayerCardsSwiper> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final firstPlayer = (widget.cards.firstOrNull as FootballPlayerCardModel?);
        if (firstPlayer != null) checkConfetti(firstPlayer);
      }
    });
  }

  Future<void> checkConfetti(FootballPlayerCardModel player) async {
    final settings = getIt.get<SettingsBloc>().state;
    if (!settings.enableConfetti) return;
    final needConfetti = (player.maxMarketValue ?? 0) >= 50000000;
    if (needConfetti) Confetti.launch(context, options: const ConfettiOptions(particleCount: 100, spread: 70, y: 0.6));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final presenter = FootballPlayersPacksScreenPresenter.of(context);

    final backgroundHeight = mq.size.height - mq.padding.top - mq.padding.bottom - 56;

    return CardSwiper(
      onEnd: presenter.getNewPacks,
      padding: EdgeInsets.only(
        left: (mq.size.width - packWidth) / 2,
        right: (mq.size.width - packWidth) / 2,
        top: backgroundHeight / 2,
      ),
      isLoop: false,
      numberOfCardsDisplayed: 2,
      backCardOffset: Offset(20, 20),
      cardsCount: widget.cards.length,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
        final player = widget.cards[index] as FootballPlayerCardModel;
        return FootballPlayerCard(player: player, count: 1, hideTransferValue: false);
      },
      onSwipe: (previousIndex, currentIndex, direction) async {
        final prevPlayer = widget.cards[previousIndex] as FootballPlayerCardModel;
        final currentPlayer = currentIndex != null ? widget.cards[currentIndex] as FootballPlayerCardModel : null;
        presenter.savePlayer(prevPlayer);
        if (currentPlayer != null) unawaited(checkConfetti(currentPlayer));
        return true;
      },
    );
  }
}
