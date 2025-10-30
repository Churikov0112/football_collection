part of '../football_player_screen.dart';

class _Name extends StatelessWidget {
  const _Name({required this.name, required this.isFake, required this.hide});

  final String name;
  final bool isFake;
  final bool hide;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
        color: Colors.white12,
      ),
      child: SizedBox(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: AutoSizeText(
              name.toUpperCase(),
              maxLines: 1,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
