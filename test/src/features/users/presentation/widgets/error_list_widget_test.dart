import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/src/features/users/presentation/widgets/error_list_widget.dart';

void main() {
  testWidgets('ErrorListWidget has a message', (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: ErrorListWidget(message: 'Error Message')));
    final messageFinder = find.text('Error Message');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(messageFinder, findsOneWidget);
  });
}
