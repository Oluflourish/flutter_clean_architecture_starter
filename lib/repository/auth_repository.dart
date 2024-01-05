import 'package:flutter_clean_architecture/models/util_model.dart';
import 'package:flutter_clean_architecture/repository/network_helper.dart';
import 'package:flutter_clean_architecture/utils/enums.dart';

class AuthRepository {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<HTTPResponseModel> login(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth/login",
      body: body,
    );
  }

  Future<HTTPResponseModel> registerUser(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth/register",
      body: body,
    );
  }

  Future<HTTPResponseModel> getProfile(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.get,
      url: "profile",
      body: body,
    );
  }

  Future<HTTPResponseModel> resetPassword(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth/reset-password",
      body: body,
    );
  }

  Future<HTTPResponseModel> forgotPassword(Map<String, dynamic> body) async {
    return await _networkHelper.runApi(
      type: ApiRequestType.post,
      url: "auth/forgot-password",
      body: body,
    );
  }
}
