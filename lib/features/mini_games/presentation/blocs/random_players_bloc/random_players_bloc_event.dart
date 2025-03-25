part of 'random_players_bloc.dart';

sealed class RandomPlayersEvent {}

final class RandomPlayersEventGet extends RandomPlayersEvent {
  final int count;
  final bool? hasTransferValue;

  RandomPlayersEventGet({
    required this.count,
    this.hasTransferValue,
  });
}
