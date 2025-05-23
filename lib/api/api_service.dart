import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:markazia_ecasher/models/app_constent.dart';
import 'package:markazia_ecasher/models/get_branches.dart';
import 'package:markazia_ecasher/models/get_services.dart';
import 'package:markazia_ecasher/models/login_mdoel.dart';
import 'package:markazia_ecasher/models/update_service_status.dart';

class ApiService {
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

  Future<GetServices> getServices(String branchId, String accessToken) async {
    final uri = Uri.parse(
      AppConstent.getServicesUrl,
    ).replace(queryParameters: {'branchId': branchId});

    final res = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      debugPrint('getServices API response: $json');
      return GetServices.fromJson(json);
    } else {
      debugPrint('getServices API failed: ${res.body}');
      throw Exception('Failed to fetch services');
    }
  }

  Future<UpdateServiceStatus> updateServiceStatus({
    required int branchId,
    required int serviceId,
    required bool isEnabled,
    required String accessToken,
  }) async {
    final uri = Uri.parse(AppConstent.updateServiceStatusUrl);
    final body = {
      "branchId": branchId,
      "serviceId": serviceId,
      "isEnabled": isEnabled,
    };
    final res = await http.put(
      uri,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      debugPrint('Update Service Status API response: $json');
      return UpdateServiceStatus.fromJson(json);
    } else {
      debugPrint('Update Service Status API failed: ${res.body}');
      throw Exception('Failed to update service status');
    }
  }
}
