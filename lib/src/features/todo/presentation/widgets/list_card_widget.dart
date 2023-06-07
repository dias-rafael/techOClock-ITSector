import 'package:flutter/material.dart';

class ListCardWidget extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool?) onTap;
  const ListCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 5),
      onTap: () => onTap(null),
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      trailing: Transform.scale(
        scale: 1.2,
        child: Checkbox(
          onChanged: (value) => onTap(value),
          value: value,
        ),
      ),
    );
  }
}
