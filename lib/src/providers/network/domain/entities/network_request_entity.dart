import 'package:flutter/foundation.dart';

class NetworkRequest {
  final String? method;
  final String endpoint;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? queryParameters;

  const NetworkRequest({
    required this.endpoint,
    this.method,
    this.headers,
    this.body,
    this.queryParameters,
  });

  @override
  bool operator ==(covariant NetworkRequest other) {
    if (identical(this, other)) return true;

    return other.endpoint == endpoint && mapEquals(other.body, body);
  }

  @override
  int get hashCode {
    return endpoint.hashCode ^ body.hashCode;
  }
}
