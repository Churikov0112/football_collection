part of 'promo_bloc.dart';

sealed class PromoState {
  bool? get isDownloadClicked {
    return switch (this) {
      PromoStateReady() => (this as PromoStateReady)._isDownloadClicked,
    };
  }
}

final class PromoStateReady extends PromoState {
  final bool _isDownloadClicked;
  PromoStateReady(this._isDownloadClicked);
}
