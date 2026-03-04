import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'leaderboard_country_bloc_event.dart';
part 'leaderboard_country_bloc_state.dart';

const _kLeaderboardCountryNameKey = 'leaderboardCountryName';

@singleton
class LeaderboardCountryBloc extends HydratedBloc<LeaderboardCountryEvent, LeaderboardCountryState> {
  LeaderboardCountryBloc() : super(LeaderboardCountryStateInitial()) {
    on<LeaderboardCountryEvent>(
      (event, emit) => switch (event) {
        LeaderboardCountryEventSelect() => _select(event, emit),
      },
    );
  }

  Future<void> _select(LeaderboardCountryEventSelect event, Emitter<LeaderboardCountryState> emit) async {
    emit(LeaderboardCountryStateSelected(event.countryName));
  }

  @override
  LeaderboardCountryState? fromJson(Map<String, dynamic> json) {
    final countryName = json[_kLeaderboardCountryNameKey] as String?;
    if (countryName == null || countryName.isEmpty) {
      return LeaderboardCountryStateInitial();
    }
    return LeaderboardCountryStateSelected(countryName);
  }

  @override
  Map<String, dynamic>? toJson(LeaderboardCountryState state) {
    return {
      _kLeaderboardCountryNameKey: state.countryName,
    };
  }
}
