part of 'todo_cubit.dart';

enum TodoStateStatus { initial, loading, loaded, saved, deleted, sorted, error }

class TodoState extends Equatable {
  final TodoStateStatus status;
  final List<ListDataEntity>? listItems;
  final SortType sortType;
  final String? message;

  const TodoState({
    this.status = TodoStateStatus.initial,
    this.listItems,
    this.sortType = SortType.asc,
    this.message,
  });

  TodoState copyWith({
    TodoStateStatus? status,
    List<ListDataEntity>? listItems,
    SortType? sortType,
    String? message,
  }) {
    return TodoState(
      status: status ?? this.status,
      listItems: listItems ?? this.listItems,
      sortType: sortType ?? this.sortType,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, listItems, sortType, message];
}

extension TodoStateExtension on TodoState {
  bool get isInitial => status == TodoStateStatus.initial;
  bool get isLoading => status == TodoStateStatus.loading;
  bool get isLoaded => status == TodoStateStatus.loaded;
  bool get isSaved => status == TodoStateStatus.saved;
  bool get isDeleted => status == TodoStateStatus.deleted;
  bool get isSorted => status == TodoStateStatus.sorted;
  bool get isError => status == TodoStateStatus.error;
}
