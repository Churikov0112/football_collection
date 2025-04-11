part of 'first_launch_bloc.dart';

sealed class FirstLaunchEvent {}

final class FirstLaunchEventSet extends FirstLaunchEvent {
  final bool isFirstLaunch;
  FirstLaunchEventSet({
    required this.isFirstLaunch,
  });
}
