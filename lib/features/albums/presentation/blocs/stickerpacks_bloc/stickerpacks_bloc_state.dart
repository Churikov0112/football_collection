part of 'stickerpacks_bloc.dart';

sealed class StickerpacksState {
  List<PackModel>? get packs {
    return switch (this) {
      StickerpacksStateLoadSucceeded() => (this as StickerpacksStateLoadSucceeded)._packs,
      _ => null,
    };
  }
}

final class StickerpacksStateInitial extends StickerpacksState {
  StickerpacksStateInitial();
}

final class StickerpacksStatePending extends StickerpacksState {
  StickerpacksStatePending();
}

final class StickerpacksStateLoadSucceeded extends StickerpacksState {
  final List<PackModel> _packs;
  StickerpacksStateLoadSucceeded(this._packs);
}

final class StickerpacksStateFailed extends StickerpacksState {
  final String reason;
  StickerpacksStateFailed(this.reason);
}
