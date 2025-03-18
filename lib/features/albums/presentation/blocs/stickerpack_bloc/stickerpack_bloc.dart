import 'package:bloc/bloc.dart';
import 'package:football_collection/features/albums/data/players_repository.dart';
import 'package:football_collection/features/albums/domain/models/player.dart';

part 'stickerpack_bloc_event.dart';
part 'stickerpack_bloc_state.dart';

class StickerpackBloc extends Bloc<StickerpackEvent, StickerpackState> {
  final PlayersRepository _repository;

  StickerpackBloc(this._repository) : super(StickerpackStateInitial()) {
    on<StickerpackEvent>(
      (event, emitter) => switch (event) {
        StickerpackEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    StickerpackEventGet event,
    Emitter<StickerpackState> emit,
  ) async {
    try {
      emit(StickerpackStatePending());
      final players = await _repository.getRandomPlayers(5);
      emit(StickerpackStateLoadSucceeded(players));
    } on Object catch (_) {
      emit(StickerpackStateFailed('Произошла ошибка'));
    }
  }
}
