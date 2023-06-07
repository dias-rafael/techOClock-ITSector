import 'dart:convert';

class ApiErrorException implements Exception {
  final List<ErrorResponse> errors;
  final Map<String, dynamic> headers;
  final int statusCode;
  final String url;
  final String message;
  final String code;

  ApiErrorException({
    required this.headers,
    required this.statusCode,
    required this.url,
    required this.message,
    required this.code,
    this.errors = const [],
  });

  static ApiErrorException noResponse() => ApiErrorException(
        statusCode: 0,
        url: '',
        message: 'No response found',
        code: 'Uknown',
        headers: {},
        errors: [],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'url': url,
      'message': message,
      'code': code,
      'headers': headers,
      'errors': errors.map((e) => e.toMap()).toList()
    };
  }

  String toJson() => json.encode(toMap());
}

class ErrorResponse {
  final String? code;
  final String? message;

  ErrorResponse({
    this.code,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
    };
  }

  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    return ErrorResponse(
      code: map['errorCode'] as String?,
      message: map['errorMessage'] as String?,
    );
  }
}
