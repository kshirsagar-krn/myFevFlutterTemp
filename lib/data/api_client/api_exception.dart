class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;
  final dynamic responseData;

  ApiException({
    required this.message,
    this.statusCode,
    this.errorCode,
    this.responseData,
  });

  @override
  String toString() {
    return message;
  }

  // Helper method to safely extract message from response body
  static String _getMessageFromBody(dynamic body) {
    if (body == null) return 'Unknown error';

    // Case 1: Body is a Map with Message field
    if (body is Map && body.containsKey('Message')) {
      return body['Message']?.toString() ?? 'Unknown error';
    }

    // Case 2: Body is a Map with message field (lowercase)
    if (body is Map && body.containsKey('message')) {
      return body['message']?.toString() ?? 'Unknown error';
    }

    // Case 3: Body is a simple String (like "User created successfully.")
    if (body is String) {
      return body;
    }

    // Case 4: Body is a Map without Message field - convert to string
    if (body is Map) {
      return body.toString();
    }

    // Case 5: Any other type
    return body.toString();
  }

  // Common API exceptions
  static ApiException get networkError => ApiException(
    message: 'Network connection failed',
    errorCode: 'NETWORK_ERROR',
  );

  static ApiException get timeoutError =>
      ApiException(message: 'Request timed out', errorCode: 'TIMEOUT_ERROR');

  static ApiException get serverError => ApiException(
    message: 'Internal server error',
    statusCode: 500,
    errorCode: 'SERVER_ERROR',
  );

  static ApiException get unauthorized => ApiException(
    message: 'Unauthorized access',
    statusCode: 401,
    errorCode: 'UNAUTHORIZED',
  );

  static ApiException get notFound => ApiException(
    message: 'Resource not found',
    statusCode: 404,
    errorCode: 'NOT_FOUND',
  );

  static ApiException fromResponse(int statusCode, dynamic body) {
    final message = _getMessageFromBody(body);

    switch (statusCode) {
      case 400:
        return ApiException(
          message: message,
          statusCode: statusCode,
          errorCode: 'BAD_REQUEST',
          responseData: body,
        );
      case 401:
        return ApiException(
          message: message,
          statusCode: statusCode,
          errorCode: 'UNAUTHORIZED',
          responseData: body,
        );
      case 403:
        return ApiException(
          message: message,
          statusCode: statusCode,
          errorCode: 'FORBIDDEN',
          responseData: body,
        );
      case 404:
        return ApiException(
          message: message,
          statusCode: statusCode,
          errorCode: 'NOT_FOUND',
          responseData: body,
        );
      case 500:
        return ApiException(
          message: message,
          statusCode: statusCode,
          errorCode: 'SERVER_ERROR',
          responseData: body,
        );
      case 502:
        return ApiException(
          message: message,
          statusCode: statusCode,
          errorCode: 'BAD_GATEWAY',
          responseData: body,
        );
      case 503:
        return ApiException(
          message: message,
          statusCode: statusCode,
          errorCode: 'SERVICE_UNAVAILABLE',
          responseData: body,
        );
      default:
        return ApiException(
          message: message,
          statusCode: statusCode,
          errorCode: 'UNKNOWN_ERROR',
          responseData: body,
        );
    }
  }
}
