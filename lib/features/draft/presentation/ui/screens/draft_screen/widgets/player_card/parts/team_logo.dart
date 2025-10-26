part of '../draft_football_player_card.dart';

class _TeamLogoWidget extends StatelessWidget {
  const _TeamLogoWidget({required this.teamId, required this.size});

  final String teamId;
  final double size;

  @override
  Widget build(BuildContext context) {
    final emoji = emojiFlagByCountryName(teamId);
    return Text(emoji ?? teamId, style: TextStyle(fontSize: size));
  }
}
