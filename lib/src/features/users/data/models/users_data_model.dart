import 'dart:convert';

import '../../domain/entities/users_data_entity.dart';
import 'users_info_model.dart';

class UsersDataModel extends UsersDataEntity {
  const UsersDataModel({
    required super.page,
    required super.perPage,
    required super.total,
    required super.totalPages,
    required super.data,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page,
      'perPage': perPage,
      'total': total,
      'totalPages': totalPages,
      'data': data,
    };
  }

  factory UsersDataModel.fromMap(dynamic map) {
    return UsersDataModel(
      page: map['page'] as int,
      perPage: map['per_page'] as int,
      total: map['total'] as int,
      totalPages: map['total_pages'] as int,
      data: List.from(map['data'] ?? [])
          .map((e) => UsersInfoModel.fromMap(e))
          .toList(),
    );
  }
}
