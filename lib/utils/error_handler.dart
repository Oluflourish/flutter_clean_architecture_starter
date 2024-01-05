import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/services/dialog_service.dart';
import 'package:flutter_clean_architecture/utils/enums.dart';

class DioErrorHandler {
  handleStringError(String errorMessage) {
    DialogService dialogService = DialogService();

    // print('errorMessage:: $errorMessage');

    dialogService.showSnackBar(errorMessage, appToastType: AppToastType.error);
  }

  handleError(DioError dioError) {
    DialogService dialogService = DialogService();

    // print('dioError.response!.data:: ${dioError.response!.data}');

    String errorMessage =
        errorMessageParser(dioError.response?.data) ?? 'An error occured';

    // print('errorMessage:: $errorMessage');

    dialogService.showSnackBar(errorMessage, appToastType: AppToastType.error);
  }

  String getErrorMessage(DioError? dioError) {
    return errorMessageParser(dioError?.response?.data) ?? 'An error occured';
  }

  String? errorMessageParser(Map errorJson,
      {showSingleError = false, showErrorKey = false}) {
    String? message;

    bool shouldShowMessageError = errorJson['errors'] == null;

    if (errorJson['message'] is String && shouldShowMessageError)
      return errorJson['message'];

    if (errorJson['errors'] is String) return errorJson['errors'];

    errorJson = errorJson['errors'] != null ? errorJson['errors'] : errorJson;

    List<String>? errorKeys = errorJson.keys.cast<String>().toList();

    formartErrorKey(String value) {
      String v = value.replaceAll('_', ' ');
      String res = v[0].toUpperCase() + v.substring(1);
      return res;
    }

    if (errorKeys.length > 0) {
      if (showSingleError) {
        message = errorJson[errorKeys[0]][0];
      } else {
        String _message = '';
        for (var errorKey in errorKeys) {
          String separator = _message.isEmpty ? '' : '\n';
          var err = errorJson[errorKey];
          _message += showErrorKey
              ? "$separator${formartErrorKey(errorKey)}: ${err is String ? err : err[0]}"
              : "$separator${err is String ? err : err[0]}";
        }
        message = _message;
      }
    }

    return message;
  }
}
