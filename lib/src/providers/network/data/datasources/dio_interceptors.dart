import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../api_error_exception.dart';
import '../../api_manager.dart';
import '../models/network_request_model.dart';
import '../models/network_response_model.dart';

class DioInterceptors extends Interceptor {
  final _logger = Logger();
  final ApiManager _apiManager = ApiManager();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers =
        _apiManager.requestHeaders(requestHeaders: options.headers);

    NetworkRequestModel result = NetworkRequestModel(
      method: options.method,
      endpoint: options.path,
      body: options.data,
      queryParameters: options.queryParameters,
      headers: options.headers,
    );

    final map = result.toMap()..addAll({'baseUrl': options.baseUrl});

    _logger.log(
      Level.info,
      map,
    );

    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final NetworkResponseModel result = NetworkResponseModel(
      statusCode: response.statusCode ?? 999,
      url: response.requestOptions.uri.toString(),
      body: response.data,
    );

    _logger.log(
      Level.info,
      result.toJson(),
    );

    handler.next(response);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    ApiErrorException errorException;

    final responseError = err.response;

    errorException = ApiErrorException(
      statusCode: responseError?.statusCode ?? 999,
      url: err.requestOptions.uri.toString(),
      message: responseError?.statusMessage ?? '',
      code: 'Uknown',
      headers: {},
    );

    if (err.type == DioErrorType.cancel) {
      errorException = ApiErrorException(
        statusCode: responseError?.statusCode ?? 999,
        url: err.requestOptions.uri.toString(),
        message: 'Request canceled',
        code: 'RequestCanceled',
        headers: {},
      );
    }

    if (err.type == DioErrorType.connectionTimeout) {
      errorException = ApiErrorException(
        statusCode: responseError?.statusCode ?? 999,
        url: err.requestOptions.uri.toString(),
        message: 'Request Timeout',
        headers: {},
        code: 'RequestTimeout',
      );
    }

    _logger.log(
      Level.error,
      errorException.toJson(),
    );

    handler.next(err);
  }
}
