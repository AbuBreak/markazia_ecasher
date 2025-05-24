import 'package:flutter/material.dart';
import 'package:markazia_ecasher/core/errors/failure.dart';
import 'package:markazia_ecasher/data/datasources/remote/api_service.dart';
import 'package:markazia_ecasher/data/models/get_services.dart';

class ServiceProvider extends ChangeNotifier {
  bool isLoading = false;
  String? error;
  final Map<int, bool> toggledIndices = {};

  List<Services> services = [];
  final ApiService apiService = ApiService();

  void toggleService(int index, bool value) {
    toggledIndices[index] = value;
    notifyListeners();
  }

  void clearToggles() {
    toggledIndices.clear();
    notifyListeners();
  }

  Future<void> getBranchServices(String branchId, String accessToken) async {
    debugPrint('getBranchServices called with branchId: $branchId');
    debugPrint('getBranchServices called with accessToken: $accessToken');
    isLoading = true;
    notifyListeners();

    final result = await apiService.getServices(branchId, accessToken);

    result.fold(
      (Failure failure) {
        error = failure.message;
        services = [];
        toggledIndices.clear();
        debugPrint('getBranchServices error: $error');
      },
      (GetServices response) {
        services = response.data?.services ?? [];
        toggledIndices.clear();
        for (int i = 0; i < services.length; i++) {
          toggledIndices[i] = services[i].isEnabled ?? false;
        }
        error = null;
      },
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateAllServiceStatuses(
    int branchId,
    String accessToken,
  ) async {
    for (int i = 0; i < services.length; i++) {
      final service = services[i];
      final isEnabled = toggledIndices[i] ?? false;

      final result = await apiService.updateServiceStatus(
        branchId: branchId,
        serviceId: service.serviceId ?? 0,
        isEnabled: isEnabled,
        accessToken: accessToken,
      );

      result.fold(
        (Failure failure) {
          debugPrint(
            'Failed to update service ${service.serviceId}: ${failure.message}',
          );
        },
        (_) {
          debugPrint('Service ${service.serviceId} updated successfully.');
        },
      );
    }
  }
}
