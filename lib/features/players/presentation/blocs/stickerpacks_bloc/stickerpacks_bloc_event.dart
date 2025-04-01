part of 'stickerpacks_bloc.dart';

sealed class StickerpacksEvent {}

final class StickerpacksEventGet extends StickerpacksEvent {
  final CountryModel? country;
  final Confederations? confederation;

  StickerpacksEventGet({
    this.country,
    this.confederation,
  });
}
