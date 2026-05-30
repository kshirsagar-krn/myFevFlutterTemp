import 'package:flutter/material.dart';

@immutable
sealed class CountryEvent {}

class FetchCountry extends CountryEvent {}
