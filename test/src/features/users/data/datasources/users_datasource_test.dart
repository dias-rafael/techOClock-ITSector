import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/src/core/either.dart';
import 'package:todo_app/src/core/uri_paths.dart';
import 'package:todo_app/src/features/users/data/datasources/users_datasource.dart';
import 'package:todo_app/src/features/users/domain/entities/users_data_entity.dart';
import 'package:todo_app/src/providers/network/api_error_exception.dart';
import 'package:todo_app/src/providers/network/data/models/network_request_model.dart';
import 'package:todo_app/src/providers/network/data/models/network_response_model.dart';
import 'package:todo_app/src/providers/network/domain/repositories/network_client.dart';
import 'package:todo_app/src/providers/network/domain/usecase/network_service.dart';

import '../../../../../mocks/features/users/mock.dart';

class NetworkServiceMock extends Mock implements NetworkService {}

class INetworkClientMock extends Mock implements INetworkClient {}

class DioMock extends Mock implements Dio {}

void main() {
  late NetworkService networkService;
  late UsersDatasource dataSource;

  const networkRequestModelUsers = NetworkRequestModel(
    endpoint: UriPaths.getUsers,
  );

  setUp(() {
    networkService = NetworkServiceMock();

    dataSource = UsersDatasourceImpl(
      networkService,
    );
  });

  test('ONLINE: When call getUsers should return Users', () async {
    final dioClient = INetworkClientMock();
    final service = NetworkServiceImpl(dioClient);

    when(() => dioClient.get(payload: networkRequestModelUsers))
        .thenAnswer((_) async => NetworkResponseModel(statusCode: 200));

    final response =
        await service.getRequest(payload: networkRequestModelUsers);
    expect((response as Right).value.statusCode, equals(200));
  });

  test('MOCK: When call getUsers should return Users', () async {
    when(
      () => networkService.getRequest(payload: networkRequestModelUsers),
    ).thenAnswer(
      (_) async => Right(
        NetworkResponseModel(body: getUsersResponse),
      ),
    );

    final response = await dataSource.getUsers();

    expect((response as Right).value, isA<UsersDataEntity>());
    verify(
      () => networkService.getRequest(payload: networkRequestModelUsers),
    ).called(1);
  });

  test('When call getUsers should return ApiErrorException', () async {
    when(
      () => networkService.getRequest(payload: networkRequestModelUsers),
    ).thenAnswer((_) async => Left(ApiErrorException.noResponse()));

    final response = await dataSource.getUsers();

    expect((response as Left).value, isA<ApiErrorException>());
    verify(
      () => networkService.getRequest(payload: networkRequestModelUsers),
    ).called(1);
  });
}
