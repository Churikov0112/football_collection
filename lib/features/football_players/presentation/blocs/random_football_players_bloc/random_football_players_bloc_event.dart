part of 'random_football_players_bloc.dart';

sealed class RandomFootballPlayersEvent {}

final class RandomFootballPlayersEventGet extends RandomFootballPlayersEvent {
  final int count;
  final int? minPrimeTransferValue;
  final bool unique;

  RandomFootballPlayersEventGet({
    required this.count,
    this.minPrimeTransferValue,
    this.unique = true,
  });
}
