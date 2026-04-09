part of 'random_football_clubs_bloc.dart';

sealed class RandomFootballClubsEvent {}

final class RandomFootballClubsEventGet extends RandomFootballClubsEvent {
  RandomFootballClubsEventGet({
    required this.count,
    this.withStadiumName,
    this.withStadiumSeats,
    this.withLeague,
    this.withFoundedOn,
  });

  final int count;
  final bool? withStadiumName;
  final bool? withStadiumSeats;
  final bool? withLeague;
  final bool? withFoundedOn;
}
