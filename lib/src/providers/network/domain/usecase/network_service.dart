import '../../../../core/either.dart';
import '../../api_error_exception.dart';
import '../../api_manager.dart';
import '../../data/models/network_request_model.dart';
import '../../data/models/network_response_model.dart';
import '../repositories/network_client.dart';

abstract class NetworkService {
  Future<Either<ApiErrorException, NetworkResponseModel>> getRequest({
    required NetworkRequestModel payload,
  });

  Future<Either<ApiErrorException, NetworkResponseModel>> postRequest({
    required NetworkRequestModel payload,
  });

  Future<Either<ApiErrorException, NetworkResponseModel>> deleteRequest({
    required NetworkRequestModel payload,
  });

  Future<Either<ApiErrorException, NetworkResponseModel>> putRequest({
    required NetworkRequestModel payload,
  });

  Future<Either<ApiErrorException, NetworkResponseModel>> patchRequest({
    required NetworkRequestModel payload,
  });
}

class NetworkServiceImpl implements NetworkService {
  final INetworkClient _client;
  late final ApiManager _apiManager;

  NetworkServiceImpl(this._client, [ApiManager? apiManager]) {
    _apiManager = apiManager ?? ApiManager();
  }

  @override
  Future<Either<ApiErrorException, NetworkResponseModel>> getRequest({
    required NetworkRequestModel payload,
  }) async {
    try {
      var response = await _client.get(
        payload: payload,
      );
      return Right(response);
    } on ApiErrorException catch (e) {
      return Left(e);
    } catch (e) {
      return _apiManager.unhandledException(e);
    }
  }

  @override
  Future<Either<ApiErrorException, NetworkResponseModel>> postRequest({
    required NetworkRequestModel payload,
  }) async {
    try {
      final response = await _client.post(
        payload: payload,
      );
      return Right(response);
    } on ApiErrorException catch (e) {
      return Left(e);
    } catch (e) {
      return _apiManager.unhandledException(e);
    }
  }

  @override
  Future<Either<ApiErrorException, NetworkResponseModel>> deleteRequest({
    required NetworkRequestModel payload,
  }) async {
    try {
      final response = await _client.delete(
        payload: payload,
      );
      return Right(response);
    } on ApiErrorException catch (e) {
      return Left(e);
    } catch (e) {
      return _apiManager.unhandledException(e);
    }
  }

  @override
  Future<Either<ApiErrorException, NetworkResponseModel>> putRequest({
    required NetworkRequestModel payload,
  }) async {
    try {
      final response = await _client.put(
        payload: payload,
      );
      return Right(response);
    } on ApiErrorException catch (e) {
      return Left(e);
    } catch (e) {
      return _apiManager.unhandledException(e);
    }
  }

  @override
  Future<Either<ApiErrorException, NetworkResponseModel>> patchRequest({
    required NetworkRequestModel payload,
  }) async {
    try {
      final response = await _client.patch(
        payload: payload,
      );
      return Right(response);
    } on ApiErrorException catch (e) {
      return Left(e);
    } catch (e) {
      return _apiManager.unhandledException(e);
    }
  }
}
