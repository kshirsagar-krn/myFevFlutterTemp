part of 'gender_bloc.dart';

@immutable
sealed class GenderState {}

final class GenderInitial extends GenderState {}

final class GenderLoading extends GenderState {}

final class GenderSuccess extends GenderState {
  final List<GenderModel> genderModel;
  GenderSuccess({required this.genderModel});
}

final class GenderFaild extends GenderState {
  final String errorMessage;
  GenderFaild({required this.errorMessage});
}
