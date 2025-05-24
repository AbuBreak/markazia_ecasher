import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:markazia_ecasher/core/constants/app_constant.dart';
import 'package:markazia_ecasher/core/errors/failure.dart';
import 'package:markazia_ecasher/data/models/get_branches.dart';
import 'package:markazia_ecasher/data/models/get_services.dart';
import 'package:markazia_ecasher/data/models/login_mdoel.dart';
import 'package:markazia_ecasher/data/models/update_service_status.dart';

class ApiService {
  Future<Either<Failure, LoginModel>> login(
    String employeeNumber,
    String password,
  ) async {
    try {
      final res = await http.post(
        Uri.parse(AppConstent.loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': employeeNumber, 'password': password}),
      );

      final json = jsonDecode(res.body);
      debugPrint('Login API response: $json');

      if (res.statusCode == 200) {
        return Right(LoginModel.fromJson(json));
      } else if (res.statusCode == 401) {
        return Left(UnauthorizedFailure(json['message'] ?? 'Unauthorized'));
      } else {
        return Left(ServerFailure(json['message'] ?? 'Failed to login'));
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  Future<Either<Failure, GetBranches>> fetchBranches() async {
    try {
      final res = await http.get(Uri.parse(AppConstent.getBranchesUrl));
      final json = jsonDecode(res.body);
      debugPrint('Branch API response: $json');

      if (res.statusCode == 200) {
        return Right(GetBranches.fromJson(json));
      } else {
        return Left(
          ServerFailure(json['message'] ?? 'Failed to fetch branches'),
        );
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  Future<Either<Failure, GetServices>> getServices(
    String branchId,
    String accessToken,
  ) async {
    try {
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

      final json = jsonDecode(res.body);
      debugPrint('getServices API response: $json');

      if (res.statusCode == 200) {
        return Right(GetServices.fromJson(json));
      } else if (res.statusCode == 401) {
        return Left(UnauthorizedFailure(json['message'] ?? 'Unauthorized'));
      } else {
        return Left(
          ServerFailure(json['message'] ?? 'Failed to fetch services'),
        );
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  Future<Either<Failure, UpdateServiceStatus>> updateServiceStatus({
    required int branchId,
    required int serviceId,
    required bool isEnabled,
    required String accessToken,
  }) async {
    try {
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

      final json = jsonDecode(res.body);
      debugPrint('Update Service Status API response: $json');

      if (res.statusCode == 200) {
        return Right(UpdateServiceStatus.fromJson(json));
      } else if (res.statusCode == 401) {
        return Left(UnauthorizedFailure(json['message'] ?? 'Unauthorized'));
      } else {
        return Left(
          ServerFailure(json['message'] ?? 'Failed to update status'),
        );
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
