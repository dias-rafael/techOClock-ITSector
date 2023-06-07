import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/either.dart';
import '../../../../core/uri_paths.dart';
import '../../../../providers/network/api_error_exception.dart';
import '../../../../providers/network/api_manager.dart';
import '../../../../providers/network/data/models/network_request_model.dart';
import '../../../../providers/network/data/models/network_response_model.dart';
import '../../../../providers/network/domain/usecase/network_service.dart';
import '../../domain/entities/users_data_entity.dart';
import '../models/users_data_model.dart';

abstract class UsersDatasource {
  Future<Either<ApiErrorException, UsersDataEntity>> getUsers(
      {int? pageNumber});

  Future<Either<ApiErrorException, UsersDataEntity>> getUsersSimple(
      {int? pageNumber});
}

class UsersDatasourceImpl implements UsersDatasource {
  final NetworkService _networkService;
  UsersDatasourceImpl(this._networkService);

  @override
  Future<Either<ApiErrorException, UsersDataEntity>> getUsers(
      {int? pageNumber}) async {
    final query = {"page": pageNumber};

    final response = await _networkService.getRequest(
      payload: NetworkRequestModel(
          endpoint: UriPaths.getUsers, queryParameters: query),
    );

    return response.fold(
      (error) => Left(error),
      (result) => Right(UsersDataModel.fromMap(result.body)),
    );
  }

  @override
  Future<Either<ApiErrorException, UsersDataEntity>> getUsersSimple(
      {int? pageNumber}) async {
    try {
      var response = await _requestUser(pageNumber: pageNumber);
      return response.fold(
        (error) => Left(error),
        (result) => Right(UsersDataModel.fromMap(result.body)),
      );
    } on ApiErrorException catch (e) {
      return Left(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Either<ApiErrorException, NetworkResponseModel>> _requestUser(
      {int? pageNumber}) async {
    final apiManager = ApiManager();

    Dio getDio() {
      return Dio(
        BaseOptions(
          baseUrl: UriPaths.baseUrl,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );
    }

    final query = {"page": pageNumber};

    try {
      final Response response = await getDio()
          .get(UriPaths.getUsers, data: null, queryParameters: query);

      return Right(_handleDioResponse(response));
    } on DioError catch (e) {
      debugPrint("$e");
      throw apiManager.handleApiError(e);
    }
  }

  NetworkResponseModel _handleDioResponse(Response response) {
    if (response.statusCode != 200) {
      throw ApiErrorException(
        headers: response.headers.map,
        statusCode: response.statusCode!,
        url: response.requestOptions.uri.toString(),
        message: 'Desculpe, ocorreu um erro inesperado.',
        code: response.statusMessage!,
      );
    }

    return NetworkResponseModel(
      statusCode: response.statusCode,
      url: response.requestOptions.uri.toString(),
      body: response.data,
      method: response.requestOptions.method.toUpperCase(),
      headers: response.data['header'],
    );
  }
}
