import '../../../../core/either.dart';
import '../../../../providers/network/api_error_exception.dart';
import '../entities/users_data_entity.dart';

abstract class UsersRepository {
  Future<Either<ApiErrorException, UsersDataEntity>> getUsers(
      {int? pageNumber});

  Future<Either<ApiErrorException, UsersDataEntity>> getUsersSimple(
      {int? pageNumber});
}
