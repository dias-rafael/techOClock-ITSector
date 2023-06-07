import 'package:flutter/material.dart';

import '../../domain/entities/users_info_entity.dart';

class UsersCardWidget extends StatelessWidget {
  final UsersInfoEntity userData;
  final Function() onTap;
  const UsersCardWidget({
    super.key,
    required this.userData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 5),
      onTap: () => onTap(),
      title: Text(
        "${userData.firstName} ${userData.lastName}",
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Text(
        userData.email,
        style: const TextStyle(fontSize: 15),
      ),
      trailing: SizedBox(
        width: 60,
        child: Hero(
          tag: userData.avatar,
          child: Image.network(
            userData.avatar,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress != null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return child;
              }
            },
          ),
        ),
      ),
    );
  }
}
