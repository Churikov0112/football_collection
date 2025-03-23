part of 'all_countries_bloc.dart';

sealed class AllCountriesEvent {}

final class AllCountriesEventGet extends AllCountriesEvent {
  AllCountriesEventGet();
}
