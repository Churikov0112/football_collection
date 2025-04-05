part of '../open_pack_screen.dart';

class _PlayerCardsSwiper extends StatelessWidget {
  final List<PlayerModel> players;

  const _PlayerCardsSwiper({
    required this.players,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final presenter = OpenPackScreenPresenter.of(context);

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
      cardsCount: players.length,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) => SavedPlayerCard(
        player: players[index],
        count: 1,
        hideTransferValue: false,
      ),
      onSwipe: (previousIndex, currentIndex, direction) {
        presenter.savePlayer(players[previousIndex]);
        return true;
      },
    );
  }
}
