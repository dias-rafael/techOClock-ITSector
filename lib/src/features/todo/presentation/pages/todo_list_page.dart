import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/core/strings_constants.dart';
import 'package:todo_app/src/features/todo/presentation/widgets/custom_bottomsheet_widget.dart';
import 'package:todo_app/src/features/todo/presentation/widgets/sort_option_widget.dart';

import '../../../../core/sort_type_enum.dart';
import '../../domain/entities/list_data_entity.dart';
import '../cubit/todo_cubit.dart';
import '../widgets/custom_dialog_widget.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/list_card_widget.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<ListDataEntity> items = [];
  TextEditingController addItemsTextController = TextEditingController();
  FocusNode addItemsFocus = FocusNode();

  @override
  void initState() {
    context.read<TodoCubit>().loadList();
    super.initState();
  }

  @override
  void dispose() {
    addItemsTextController.dispose();
    addItemsFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {
        items = state.listItems ?? [];
        if (state.isDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message!.toUpperCase(),
                style: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.grey[300],
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Image.asset("assets/icons/itsector_icon.png"),
            ),
            title: const Text(
              StringsConstants.todoPageTitle,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xff00002f),
            actions: [
              if (items.length > 1)
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: IconButton(
                    iconSize: 30,
                    icon: const Icon(
                      Icons.sort,
                      color: Colors.white,
                    ),
                    onPressed: () => _showSortBottomSheet(),
                  ),
                )
            ],
          ),
          body: Stack(
            children: [
              (items.isEmpty) ? const EmptyListWidget() : _buildListItems,
              _buildAddItems,
            ],
          ),
          floatingActionButton: Visibility(
            visible: items.isNotEmpty,
            child: FloatingActionButton(
              onPressed: () async => _showConfirmDialog(),
              tooltip: StringsConstants.todoClearListToolTip,
              child: const Icon(Icons.delete_outlined),
            ),
          ),
        );
      },
    );
  }

  Widget get _buildAddItems {
    return Container(
      color: Colors.grey[300],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 15.0,
                bottom: 15.0,
              ),
              child: TextFormField(
                controller: addItemsTextController,
                focusNode: addItemsFocus,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: StringsConstants.todoItemNameFieldLabel,
                  border: const OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  suffixIcon: IconButton(
                    onPressed: () {
                      addItemsTextController.clear();
                    },
                    iconSize: 30,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                ),
                onFieldSubmitted: (value) {
                  if (addItemsTextController.text.isNotEmpty) {
                    _addItem();
                  }
                },
                onTapOutside: (event) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (addItemsTextController.text.isEmpty) {
                addItemsFocus.requestFocus();
              } else {
                _addItem();
              }
            },
            iconSize: 40,
            icon: const Icon(
              Icons.add,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildListItems {
    return ListView.separated(
      padding: const EdgeInsets.only(
        top: 95.0,
      ),
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(items[index].name),
          confirmDismiss: (direction) async {
            _confirmDismiss(
              direction: direction,
              index: index,
            );
            return null;
          },
          secondaryBackground: Container(
            padding: const EdgeInsets.only(right: 16),
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          background: Container(
            padding: const EdgeInsets.only(left: 16),
            color: Colors.green,
            alignment: Alignment.centerLeft,
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          dismissThresholds: const {
            DismissDirection.startToEnd: 0.1,
            DismissDirection.endToStart: 0.7
          },
          child: ListCardWidget(
            title: items[index].name,
            value: items[index].isFinished,
            onTap: (value) =>
                context.read<TodoCubit>().changeTaskStatus(item: items[index]),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 1,
          height: 1,
          color: Colors.grey[300],
        );
      },
      itemCount: items.length,
    );
  }

  Future<void> _showConfirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialogWidget(
          title: StringsConstants.todoClearListQuestion,
          primaryButtonLabel: StringsConstants.yes,
          secondaryButtonLabel: StringsConstants.no,
          primaryButtomTap: () {
            Navigator.pop(context);
            context.read<TodoCubit>().deleteList();
          },
          secondaryButtomTap: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future<void> _showSortBottomSheet() async {
    final state = context.read<TodoCubit>().state;

    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return CustomBottomSheetWidget(
          title: StringsConstants.todoOrderItemsByText,
          context: context,
          body: Column(
            children: [
              SortOptionWidget(
                sortOptionName: StringsConstants.orderAscAZ,
                value: SortType.asc,
                groupValue: state.sortType,
                onSelect: (sortTypeSelected) => _sortList(sortTypeSelected),
              ),
              SortOptionWidget(
                sortOptionName: StringsConstants.orderDescZA,
                value: SortType.desc,
                groupValue: state.sortType,
                onSelect: (sortTypeSelected) => _sortList(sortTypeSelected),
              ),
            ],
          ),
        );
      },
    );
  }

  _addItem() {
    context.read<TodoCubit>().saveItem(newItem: addItemsTextController.text);
    addItemsTextController.clear();
  }

  _sortList(SortType sortTypeSelected) {
    Navigator.pop(context);
    context.read<TodoCubit>().loadList(
          newSortType: sortTypeSelected,
        );
  }

  _confirmDismiss({
    required DismissDirection direction,
    required int index,
  }) {
    if (direction == DismissDirection.startToEnd) {
      setState(() {
        addItemsTextController = TextEditingController(
          text: items[index].name,
        );
      });

      addItemsFocus.requestFocus();
      addItemsTextController.selection = TextSelection(
        baseOffset: addItemsTextController.text.length,
        extentOffset: addItemsTextController.text.length,
      );

      context.read<TodoCubit>().editItem(
            item: items[index],
          );
    } else {
      context.read<TodoCubit>().deleteItem(
            item: items[index],
          );
    }
    return;
  }
}
