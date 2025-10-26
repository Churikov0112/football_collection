part of '../draft_screen.dart';

class _SchemeSelector extends StatelessWidget {
  const _SchemeSelector();

  @override
  Widget build(BuildContext context) {
    final presenter = DraftScreenPresenter.of(context);
    final mq = MediaQuery.of(context);

    return StreamBuilder(
      stream: presenter.scheme$,
      builder: (context, schemeSnapshot) {
        final scheme = schemeSnapshot.data;

        if (scheme == null) {
          return const SizedBox.shrink();
        }

        return Row(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                final previousScheme = FootballScheme.values[(scheme.index - 1) % FootballScheme.values.length];
                presenter.setScheme(previousScheme);
              },
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: SizedBox(
                  width: mq.size.width * 0.25,
                  child: Center(
                    child: Text(
                      scheme.humanReadable,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final nextScheme = FootballScheme.values[(scheme.index + 1) % FootballScheme.values.length];
                presenter.setScheme(nextScheme);
              },
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
