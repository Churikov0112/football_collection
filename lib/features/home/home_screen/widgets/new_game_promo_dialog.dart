part of '../home_screen.dart';

class _NewGamePromoDialog extends StatelessWidget {
  const _NewGamePromoDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/raster/icon/icon.png'))),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              AppGlossary.newGamePromoTitle.translate(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              AppGlossary.newGamePromoSubtitle.translate(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.4),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: context.pop,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white38),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(AppGlossary.later.translate()),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                      getIt.get<PromoBloc>().add(PromoEventSetDownloaded(isDownloadClicked: true));
                      launchUrl(
                        Uri.parse('https://football-collection-c7c28.web.app/ru/games/world_cup_collection_2026/'),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(AppGlossary.download.translate(), style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
