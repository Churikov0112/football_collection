part of 'stickerpack_bloc.dart';

sealed class StickerpackState {
  List<PlayerModel>? get pack {
    return switch (this) {
      StickerpackStateLoadSucceeded() => (this as StickerpackStateLoadSucceeded)._pack,
      _ => null,
    };
  }
}

final class StickerpackStateInitial extends StickerpackState {
  StickerpackStateInitial();
}

final class StickerpackStatePending extends StickerpackState {
  StickerpackStatePending();
}

final class StickerpackStateLoadSucceeded extends StickerpackState {
  final List<PlayerModel> _pack;
  StickerpackStateLoadSucceeded(this._pack);
}

final class StickerpackStateFailed extends StickerpackState {
  final String reason;
  StickerpackStateFailed(this.reason);
}
