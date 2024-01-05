import 'package:flutter_clean_architecture/utils/http.dart';

class HTTPResponseModel {
  HTTPResponseModel();

  static bool isApiCallSuccess(HTTPResponseModel data) {
    if (data.code >= StatusMultipleChoices || data.success == false) {
      return false;
    }
    return true;
  }

  int? _code;
  bool? _success;
  String? _message;
  dynamic _error;
  String? _errorMessage;
  dynamic _data;

  int get code => _code!;
  bool get success => _success!;
  String? get message => _message;
  dynamic get error => _error;
  String get errorMessage => _errorMessage!;
  dynamic get data => _data;

  set setSuccess(int code) => _code = code;
  set setStatus(bool success) => _success = success;
  set setErrorMessage(String message) => _message = message;
  set setError(error) => _error = error;
  set setData(data) => _data = data;

  HTTPResponseModel.jsonToMap(Map<dynamic, dynamic> parsedJson, int statusCode,
      {String? errorMessage, bool? success}) {
    _code = statusCode;
    _success = success ?? (parsedJson['success'] ?? false);
    _message = parsedJson['message'].toString();
    _error = parsedJson['error'];
    _errorMessage = errorMessage;
    _data = parsedJson['data'];
  }
}

class ErrorResponseModel {
  ErrorResponseModel(
      {this.success = false,
      this.code = StatusBadRequest,
      required this.error});
  final bool success;
  final int code;
  final String error;
}
