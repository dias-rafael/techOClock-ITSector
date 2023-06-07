import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/sort_type_enum.dart';
import '../../../../core/strings_constants.dart';
import '../../../../providers/local_storage_provider.dart';
import '../../data/models/list_data_model.dart';
import '../../domain/entities/list_data_entity.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoState());

  final LocalStorageProvider localStorageProvider = LocalStorageProvider();

  Future loadList({
    SortType? newSortType,
    TodoStateStatus? statusToEmit,
    String? messageToEmit,
  }) async {
    emit(
      state.copyWith(
        status: TodoStateStatus.loading,
      ),
    );

    List<ListDataEntity> listItems = [];
    SortType sortType = newSortType ?? state.sortType;

    final savedList =
        await localStorageProvider.readValue(LocalStorageKeys.TODO_LIST);

    if (savedList != null) {
      listItems = (jsonDecode(savedList) as List)
          .map((e) => ListDataModel.fromMap(jsonDecode(e)))
          .toList();

      switch (sortType) {
        case SortType.desc:
          listItems.sort(
              (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
          break;
        default:
          listItems.sort(
              (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
          break;
      }
    }

    emit(
      state.copyWith(
        status: statusToEmit ?? TodoStateStatus.loaded,
        listItems: listItems,
        sortType: sortType,
        message: messageToEmit,
      ),
    );
  }

  Future saveItem({required String newItem}) async {
    emit(
      state.copyWith(
        status: TodoStateStatus.loading,
      ),
    );

    List<ListDataEntity> listItems = state.listItems ?? [];
    int nextIndex = 1;

    if (listItems.isNotEmpty) {
      listItems.sort((a, b) => a.index.compareTo(b.index));
      nextIndex = listItems.last.index + 1;
    }

    listItems.add(
      ListDataModel(index: nextIndex, name: newItem, isFinished: false),
    );

    await _saveLocalStorage(listItems: listItems);

    loadList(statusToEmit: TodoStateStatus.saved);
  }

  Future deleteItem({required ListDataEntity item}) async {
    emit(
      state.copyWith(
        status: TodoStateStatus.loading,
      ),
    );

    List<ListDataEntity> listItems = state.listItems ?? [];
    listItems.removeWhere((element) => element.index == item.index);

    await _saveLocalStorage(listItems: listItems);

    emit(
      state.copyWith(
        status: TodoStateStatus.deleted,
        listItems: listItems,
        message: "${item.name} ${StringsConstants.todoItemDeletedMessage}",
      ),
    );
  }

  Future editItem({required ListDataEntity item}) async {
    emit(
      state.copyWith(
        status: TodoStateStatus.loading,
      ),
    );

    List<ListDataEntity> listItems = state.listItems ?? [];
    listItems.removeWhere((element) => element.index == item.index);

    await _saveLocalStorage(listItems: listItems);

    emit(
      state.copyWith(
        status: TodoStateStatus.loaded,
        listItems: listItems,
      ),
    );
  }

  Future changeTaskStatus({required ListDataEntity item}) async {
    emit(
      state.copyWith(
        status: TodoStateStatus.loading,
      ),
    );

    List<ListDataEntity> listItems = state.listItems ?? [];
    final itemToFinish =
        listItems.firstWhere((element) => element.index == item.index);

    listItems.removeWhere((element) => element.index == item.index);
    listItems.add(
      ListDataModel(
        index: itemToFinish.index,
        name: itemToFinish.name,
        isFinished: !itemToFinish.isFinished,
      ),
    );

    await _saveLocalStorage(listItems: listItems);

    loadList();
  }

  Future deleteList() async {
    emit(
      state.copyWith(
        status: TodoStateStatus.loading,
        listItems: state.listItems,
      ),
    );
    await localStorageProvider.deleteAllValues();

    emit(
      state.copyWith(
        status: TodoStateStatus.deleted,
        listItems: [],
        message: StringsConstants.todoClearedListMessage,
      ),
    );
  }

  Future _saveLocalStorage({required List<ListDataEntity> listItems}) async {
    await localStorageProvider.writeValue(
      LocalStorageKeys.TODO_LIST,
      jsonEncode(listItems.toList()),
    );
  }
}
