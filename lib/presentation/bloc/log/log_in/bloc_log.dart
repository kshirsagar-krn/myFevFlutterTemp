import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/api_client/api_exception.dart';
import '../../../../data/models/user_model.dart';
import '../../../../domain/repo/auth_repo.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo authRepo;
  LoginBloc(this.authRepo) : super(LoginInitial()) {
    on<SendOtp>(_onSendOtp);
    on<VerifyOtp>(_onVerifyOtp);
    on<UserSignUp>(_onUserSignUp);
    on<FetchProfile>(_onGetUserData);
    on<DeleteProfile>(_onDeleteUserData);
    on<LogOutProfile>(_onLogOutUserProfile);
  }

  Future<void> _onSendOtp(SendOtp event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      var response = await authRepo.sendOtp(mobileNumber: event.mobileNumber);
      final String status = response.data['Status'];
      final String message = response.data['Message'];
      final String reqId = response.data['RequestId'];
      if (status == "SUCCESS") {
        emit(LoginSuccess(message: message, requestId: reqId));
      } else {
        emit(LoginFailed(message));
      }
    } on ApiException catch (error) {
      emit(LoginFailed(error.message));
    }
  }

  Future<void> _onVerifyOtp(VerifyOtp event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      var response = await authRepo.verifyOtp(
        otp: event.otp,
        reqId: event.reqId,
      );
      log("${response.data}", name: "secreate data");
      final bool status = response.data['Status'] == "SUCCESS";
      final String message = response.data['Message'];
      final String? token = response.data['AccessToken'];
      final bool? isExistingUser = response.data['IsExistingUser'];
      if (status) {
        emit(
          VerifyOtpSuccess(
            message: message,
            userToken: token,
            isExistingUser: isExistingUser,
          ),
        );
      } else {
        emit(LoginFailed(message));
      }
    } on ApiException catch (error) {
      emit(LoginFailed(error.message));
    }
  }

  Future<void> _onUserSignUp(UserSignUp event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      var response = await authRepo.createProfile(
        body: event.body,
        profilePictureData: event.profilePictureData,
      );
      final String message = response.data['Message'];
      final String? status = response.data['Status'];
      final String? token = response.data['TokenResponse']['AccessToken'];
      final String? userType = response.data['UserTypeName'];
      if (message == "Signup successful" || status == 'SUCCESS') {
        emit(
          UserSignUpSuccess(
            message: message,
            userToken: token,
            userType: userType,
          ),
        );
      } else {
        emit(LoginFailed(message));
      }
    } on ApiException catch (error) {
      emit(LoginFailed(error.message));
    }
  }

  UserModel? userModel;
  Future<void> _onGetUserData(
    FetchProfile event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      var response = await authRepo.fetchProfileData();
      Map<String, dynamic>? data = response.data['Data'];
      if (data != null) {
        userModel = userModelFromJson(jsonEncode(data));
      }
      emit(GetProfileData(userData: userModel));
    } on ApiException catch (error) {
      emit(LoginFailed(error.message));
    }
  }

  Future<void> _onLogOutUserProfile(
    LogOutProfile event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      var response = await authRepo.appLogout();
      if (response.data["Message"] == "Logged out successfully") {
        emit(LogOutProfileSuccess(message: response.data["Message"]));
      } else {
        emit(LoginFailed(response.data["Message"]));
      }
    } on ApiException catch (error) {
      emit(LoginFailed(error.message));
    }
  }

  Future<void> _onDeleteUserData(
    DeleteProfile event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      var response = await authRepo.deleteProfileReq();
      if (response.data["Status"] == "SUCCESS") {
        emit(DeleteProfileSuccess(message: response.data["Message"]));
      } else {
        emit(LoginFailed(response.data["Message"]));
      }
    } on ApiException catch (error) {
      emit(LoginFailed(error.message));
    }
  }
}
