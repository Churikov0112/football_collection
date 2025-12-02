part of '../small_draft_football_player_card.dart';

class _TeamLogoWidget extends StatelessWidget {
  const _TeamLogoWidget({required this.currentClub, required this.size});

  final String currentClub;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(currentClub, maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}
