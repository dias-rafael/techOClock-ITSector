import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../core/either.dart';
import 'api_error_exception.dart';
import 'data/models/network_response_model.dart';

class ApiManager {
  var logger = Logger();

  ApiErrorException handleApiError(DioError err) {
    final response = err.response;

    if (err.type == DioErrorType.cancel) {
      return ApiErrorException(
        statusCode: response?.statusCode ?? 999,
        url: response?.requestOptions.uri.toString() ?? '',
        message: 'Request canceled',
        code: 'RequestCanceled',
        headers: response?.headers.map ?? {},
      );
    }

    if (err.type == DioErrorType.connectionTimeout) {
      return ApiErrorException(
        statusCode: response?.statusCode ?? 999,
        url: response?.requestOptions.uri.toString() ?? '',
        message: 'Request Timeout',
        code: 'RequestTimeout',
        headers: response?.headers.map ?? {},
      );
    }

    return ApiErrorException(
      statusCode: response?.statusCode ?? 999,
      url: response?.realUri.toString() ?? '',
      message: response?.statusMessage ?? '',
      code: 'Uknown',
      headers: response?.headers.map ?? {},
    );
  }

  Map<String, dynamic> requestHeaders({
    Map<String, dynamic>? requestHeaders,
    String? contentType,
  }) {
    Map<String, dynamic> headers = {
      "Content-Type": (contentType == null) ? "application/json" : contentType,
    };

    if (requestHeaders != null) {
      requestHeaders.forEach((key, value) {
        headers.putIfAbsent(key, () => value);
      });
    }

    return headers;
  }

  Left<ApiErrorException, NetworkResponseModel> unhandledException(T) {
    final result = ApiErrorException(
      statusCode: 0,
      url: '',
      message: 'Invalid request: ${T.toString()}',
      code: '',
      headers: {},
    );

    logger.log(
      Level.error,
      [const JsonEncoder.withIndent('  ').convert(jsonDecode(result.toJson()))],
    );

    return Left(result);
  }
}
