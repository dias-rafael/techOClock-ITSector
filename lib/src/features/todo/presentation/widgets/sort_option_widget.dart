import 'package:flutter/material.dart';

import '../../../../core/sort_type_enum.dart';

class SortOptionWidget extends StatelessWidget {
  final String sortOptionName;
  final SortType value;
  final SortType groupValue;
  final Function onSelect;
  const SortOptionWidget({
    super.key,
    required this.sortOptionName,
    required this.value,
    required this.groupValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 5),
      onTap: () {},
      title: Row(
        children: [
          Expanded(
            child: Text(
              sortOptionName,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      trailing: Transform.scale(
        scale: 1.2,
        child: Radio<SortType>(
          value: value,
          groupValue: groupValue,
          onChanged: (sortTypeSelected) {
            onSelect(sortTypeSelected);
          },
        ),
      ),
    );
  }
}
