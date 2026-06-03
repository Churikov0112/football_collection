part of 'promo_bloc.dart';

sealed class PromoEvent {}

final class PromoEventSetDownloaded extends PromoEvent {
  final bool isDownloadClicked;
  PromoEventSetDownloaded({required this.isDownloadClicked});
}
