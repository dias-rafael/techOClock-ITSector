import 'package:flutter/material.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  final String title;
  final BuildContext context;
  final Widget body;
  const CustomBottomSheetWidget({
    super.key,
    required this.title,
    required this.context,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              color: Colors.grey[300],
            ),
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue[900],
              ),
            ),
          ),
          body,
        ],
      ),
    );
  }
}
