import 'package:flutter/material.dart';
import 'package:todo_app/src/core/strings_constants.dart';

class ErrorListWidget extends StatelessWidget {
  final String message;

  const ErrorListWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.info_outline_rounded,
            color: Colors.red,
            size: 50,
          ),
          const Text(
            StringsConstants.errorText,
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
