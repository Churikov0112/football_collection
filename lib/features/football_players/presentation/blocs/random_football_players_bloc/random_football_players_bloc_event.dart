part of 'random_football_players_bloc.dart';

sealed class RandomFootballPlayersEvent {}

final class RandomFootballPlayersEventGet extends RandomFootballPlayersEvent {
  final int count;
  final int? minPrimeTransferValue;

  RandomFootballPlayersEventGet({
    required this.count,
    this.minPrimeTransferValue,
  });
}
