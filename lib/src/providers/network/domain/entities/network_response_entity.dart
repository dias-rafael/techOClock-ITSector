class NetworkResponse {
  final String? method;
  final int? statusCode;
  final String? statusMessage;
  final String? url;
  final dynamic body;
  final Map<String, dynamic>? headers;

  NetworkResponse({
    this.method,
    this.statusCode,
    this.url,
    this.body,
    this.headers,
    this.statusMessage,
  });
}
