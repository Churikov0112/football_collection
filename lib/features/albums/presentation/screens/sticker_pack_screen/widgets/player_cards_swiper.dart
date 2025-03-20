part of '../sticker_pack_screen.dart';

class _PlayerCardsSwiper extends StatelessWidget {
  final List<PlayerModel> pack;

  const _PlayerCardsSwiper({
    required this.pack,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final presenter = StickerpackScreenPresenter.of(context);

    final backgroundHeight = mq.size.height - mq.padding.top - mq.padding.bottom - 56;

    return CardSwiper(
      onEnd: presenter.getNewPack,
      padding: EdgeInsets.only(
        left: (mq.size.width - packWidth) / 2,
        right: (mq.size.width - packWidth) / 2,
        top: backgroundHeight / 2 - packHeight / 2,
      ),
      isLoop: false,
      numberOfCardsDisplayed: 2,
      backCardOffset: Offset(20, 20),
      cardsCount: pack.length,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) => SavedPlayerCard(player: pack[index]),
      onSwipe: (previousIndex, currentIndex, direction) {
        presenter.savePlayer(pack[previousIndex]);
        return true;
      },
    );
  }
}
