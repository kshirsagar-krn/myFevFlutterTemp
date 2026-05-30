import 'package:flutter/material.dart';

@immutable
sealed class CityEvent {}

class FetchCitys extends CityEvent {
  final String? id;
  FetchCitys({required this.id});
}
