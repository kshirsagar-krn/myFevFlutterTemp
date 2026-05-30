import 'package:flutter/material.dart';
import '../../../../data/models/country_model.dart';

@immutable
sealed class CountryState {}

final class CountryInitial extends CountryState {}

final class CountryLoading extends CountryState {}

final class CountrySuccess extends CountryState {
  final List<CountryModel> countryModel;
  CountrySuccess({required this.countryModel});
}

final class CountryFailure extends CountryState {
  final dynamic error;

  CountryFailure(this.error);
}
