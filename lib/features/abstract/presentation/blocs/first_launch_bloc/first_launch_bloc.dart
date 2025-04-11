import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'first_launch_bloc_event.dart';
part 'first_launch_bloc_state.dart';

@singleton
class FirstLaunchBloc extends HydratedBloc<FirstLaunchEvent, FirstLaunchState> {
  FirstLaunchBloc() : super(FirstLaunchStateReady(true)) {
    on<FirstLaunchEvent>(
      (event, emitter) => switch (event) {
        FirstLaunchEventSet() => _set(event, emitter),
      },
    );
  }

  Future<void> _set(
    FirstLaunchEventSet event,
    Emitter<FirstLaunchState> emit,
  ) async {
    try {
      emit(FirstLaunchStateReady(event.isFirstLaunch));
    } on Object catch (_) {
      emit(FirstLaunchStateReady(true));
    }
  }

  @override
  FirstLaunchState fromJson(Map<String, dynamic> json) {
    try {
      if (json[_kIsFirstLaunchKey] != null) {
        final isFirstLaunch = json[_kIsFirstLaunchKey];
        return FirstLaunchStateReady(isFirstLaunch);
      }
      return FirstLaunchStateReady(true);
    } catch (e) {
      return FirstLaunchStateReady(true);
    }
  }

  @override
  Map<String, dynamic>? toJson(FirstLaunchState state) {
    final json = {
      _kIsFirstLaunchKey: state.isFirstLaunch,
    };
    return json;
  }
}

const _kIsFirstLaunchKey = 'isFirstLaunch';
