part of 'random_football_players_bloc.dart';

sealed class RandomFootballPlayersEvent {}

final class RandomFootballPlayersEventGet extends RandomFootballPlayersEvent {
  final int count;
  final int? minPrimeTransferValue;
  final bool unique;
  final bool? withSponsor;
  final bool? withSecondCitizenship;
  final bool? withHeight;
  final bool? withPosition;
  final bool? withFoot;
  final bool? withTeamShirtNumber;
  final bool? withClubName;
  final bool? withAge;
  final bool? withJoinedClubOn;

  RandomFootballPlayersEventGet({
    required this.count,
    this.minPrimeTransferValue,
    this.unique = true,
    this.withSponsor,
    this.withSecondCitizenship,
    this.withHeight,
    this.withPosition,
    this.withFoot,
    this.withTeamShirtNumber,
    this.withClubName,
    this.withAge,
    this.withJoinedClubOn,
  });
}
