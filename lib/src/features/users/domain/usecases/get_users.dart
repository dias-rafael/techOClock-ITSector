import 'package:todo_app/src/features/users/domain/entities/users_data_entity.dart';

import '../../../../core/either.dart';
import '../../../../providers/network/api_error_exception.dart';
import '../repositories/users_repository.dart';

abstract class GetUsers {
  Future<Either<ApiErrorException, UsersDataEntity>> call({int? pageNumber});
}

class GetUsersImpl implements GetUsers {
  final UsersRepository _repository;
  const GetUsersImpl(this._repository);

  @override
  Future<Either<ApiErrorException, UsersDataEntity>> call({int? pageNumber}) {
    return _repository.getUsers(pageNumber: pageNumber);
  }
}
