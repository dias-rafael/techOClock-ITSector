import 'package:todo_app/src/features/users/domain/entities/users_data_entity.dart';

import '../../../../core/either.dart';
import '../../../../providers/network/api_error_exception.dart';
import '../../domain/repositories/users_repository.dart';
import '../datasources/users_datasource.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersDatasource _dataSource;

  UsersRepositoryImpl(this._dataSource);

  @override
  Future<Either<ApiErrorException, UsersDataEntity>> getUsers(
      {int? pageNumber}) {
    return _dataSource.getUsers(pageNumber: pageNumber);
  }

  @override
  Future<Either<ApiErrorException, UsersDataEntity>> getUsersSimple(
      {int? pageNumber}) {
    return _dataSource.getUsersSimple(pageNumber: pageNumber);
  }
}
