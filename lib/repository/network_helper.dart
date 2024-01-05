import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/models/util_model.dart';
import 'package:flutter_clean_architecture/utils/constants.dart';
import 'package:flutter_clean_architecture/utils/enums.dart';
import 'package:flutter_clean_architecture/utils/error_handler.dart';
import 'package:flutter_clean_architecture/utils/http.dart';
import 'package:flutter_clean_architecture/utils/storage_util.dart';

class NetworkHelper {
  final Dio _dio = Dio();

  static const httpTimeoutDuration = 25;

  final kTimeoutResponse = Response(
    data: {"success": false, "message": "Connection Timeout"},
    statusCode: StatusRequestTimeout,
    requestOptions:
        RequestOptions(path: 'Error occurred while connecting to server'),
  );

  Future<HTTPResponseModel> runApi({
    required ApiRequestType type,
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool showError = true,
  }) async {
    _dio.options.baseUrl = AppConstants.kBaseUrl;

    // TODO:: Handle error repsonse on Timeout with Dio. Currently using kTimeoutResponse
    // Not working
    // _dio.options.connectTimeout = httpTimeoutDuration * 1000;
    // _dio.options.receiveTimeout = httpTimeoutDuration * 1000;

    final token = await StorageUtil.getData("token");
    // print('token: $token');

    var kHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    kHeader.addAll(headers ?? {});

    _dio.options.headers = headers ?? kHeader;

    var res;

    try {
      switch (type) {
        case ApiRequestType.get:
          res = await _get(url: url, body: body);
          break;
        case ApiRequestType.post:
          res = await _post(url: url, body: body);

          break;
        case ApiRequestType.put:
          res = await _put(url: url, body: body);
          break;
        case ApiRequestType.patch:
          res = await _patch(url: url, body: body);
          break;
        case ApiRequestType.delete:
          res = await _delete(url: url, body: body);
          break;
        case ApiRequestType.formData:
          res = await _formData(url: url, body: body);
          break;
      }

      // print('res: ${res}');

      if (res.statusCode == StatusRequestTimeout) {
        DioErrorHandler()
            .handleStringError(res.data['message'] ?? 'Connection Timeout');
      }

      if (res.data is String) {
        return HTTPResponseModel.jsonToMap(
            {"success": false, "message": ""}, res.statusCode!);
      }

      return HTTPResponseModel.jsonToMap(res.data, res.statusCode!);
    } on DioError catch (error) {
      final int statusCode = error.response?.statusCode ?? 400;
      // print(statusCode);
      // print(error.response?.data);
      // print('error: ${error.toString()}');
      String errorMessage = DioErrorHandler().getErrorMessage(error);

      if (error.response?.statusCode == StatusUnauthorized &&
          error.response?.data['message'] == 'Unauthenticated') {
        DioErrorHandler()
            .handleStringError('Session expired. Kindly login again');
        // clear token
        await StorageUtil.setData("token", "");
        // g.Get.offAll(LoginWithPin());
      } else if (showError) {
        DioErrorHandler().handleError(error);
      }

      // print('DioError [$statusCode]: $errorMessage');
      return HTTPResponseModel.jsonToMap(error.response?.data, statusCode!,
          errorMessage: errorMessage, success: false);
    } catch (e) {
      print('error: ${e.toString()}');
      rethrow;
    }
  }

  Future<Response> _get({required String url, body}) async {
    return await _dio.get(url).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _post({required String url, body}) async {
    return await _dio.post(url, data: body).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _patch({required String url, body}) async {
    return await _dio.patch(url, data: body).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _put({required String url, body}) async {
    return await _dio.put(url, data: body).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _delete({required String url, body}) async {
    return await _dio.delete(url, data: body).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }

  Future<Response> _formData({required String url, body}) async {
    FormData formData = FormData.fromMap(body);
    return await _dio.post(url, data: formData).timeout(
        const Duration(seconds: httpTimeoutDuration),
        onTimeout: () => kTimeoutResponse);
  }
}
