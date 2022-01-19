import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(jsonDecode(str));

class ErrorResponse {
  int? code;
  String? message;
  ErrorResponse({this.code, this.message});
  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        code: json['code'],
        message: json['message'],
      );
}
