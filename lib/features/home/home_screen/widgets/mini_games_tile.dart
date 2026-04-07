part of '../home_screen.dart';

class _MiniGamesTile extends StatelessWidget {
  const _MiniGamesTile();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        context.push(RoutePaths.miniGames);
      },
      child: FrostedGlassContainer(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        blupColor: Colors.white10,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            border: Border.all(color: Colors.white54, width: 4), // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Colors.white.withOpacity(0.5),
            //     Colors.white.withOpacity(0.1),
            //     Colors.white.withOpacity(0.1),
            //     Colors.white.withOpacity(0.5),
            //   ],
            //   stops: const [0.0, 0.15, 0.85, 1.0],
            // ),
          ),
          child: SizedBox(
            width: size.width,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Translator(
                  termin: AppGlossary.miniGames,
                  builder: (value) => Text(
                    value,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
