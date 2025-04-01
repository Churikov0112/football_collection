import 'package:bloc/bloc.dart';
import 'package:football_collection/features/confederations/domain/models/confederation.dart';
import 'package:football_collection/features/players/domain/models/pack.dart';
import 'package:injectable/injectable.dart';

import '../../../../countries/domain/models/country.dart';
import '../../../data/players_repository.dart';

part 'stickerpacks_bloc_event.dart';
part 'stickerpacks_bloc_state.dart';

@singleton
class StickerpacksBloc extends Bloc<StickerpacksEvent, StickerpacksState> {
  final PlayersRepository _repository;

  StickerpacksBloc(this._repository) : super(StickerpacksStateInitial()) {
    on<StickerpacksEvent>(
      (event, emitter) => switch (event) {
        StickerpacksEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    StickerpacksEventGet event,
    Emitter<StickerpacksState> emit,
  ) async {
    try {
      emit(StickerpacksStatePending());
      final packs = await _repository.getPacks(
        country: event.country,
        confederation: event.confederation,
      );
      emit(StickerpacksStateLoadSucceeded(packs));
    } on Object catch (_) {
      emit(StickerpacksStateFailed('Произошла ошибка'));
    }
  }
}
