import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/models/user_model.dart';
import 'package:flutter_clean_architecture/models/util_model.dart';
import 'package:flutter_clean_architecture/repository/auth_repository.dart';
import 'package:flutter_clean_architecture/services/dialog_service.dart';
import 'package:flutter_clean_architecture/utils/storage_util.dart';

class AccountProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  DialogService dialogService = DialogService(); // TODO: lazyload using locator

  User? _user;
  User? get user => _user;

  bool isLoading = false;

  // Setters
  setLoading(bool value) async {
    isLoading = value;
    notifyListeners();
  }

  void updateUser(User user) {
    _user = user;
    notifyListeners();
  }

  // login
  loginUser(BuildContext context, {required Map<String, dynamic> body}) async {
    setLoading(true);

    HTTPResponseModel res = await _authRepository.login(body);

    if (HTTPResponseModel.isApiCallSuccess(res)) {
      User userData = User.fromJson(res.data['user']);
      String token = res.data['token'];
      await StorageUtil.setData("token", token);
      await StorageUtil.setData("email", userData.email);

      setLoading(false);
      // navigatorRote(context, TabScreen());
    }
    setLoading(false);
  }
}
