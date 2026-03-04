part of 'leaderboard_bloc.dart';

sealed class LeaderboardEvent {}

final class LeaderboardEventLoad extends LeaderboardEvent {
  LeaderboardEventLoad();
}

final class LeaderboardEventRefresh extends LeaderboardEvent {
  LeaderboardEventRefresh();
}
