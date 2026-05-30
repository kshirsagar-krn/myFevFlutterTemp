import 'package:flutter/material.dart';
import '../../../../data/models/state_model.dart';

@immutable
sealed class StatesState {}

final class StatesInitial extends StatesState {}

final class StatesLoading extends StatesState {}

final class StateSuccess extends StatesState {
  final List<StateModel> stateModel;
  StateSuccess({required this.stateModel});
}

final class StatesFailure extends StatesState {
  final dynamic error;

  StatesFailure(this.error);
}
