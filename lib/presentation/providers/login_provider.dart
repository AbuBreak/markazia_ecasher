import 'package:flutter/material.dart';
import 'package:markazia_ecasher/data/datasources/remote/api_service.dart';

class LoginProvider extends ChangeNotifier {
  String employeeNumber = '';
  String password = '';
  String? employeeError;
  String? passwordError;
  String? accessToken;

  final ApiService apiService = ApiService();
  bool isLoading = false;
  bool isAuthenticated = false;
  String? error;
  String? errorTitle;

  void setEmployeeNumber(String value) {
    employeeNumber = value;
    employeeError = null;
    notifyListeners();
  }

  String get employeeNum => employeeNumber;

  void setPassword(String value) {
    password = value;
    passwordError = null;
    notifyListeners();
  }

  String get employeePass => password;

  bool validate() {
    bool valid = true;
    if (employeeNumber.isEmpty) {
      employeeError = '*This field is required';
      valid = false;
    } else {
      employeeError = null;
    }
    if (password.isEmpty) {
      passwordError = '*This field is required';
      valid = false;
    } else {
      passwordError = null;
    }
    notifyListeners();
    return valid;
  }

  void clearData() {
    employeeError = null;
    passwordError = null;
    error = null;
    errorTitle = null;
    employeeNumber = '';
    password = '';
    employeeError = null;
    passwordError = null;
    error = null;
    errorTitle = null;
    notifyListeners();
  }

  Future<void> userLogin(String employeeNum, String employeePass) async {
    isLoading = true;
    notifyListeners();

    final result = await apiService.login(employeeNum, employeePass);

    result.fold(
      (failure) {
        error = failure.message;
        errorTitle = 'Login Failed';
        isAuthenticated = false;
        debugPrint('Login failed: $error');
      },
      (response) {
        if (response.success == true) {
          accessToken = response.accessToken;
          isAuthenticated = true;
          error = null;
          errorTitle = null;
          debugPrint('Login successful. Access token: $accessToken');
        } else {
          error = response.status ?? 'Unknown error';
          errorTitle = response.title ?? 'Login Failed';
          isAuthenticated = false;
        }
      },
    );

    isLoading = false;
    notifyListeners();
  }
}
