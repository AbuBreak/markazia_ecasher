import 'package:flutter/material.dart';
import 'package:markazia_ecasher/api/api_service.dart';

class LoginProvider extends ChangeNotifier {
  String employeeNumber = '';
  String password = '';
  String? employeeError;
  String? passwordError;

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
    try {
      final response = await apiService.login(employeeNum, employeePass);

      debugPrint('Login API response: $response');
      if (response.success == true) {
        isAuthenticated = true;
        error = null;
        errorTitle = null;
      } else {
        error = response.status ?? 'Unknown error';
        errorTitle = response.title ?? 'Unknown error';
      }
    } catch (e) {
      error = e.toString();
      debugPrint('Error while trying to login: $error');
    }

    isLoading = false;
    notifyListeners();
  }
}
