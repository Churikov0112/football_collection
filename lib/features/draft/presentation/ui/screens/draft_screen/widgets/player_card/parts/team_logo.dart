part of '../draft_football_player_card.dart';

class _TeamLogoWidget extends StatelessWidget {
  const _TeamLogoWidget({
    required this.teamId,
    required this.size,
  });

  final String teamId;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CommunityDataPackBuilder(
      builder: (pack) {
        if (pack?.id != "0") {
          return _FakeTeamLogo(
            teamId: teamId,
            size: size,
          );
        }
        return Image.asset(
          'assets/raster/sofifa_teams/$teamId.png',
          height: size,
          width: size,
        );
      },
    );
  }
}

class _FakeTeamLogo extends StatelessWidget {
  const _FakeTeamLogo({
    required this.teamId,
    required this.size,
  });

  final String teamId;
  final double size;

  @override
  Widget build(BuildContext context) {
    final teamPalette = teamPaletteById(teamId);

    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: teamPalette?.firstOrNull,
        border: Border.all(color: teamPalette?[1] ?? Colors.black, width: size / 8),
      ),
      child: SizedBox.square(
        dimension: size,
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: teamPalette?.lastOrNull,
            ),
            child: SizedBox.square(dimension: size / 3),
          ),
        ),
      ),
    );
  }
}
