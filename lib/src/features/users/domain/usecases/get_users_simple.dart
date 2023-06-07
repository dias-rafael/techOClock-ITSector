import 'package:todo_app/src/features/users/domain/entities/users_data_entity.dart';

import '../../../../core/either.dart';
import '../../../../providers/network/api_error_exception.dart';
import '../repositories/users_repository.dart';

abstract class GetUsersSimple {
  Future<Either<ApiErrorException, UsersDataEntity>> call({int? pageNumber});
}

class GetUsersSimpleImpl implements GetUsersSimple {
  final UsersRepository _repository;
  const GetUsersSimpleImpl(this._repository);

  @override
  Future<Either<ApiErrorException, UsersDataEntity>> call({int? pageNumber}) {
    return _repository.getUsersSimple(pageNumber: pageNumber);
  }
}
