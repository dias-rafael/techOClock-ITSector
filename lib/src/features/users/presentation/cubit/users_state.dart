part of 'users_cubit.dart';

enum UsersStateStatus {
  initial,
  loading,
  loaded,
  saved,
  deleted,
  sorted,
  error
}

class UsersState extends Equatable {
  final UsersStateStatus status;
  final UsersDataEntity? listUsers;
  final SortType sortType;
  final String? message;

  const UsersState({
    this.status = UsersStateStatus.initial,
    this.listUsers,
    this.sortType = SortType.asc,
    this.message,
  });

  UsersState copyWith({
    UsersStateStatus? status,
    UsersDataEntity? listUsers,
    SortType? sortType,
    String? message,
  }) {
    return UsersState(
      status: status ?? this.status,
      listUsers: listUsers ?? this.listUsers,
      sortType: sortType ?? this.sortType,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, listUsers, sortType, message];
}

extension UsersStateExtension on UsersState {
  bool get isInitial => status == UsersStateStatus.initial;
  bool get isLoading => status == UsersStateStatus.loading;
  bool get isLoaded => status == UsersStateStatus.loaded;
  bool get isSaved => status == UsersStateStatus.saved;
  bool get isDeleted => status == UsersStateStatus.deleted;
  bool get isSorted => status == UsersStateStatus.sorted;
  bool get isError => status == UsersStateStatus.error;
}
