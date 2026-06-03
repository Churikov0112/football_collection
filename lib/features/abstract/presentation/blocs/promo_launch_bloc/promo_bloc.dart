import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'promo_bloc_event.dart';
part 'promo_bloc_state.dart';

@singleton
class PromoBloc extends HydratedBloc<PromoEvent, PromoState> {
  PromoBloc() : super(PromoStateReady(false)) {
    on<PromoEvent>(
      (event, emitter) => switch (event) {
        PromoEventSetDownloaded() => _setDownloaded(event, emitter),
      },
    );
  }

  Future<void> _setDownloaded(PromoEventSetDownloaded event, Emitter<PromoState> emit) async {
    try {
      emit(PromoStateReady(event.isDownloadClicked));
    } on Object catch (_) {
      emit(PromoStateReady(false));
    }
  }

  @override
  PromoState fromJson(Map<String, dynamic> json) {
    try {
      if (json[_kIsDownloadClickedKey] != null) {
        return PromoStateReady(json[_kIsDownloadClickedKey]);
      }
      return PromoStateReady(false);
    } catch (e) {
      return PromoStateReady(true);
    }
  }

  @override
  Map<String, dynamic>? toJson(PromoState state) {
    return {_kIsDownloadClickedKey: state.isDownloadClicked};
  }
}

const _kIsDownloadClickedKey = 'isDownloadClicked';
