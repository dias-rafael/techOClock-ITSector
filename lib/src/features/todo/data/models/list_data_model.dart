import 'dart:convert';

import '../../domain/entities/list_data_entity.dart';

class ListDataModel extends ListDataEntity {
  const ListDataModel({
    required super.index,
    required super.name,
    required super.isFinished,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'index': index,
      'name': name,
      'isFinished': isFinished,
    };
  }

  factory ListDataModel.fromMap(Map<String, dynamic> map) {
    return ListDataModel(
      index: map['index'] as int,
      name: map['name'] as String,
      isFinished: map['isFinished'] as bool,
    );
  }
}
