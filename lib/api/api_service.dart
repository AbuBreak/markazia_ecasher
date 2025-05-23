import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:markazia_ecasher/models/app_constent.dart';
import 'package:markazia_ecasher/models/get_branches.dart';
import 'package:markazia_ecasher/models/get_services.dart';
import 'package:markazia_ecasher/models/login_mdoel.dart';

class ApiService {
  Future<GetBranches> fetchBranches() async {
    final response = await http.get(Uri.parse(AppConstent.getBranchesUrl));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      debugPrint('Branch API response: $json');

      return GetBranches.fromJson(json);
    } else {
      debugPrint('Branch API failed: ${response.body}');
      throw Exception('Failed to fetch branches');
    }
  }

  Future<LoginModel> login(String employeeNumber, String password) async {
    final res = await http.post(
      Uri.parse(AppConstent.loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': employeeNumber, 'password': password}),
    );

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      debugPrint('Login API response: $json');
      return LoginModel.fromJson(json);
    } else {
      debugPrint('Login API failed: ${res.body}');
      throw Exception('Failed to login');
    }
  }

  Future<GetServices> getServices(String branchId) async {
    //TODO: call the API to get services by branch ID
    final res = await http.get(
      Uri.parse(AppConstent.getServicesUrl + branchId),
    );

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      debugPrint('Login API response: $json');
      return GetServices.fromJson(json);
    } else {
      debugPrint('Services API failed: ${res.body}');
      throw Exception('Failed to fetch services');
    }
  }
}
