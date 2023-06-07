import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:todo_app/src/core/uri_paths.dart';

import '../../api_manager.dart';
import '../../domain/repositories/network_client.dart';
import '../models/network_request_model.dart';
import '../models/network_response_model.dart';
import 'dio_interceptors.dart';

class DioClient implements INetworkClient {
  final ApiManager _apiManager = ApiManager();
  final Dio _dio = Dio();

  DioClient({List<Interceptor>? interceptors}) {
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }

    _dio
      ..interceptors.add(DioInterceptors())
      ..options.baseUrl = UriPaths.baseUrl
      ..options.connectTimeout = const Duration(minutes: 1)
      ..options.receiveTimeout = const Duration(minutes: 1);

    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) => client..badCertificateCallback = (_, __, ___) => true;
  }

  @override
  Future<NetworkResponseModel> get<T>({
    required NetworkRequestModel payload,
  }) async {
    try {
      return await _dio
          .get(
            payload.endpoint,
            queryParameters: payload.queryParameters,
            options: Options(headers: payload.headers),
          )
          .then(_setDioResponse);
    } on DioError catch (e) {
      throw _apiManager.handleApiError(e);
    }
  }

  @override
  Future<NetworkResponseModel> post<T>({
    required NetworkRequestModel payload,
  }) async {
    try {
      return await _dio
          .post(
            payload.endpoint,
            data: payload.body,
            queryParameters: payload.queryParameters,
            options: Options(headers: payload.headers),
          )
          .then(_setDioResponse);
    } on DioError catch (e) {
      throw _apiManager.handleApiError(e);
    }
  }

  @override
  Future<NetworkResponseModel> delete<T>({
    required NetworkRequestModel payload,
  }) async {
    try {
      return await _dio
          .delete(
            payload.endpoint,
            queryParameters: payload.queryParameters,
            options: Options(headers: payload.headers),
          )
          .then(_setDioResponse);
    } on DioError catch (e) {
      throw _apiManager.handleApiError(e);
    }
  }

  @override
  Future<NetworkResponseModel> put<T>({
    required NetworkRequestModel payload,
  }) async {
    try {
      return await _dio
          .put(
            payload.endpoint,
            data: payload.body,
            queryParameters: payload.queryParameters,
            options: Options(headers: payload.headers),
          )
          .then(_setDioResponse);
    } on DioError catch (e) {
      throw _apiManager.handleApiError(e);
    }
  }

  @override
  Future<NetworkResponseModel> patch<T>({
    required NetworkRequestModel payload,
  }) async {
    try {
      return await _dio
          .patch(
            payload.endpoint,
            data: payload.body,
            queryParameters: payload.queryParameters,
            options: Options(headers: payload.headers),
          )
          .then(_setDioResponse);
    } on DioError catch (e) {
      throw _apiManager.handleApiError(e);
    }
  }

  @override
  Future<NetworkResponseModel> request<T>({
    required NetworkRequestModel payload,
  }) async {
    try {
      return await _dio
          .request(
            payload.endpoint,
            data: payload.body,
            queryParameters: payload.queryParameters,
            options: Options(
              headers: payload.headers,
              method: payload.method,
            ),
          )
          .then(_setDioResponse);
    } on DioError catch (e) {
      throw _apiManager.handleApiError(e);
    }
  }

  NetworkResponseModel _setDioResponse(Response response) {
    return NetworkResponseModel(
      statusCode: response.statusCode,
      url: response.requestOptions.uri.toString(),
      body: response.data,
      method: response.requestOptions.method.toUpperCase(),
      headers: response.data['header'],
    );
  }
}
