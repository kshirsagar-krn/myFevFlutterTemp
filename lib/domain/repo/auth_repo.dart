// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../data/api_client/api_client.dart';
import '../../data/constant/api_constant.dart';
import '../../data/local_db/local_storage.dart';
import 'package:path/path.dart' as path;

class AuthRepo {
  final dio = ApiClient();

  // login request --
  Future<Response> sendOtp({required String mobileNumber}) async {
    return await dio.post(
      ApiConstant.sendOtp,
      body: {"MobileNumber": mobileNumber},
    );
  }

  Future<Response> verifyOtp({
    required String otp,
    required String reqId,
  }) async {
    return await dio.post(
      ApiConstant.verifyOtp,
      body: {
        "Otp": otp,
        "RequestId": reqId,
        "DeviceId": await generateDeviceId(),
      },
    );
  }

  // create profile --
  Future<Response> createProfile({
    required Map<String, dynamic> body,
    XFile? profilePictureData,
  }) async {
    var formData = body;
    return await dio.uploadMultipart(
      ApiConstant.createSignUp,
      data: formData,
      files: profilePictureData != null
          ? {
              "ProfileImage": await MultipartFile.fromFile(
                profilePictureData.path,
                filename: 'avatar${path.extension(profilePictureData.path)}',
              ),
            }
          : null,
    );
  }

  // get profile --
  Future<Response> fetchProfileData() async {
    return await dio.get(ApiConstant.fetchProfile);
  }

  // user Dashboard Model --
  Future<Response> fetchUserDashBoard() async {
    return await dio.get(ApiConstant.fechDashBoard);
  }

  // TODO: logout app
  Future<Response> appLogout() async {
    return await dio.post(ApiConstant.getLogout);
  }

  // bussiness setting --
  Future<Response> fetchBusinessSetting() async {
    return await dio.get(ApiConstant.fetchBusinessSetting);
  }

  Future<Response> deleteProfileReq() async {
    return await dio.get(ApiConstant.deleteProfile);
  }

  // save token --
  Future saveToken({required String token}) async {
    return await HiveLocalStorage.write(
      "userToken",
      token,
    ).then((value) => log("Saved Token"));
  }

  // get token --
  Future getToken() async {
    return await HiveLocalStorage.read("userToken");
  }

  // saved first user
  Future saveFirstUser() async {
    return await HiveLocalStorage.write(
      "saveFirstUser",
      "user",
    ).then((value) => log("Saved First user"));
  }

  Future checkFirstUser() async {
    return await HiveLocalStorage.read("saveFirstUser");
  }

  Future<void> clearStoredCredentials() async {
    await HiveLocalStorage.delete('userToken');
  }

  static Future<String> generateDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // Android ID
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? Uuid().v4();
    } else {
      return Uuid().v4();
    }
  }
}
