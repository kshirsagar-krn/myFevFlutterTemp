import 'package:flutter/material.dart';
import '../../../../data/models/city_model.dart';

@immutable
sealed class CitysState {}

final class CityInitial extends CitysState {}

final class CityLoading extends CitysState {}

final class CitySuccess extends CitysState {
  final List<CityModel> cityModel;
  CitySuccess({required this.cityModel});
}

final class CityFailure extends CitysState {
  final dynamic error;

  CityFailure(this.error);
}
