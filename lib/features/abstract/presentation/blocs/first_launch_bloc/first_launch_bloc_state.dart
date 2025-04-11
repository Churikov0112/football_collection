part of 'first_launch_bloc.dart';

sealed class FirstLaunchState {
  bool? get isFirstLaunch {
    return switch (this) {
      FirstLaunchStateReady() => (this as FirstLaunchStateReady)._isFirstLaunch,
    };
  }
}

final class FirstLaunchStateReady extends FirstLaunchState {
  final bool _isFirstLaunch;
  FirstLaunchStateReady(this._isFirstLaunch);
}
