part of '../sticker_pack_screen.dart';

class _PlayerCardsSwiper extends StatelessWidget {
  final List<PlayerModel> pack;

  const _PlayerCardsSwiper({
    required this.pack,
  });

  @override
  Widget build(BuildContext context) {
    final presenter = StickerpackScreenPresenter.of(context);

    return CardSwiper(
      onEnd: presenter.getNewPack,
      isLoop: false,
      cardsCount: pack.length,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) => SavedPlayerCard(player: pack[index]),
      onSwipe: (previousIndex, currentIndex, direction) {
        presenter.savePlayer(pack[previousIndex]);
        return true;
      },
    );
  }
}
