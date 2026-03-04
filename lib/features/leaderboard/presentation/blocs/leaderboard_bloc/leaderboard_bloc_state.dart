part of 'leaderboard_bloc.dart';

sealed class LeaderboardState {
  List<LeaderboardEntry>? get entries {
    return switch (this) {
      LeaderboardStateLoadSucceeded() => (this as LeaderboardStateLoadSucceeded)._entries,
      _ => null,
    };
  }
}

final class LeaderboardStateInitial extends LeaderboardState {
  LeaderboardStateInitial();
}

final class LeaderboardStatePending extends LeaderboardState {
  LeaderboardStatePending();
}

final class LeaderboardStateLoadSucceeded extends LeaderboardState {
  final List<LeaderboardEntry> _entries;
  LeaderboardStateLoadSucceeded(this._entries);
}

final class LeaderboardStateFailed extends LeaderboardState {
  final String reason;
  LeaderboardStateFailed(this.reason);
}
