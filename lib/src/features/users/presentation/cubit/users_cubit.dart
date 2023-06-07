import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/sort_type_enum.dart';
import '../../domain/entities/users_data_entity.dart';
import '../../domain/usecases/get_users.dart';
import '../../domain/usecases/get_users_simple.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetUsers _getUsers;
  final GetUsersSimple _getUsersSimple;

  UsersCubit(this._getUsers, this._getUsersSimple) : super(const UsersState());

  Future loadUsers({int? pageNumber}) async {
    emit(
      state.copyWith(
        status: UsersStateStatus.loading,
      ),
    );

    final response = await _getUsers(pageNumber: pageNumber);
    // final response = await _getUsersSimple(pageNumber: pageNumber);

    if (isClosed) return;

    response.fold(
      (error) => emit(state.copyWith(
        status: UsersStateStatus.error,
        message: error.message,
      )),
      (result) => emit(state.copyWith(
        status: UsersStateStatus.loaded,
        listUsers: result,
        // status: UsersStateStatus.error,
        // message: "Erro ao carregar a lista",
      )),
    );
  }
}
