import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../services/firebase/firestore_service.dart';
import '../../../domain/models/leaderboard_entry.dart';

part 'leaderboard_bloc_event.dart';
part 'leaderboard_bloc_state.dart';

@singleton
class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  LeaderboardBloc(this._firestoreService) : super(LeaderboardStateInitial()) {
    on<LeaderboardEvent>(
      (event, emit) => switch (event) {
        LeaderboardEventLoad() => _load(emit),
        LeaderboardEventRefresh() => _refresh(emit),
      },
    );
  }

  final FirestoreService _firestoreService;

  Future<void> _load(Emitter<LeaderboardState> emit) async {
    try {
      emit(LeaderboardStatePending());
      final entries = await _firestoreService.getLeaderboard();
      emit(LeaderboardStateLoadSucceeded(entries));
    } on Object catch (e) {
      emit(LeaderboardStateFailed(e.toString()));
    }
  }

  Future<void> _refresh(Emitter<LeaderboardState> emit) async {
    try {
      final entries = await _firestoreService.getLeaderboard();
      emit(LeaderboardStateLoadSucceeded(entries));
    } on Object catch (e) {
      emit(LeaderboardStateFailed(e.toString()));
    }
  }
}
