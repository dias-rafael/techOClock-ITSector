import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogWidget extends StatelessWidget {
  final String title;
  final String primaryButtonLabel;
  final String secondaryButtonLabel;
  final Function primaryButtomTap;
  final Function secondaryButtomTap;
  const CustomDialogWidget({
    super.key,
    required this.title,
    required this.primaryButtonLabel,
    required this.secondaryButtonLabel,
    required this.primaryButtomTap,
    required this.secondaryButtomTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.warning_amber,
        color: Colors.red,
        size: 40,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                primaryButtomTap();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: (Platform.isIOS)
                    ? CupertinoTheme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).colorScheme.background,
                backgroundColor: (Platform.isIOS)
                    ? CupertinoTheme.of(context).primaryColor
                    : Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                primaryButtonLabel,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                secondaryButtomTap();
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: (Platform.isIOS)
                      ? CupertinoTheme.of(context).primaryColor
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Text(
                secondaryButtonLabel,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
