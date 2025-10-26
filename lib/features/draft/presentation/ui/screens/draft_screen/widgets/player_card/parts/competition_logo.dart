part of '../draft_football_player_card.dart';

class _CompetitionLogoWidget extends StatelessWidget {
  const _CompetitionLogoWidget({
    required this.competitionId,
    required this.size,
  });

  final String competitionId;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CommunityDataPackBuilder(
      builder: (pack) {
        if (pack?.id != "0") {
          return _FakeCompetitionLogo(competitionId: competitionId);
        }
        return Image.asset(
          'assets/raster/sofifa_competitions/$competitionId.png',
          height: size,
          width: size,
        );
      },
    );
  }
}

class _FakeCompetitionLogo extends StatelessWidget {
  const _FakeCompetitionLogo({
    required this.competitionId,
  });

  final String competitionId;

  @override
  Widget build(BuildContext context) {
    final competitionPalette = competitionPaletteById(competitionId);

    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: competitionPalette?.firstOrNull,
        border: Border.all(color: competitionPalette?[1] ?? Colors.black, width: 4),
      ),
      child: SizedBox.square(
        dimension: 32,
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: competitionPalette?.lastOrNull,
            ),
            child: const SizedBox.square(dimension: 12),
          ),
        ),
      ),
    );
  }
}
