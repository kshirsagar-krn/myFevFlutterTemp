import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

@immutable
sealed class LoginEvent {}

final class SendOtp extends LoginEvent {
  final String mobileNumber;
  SendOtp({required this.mobileNumber});
}

final class VerifyOtp extends LoginEvent {
  final String reqId;
  final String otp;
  VerifyOtp({required this.otp, required this.reqId});
}

final class UserSignUp extends LoginEvent {
  final Map<String, dynamic> body;
  final XFile? profilePictureData;
  UserSignUp({required this.body, this.profilePictureData});
}

final class FetchProfile extends LoginEvent {}

final class LogOutProfile extends LoginEvent {}

final class DeleteProfile extends LoginEvent {}
