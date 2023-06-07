import 'dart:convert';

import '../../domain/entities/network_request_entity.dart';

class NetworkRequestModel extends NetworkRequest {
  const NetworkRequestModel({
    super.method,
    required super.endpoint,
    super.headers,
    super.body,
    super.queryParameters,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'endpoint': endpoint});

    if (method != null) {
      result.addAll({'method': method});
    }

    if (headers != null) {
      result.addAll({'headers': headers});
    }
    if (body != null) {
      result.addAll({'body': body});
    }
    if (queryParameters != null) {
      result.addAll({'queryParameters': queryParameters});
    }

    return result;
  }

  factory NetworkRequestModel.fromMap(Map<String, dynamic> map) {
    return NetworkRequestModel(
        method: map['method'],
        endpoint: map['endpoint'],
        headers: map['headers'],
        body: map['body'],
        queryParameters: map['queryParameters']);
  }

  String toJson() => json.encode(toMap());

  factory NetworkRequestModel.fromJson(dynamic map) =>
      NetworkRequestModel.fromMap(json.decode(map));
}
