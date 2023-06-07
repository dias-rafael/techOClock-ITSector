import '../../data/models/network_request_model.dart';
import '../../data/models/network_response_model.dart';

abstract class INetworkClient {
  Future<NetworkResponseModel> get<T>({
    required NetworkRequestModel payload,
  });
  Future<NetworkResponseModel> post<T>({
    required NetworkRequestModel payload,
  });
  Future<NetworkResponseModel> put<T>({
    required NetworkRequestModel payload,
  });
  Future<NetworkResponseModel> delete<T>({
    required NetworkRequestModel payload,
  });
  Future<NetworkResponseModel> patch<T>({
    required NetworkRequestModel payload,
  });
  Future<NetworkResponseModel> request<T>({
    required NetworkRequestModel payload,
  });
}
