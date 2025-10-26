part of '../draft_football_player_card.dart';

class _KitNumber extends StatelessWidget {
  const _KitNumber({
    required this.kitNumber,
  });

  final String kitNumber;

  @override
  Widget build(BuildContext context) {
    return
    // FrostedGlassContainer(
    //   // color: Colors.white,
    //   borderRadius: const BorderRadius.all(Radius.circular(12)),
    //   blupColor: Colors.white12,
    //   child:
    Text(
      "#$kitNumber",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 17,
      ),
      // ),
    );
  }
}
