import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../domain/repo/auth_repo.dart';
import '../constant/api_constant.dart';
import 'api_exception.dart';

class ApiClient {
  late final Dio dio;

  ApiClient({String? baseUrl, Map<String, dynamic>? defaultHeaders}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiConstant.baseUrl,
        connectTimeout: Duration(milliseconds: ApiConstant.connectTimeout),
        receiveTimeout: Duration(milliseconds: ApiConstant.receiveTimeout),
        headers: defaultHeaders ?? ApiConstant.headers,
      ),
    );

    // Interceptor: Add token + merge headers + log everything
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          log(options.uri.toString(), name: 'API Request URL');

          if (options.data != null) {
            if (options.data is FormData) {
              // Handle FormData specifically
              final formData = options.data as FormData;
              final fields = <String, dynamic>{};

              // Log all form fields
              for (final field in formData.fields) {
                fields[field.key] = field.value;
              }

              // Log all files
              for (final file in formData.files) {
                fields[file.key] =
                    'File: ${file.value.filename} (${file.value.length} bytes)';
              }

              log(jsonEncode(fields), name: 'API Request Body (Multipart)');
            } else {
              // For non-FormData bodies
              log(jsonEncode(options.data), name: 'API Request Body');
            }
          }

          // -------------- GET TOKEN --------------
          final token = await AuthRepo().getToken();

          // -------------- MERGE HEADERS --------------
          Map<String, dynamic> mergedHeaders = {
            ...ApiConstant.headers, // default
            ...options.headers, // per-request passed headers
          };

          if (token != null && token.trim().isNotEmpty) {
            mergedHeaders["Authorization"] = "Bearer $token";
            log("Token injected", name: "Auth");
          } else {
            log("Token missing", name: "Auth");
          }

          // Apply merged headers
          options.headers = mergedHeaders;

          log(mergedHeaders.toString(), name: "FINAL HEADERS");

          handler.next(options);
        },

        onResponse: (response, handler) {
          log(response.data.toString(), name: 'API Response');
          handler.next(response);
        },

        onError: (error, handler) {
          log(error.toString(), name: 'API ERROR');
          if (error.response != null) {
            log(error.response!.data.toString(), name: 'API ERROR BODY');
            log(error.response!.statusCode.toString(), name: 'API ERROR CODE');
          }
          handler.next(error);
        },
      ),
    );
  }

  // --------------------------------------------------------
  //                 GET
  // --------------------------------------------------------
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // --------------------------------------------------------
  //                 POST
  // --------------------------------------------------------
  Future<Response> post(
    String endpoint, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    try {
      return await dio.post(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // --------------------------------------------------------
  //                 PUT
  // --------------------------------------------------------
  Future<Response> put(
    String endpoint, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    try {
      return await dio.put(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // --------------------------------------------------------
  //                 DELETE
  // --------------------------------------------------------
  Future<Response> delete(
    String endpoint, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.delete(endpoint, options: Options(headers: headers));
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // --------------------------------------------------------
  //           FILE UPLOAD
  // --------------------------------------------------------

  Future<Response> uploadMultipart(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    Map<String, MultipartFile>? files,
  }) async {
    try {
      final formData = FormData();

      // Add regular fields
      if (data != null) {
        data.forEach((key, value) {
          // Check if the value is a complex object (List or Map)
          if (value is List || value is Map) {
            // Convert complex objects to JSON string
            formData.fields.add(MapEntry(key, jsonEncode(value)));
          } else {
            // Handle primitive types
            formData.fields.add(MapEntry(key, value.toString()));
          }
        });
      }

      // Add files
      if (files != null) {
        files.forEach((key, file) {
          formData.files.add(MapEntry(key, file));
        });
      }

      return await dio.post(
        endpoint,
        data: formData,
        options: Options(contentType: 'multipart/form-data', headers: headers),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // --------------------------------------------------------
  //                ERROR HANDLING
  // --------------------------------------------------------
  ApiException _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return ApiException.timeoutError;
    }

    if (error.type == DioExceptionType.connectionError) {
      return ApiException.networkError;
    }

    if (error.response != null) {
      return ApiException.fromResponse(
        error.response?.statusCode ?? 0,
        error.response?.data ?? '',
      );
    }

    return ApiException(
      message: error.message ?? 'Unknown error',
      errorCode: 'UNKNOWN_ERROR',
    );
  }
}
