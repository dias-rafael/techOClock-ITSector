import 'package:flutter/material.dart';
import 'package:todo_app/src/features/users/domain/entities/users_info_entity.dart';

class UsersDetailsPage extends StatefulWidget {
  final UsersInfoEntity userData;

  const UsersDetailsPage({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<UsersDetailsPage> createState() => _UsersDetailsPageState();
}

class _UsersDetailsPageState extends State<UsersDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "${widget.userData.firstName} ${widget.userData.lastName}",
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff00002f),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Hero(
                tag: widget.userData.avatar,
                child: Image.network(
                  widget.userData.avatar,
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
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.userData.email,
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
