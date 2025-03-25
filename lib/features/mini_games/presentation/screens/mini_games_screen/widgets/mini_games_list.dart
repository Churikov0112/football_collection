part of '../mini_games_screen.dart';

class _MiniGamesList extends StatelessWidget {
  const _MiniGamesList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 120),
        children: [
          _MiniGameTile(
            title: "Guess transfer value",
            onTap: () {
              context.push(RoutePaths.miniGameGuessTransferValue);
            },
          ),
          _MiniGameTile(
            title: "Transfer value less/more",
            onTap: () {},
          ),
          _MiniGameTile(
            title: "Guess national team",
            onTap: () {},
          ),
          _MiniGameTile(
            title: "Guess player by properties",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _MiniGameTile extends StatelessWidget {
  const _MiniGameTile({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.blue.shade900,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
