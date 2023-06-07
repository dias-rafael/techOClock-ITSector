import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/users/presentation/pages/users_details_page.dart';

import '../../../../core/strings_constants.dart';
import '../../domain/entities/users_info_entity.dart';
import '../cubit/users_cubit.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/error_list_widget.dart';
import '../widgets/users_card_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<UsersInfoEntity> users = [];
  TextEditingController addItemsTextController = TextEditingController();
  FocusNode addItemsFocus = FocusNode();

  @override
  void initState() {
    context.read<UsersCubit>().loadUsers();
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
    return BlocConsumer<UsersCubit, UsersState>(
      listener: (context, state) {
        users = state.listUsers?.data ?? [];
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
        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<UsersCubit>()
                .loadUsers(pageNumber: state.listUsers!.page);
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Image.asset("assets/icons/itsector_icon.png"),
              ),
              title: const Text(
                StringsConstants.usersPageTitle,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              centerTitle: true,
              backgroundColor: const Color(0xff00002f),
            ),
            body: (state.isLoading)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (users.isEmpty)
                    ? const EmptyListWidget()
                    : (state.isError)
                        ? ErrorListWidget(message: state.message!)
                        : _buildListUsers,
          ),
        );
      },
    );
  }

  Widget get _buildListUsers {
    final state = context.read<UsersCubit>().state;

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return UsersCardWidget(
                userData: users[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UsersDetailsPage(
                        userData: users[index],
                      ),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 1,
                height: 1,
                color: Colors.grey[300],
              );
            },
            itemCount: users.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  if (state.listUsers!.page >= state.listUsers!.totalPages) {
                    context
                        .read<UsersCubit>()
                        .loadUsers(pageNumber: state.listUsers!.page - 1);
                  }
                },
                child: Text(
                  "<",
                  style: TextStyle(
                    fontSize: 25,
                    color:
                        (state.listUsers!.page >= state.listUsers!.totalPages)
                            ? Colors.blue
                            : Colors.grey,
                  ),
                ),
              ),
              for (var pages = 1;
                  pages <= state.listUsers!.totalPages;
                  pages++) ...[
                GestureDetector(
                  onTap: () {
                    if (pages != state.listUsers!.page) {
                      context.read<UsersCubit>().loadUsers(pageNumber: pages);
                    }
                  },
                  child: Text(
                    pages.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: (state.listUsers!.page == pages)
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
              GestureDetector(
                onTap: () {
                  if (state.listUsers!.page < state.listUsers!.totalPages) {
                    context
                        .read<UsersCubit>()
                        .loadUsers(pageNumber: state.listUsers!.page + 1);
                  }
                },
                child: Text(
                  ">",
                  style: TextStyle(
                    fontSize: 25,
                    color: (state.listUsers!.page < state.listUsers!.totalPages)
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
