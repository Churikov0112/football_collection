part of 'regions_bloc.dart';

sealed class RegionsState {
  List<RegionModel>? get regions {
    return switch (this) {
      RegionsStateLoadSucceeded() => (this as RegionsStateLoadSucceeded)._regions,
      _ => null,
    };
  }
}

final class RegionsStateInitial extends RegionsState {
  RegionsStateInitial();
}

final class RegionsStatePending extends RegionsState {
  RegionsStatePending();
}

final class RegionsStateLoadSucceeded extends RegionsState {
  final List<RegionModel> _regions;
  RegionsStateLoadSucceeded(this._regions);
}

final class RegionsStateFailed extends RegionsState {
  final String reason;
  RegionsStateFailed(this.reason);
}
