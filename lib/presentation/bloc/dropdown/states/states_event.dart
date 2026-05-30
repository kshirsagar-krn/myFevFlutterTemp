import 'package:flutter/material.dart';

@immutable
sealed class StatesEvent {}

class FetchState extends StatesEvent {
  final String? id;
  FetchState({required this.id});
}
