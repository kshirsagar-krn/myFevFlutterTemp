import 'package:flutter/material.dart';
import '../../../../data/models/user_model.dart';

@immutable
class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String message;
  final String requestId;
  LoginSuccess({required this.message, required this.requestId});
}

final class VerifyOtpSuccess extends LoginState {
  final String message;

  final String? userToken;
  final bool? isExistingUser;
  VerifyOtpSuccess({
    required this.message,
    this.userToken,
    this.isExistingUser,
  });
}

final class UserSignUpSuccess extends LoginState {
  final String message;
  final String? userToken;
  final String? userType;
  UserSignUpSuccess({required this.message, this.userToken, this.userType});
}

final class GetProfileData extends LoginState {
  final UserModel? userData;
  GetProfileData({required this.userData});
}

final class LogOutProfileSuccess extends LoginState {
  final String message;
  LogOutProfileSuccess({required this.message});
}

final class DeleteProfileSuccess extends LoginState {
  final String message;
  DeleteProfileSuccess({required this.message});
}

final class LoginFailed extends LoginState {
  final String errorMEssage;
  LoginFailed(this.errorMEssage);
}
