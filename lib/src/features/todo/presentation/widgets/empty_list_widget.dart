import 'package:flutter/material.dart';
import 'package:todo_app/src/core/strings_constants.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.info_outline_rounded,
            color: Colors.blue[800],
            size: 50,
          ),
          Text(
            StringsConstants.emptyListText,
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue[800],
            ),
          ),
        ],
      ),
    );
  }
}
