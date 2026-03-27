part of '../onboarding_screen.dart';

class _OnboardingCardsSwiper extends StatefulWidget {
  final List<CardModel> cards;

  const _OnboardingCardsSwiper({required this.cards});

  @override
  State<_OnboardingCardsSwiper> createState() => _OnboardingCardsSwiperState();
}

class _OnboardingCardsSwiperState extends State<_OnboardingCardsSwiper> {
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
    final needConfetti = (player.maxMarketValue ?? 0) >= 50000000;
    if (needConfetti) Confetti.launch(context, options: const ConfettiOptions(particleCount: 100, spread: 70, y: 0.6));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final presenter = OnboardingScreenPresenter.of(context);

    final backgroundHeight = mq.size.height - mq.padding.top - mq.padding.bottom - 56;

    return CardSwiper(
      onEnd: () {
        presenter.onboardingController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      padding: EdgeInsets.only(
        left: (mq.size.width - packWidth - 25) / 2,
        right: (mq.size.width - packWidth - 25) / 2,
        top: backgroundHeight / 2,
      ),
      isLoop: false,
      numberOfCardsDisplayed: 2,
      backCardOffset: Offset(20, 20),
      cardsCount: widget.cards.length,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
        final player = widget.cards[index] as FootballPlayerCardModel;
        return FootballPlayerCard(player: player, count: 1, hideTransferValue: false, showNew: true);
      },
      onSwipe: (previousIndex, currentIndex, direction) async {
        final prevPlayer = widget.cards[previousIndex] as FootballPlayerCardModel;
        final currentPlayer = currentIndex != null ? widget.cards[currentIndex] as FootballPlayerCardModel : null;
        getIt.get<SavedCardsBloc>().add(SavedCardsEventAdd(cardId: prevPlayer.cardId));
        if (currentPlayer != null) unawaited(checkConfetti(currentPlayer));
        return true;
      },
    );
  }
}
