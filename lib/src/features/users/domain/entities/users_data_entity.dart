import 'users_info_entity.dart';

class UsersDataEntity {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UsersInfoEntity> data;

  const UsersDataEntity({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });
}
