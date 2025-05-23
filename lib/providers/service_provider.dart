import 'package:flutter/material.dart';
import 'package:markazia_ecasher/api/api_service.dart';
import 'package:markazia_ecasher/models/get_services.dart';

class ServiceProvider extends ChangeNotifier {
  final optionItems = [
    {'id': '1', 'title': 'Service Control'},
    {'id': '2', 'title': 'Branch Selection'},
    {'id': '3', 'title': 'Sign Out'},
  ];
  bool isLoading = false;
  bool isToggled = false;
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
    try {
      final response = await apiService.getServices(branchId, accessToken);

      if (response.success == true) {
        debugPrint('getBranchServices API response: $response');

        if (response.data != null) {
          services = response.data!.services ?? [];
          toggledIndices.clear();
          for (int i = 0; i < services.length; i++) {
            toggledIndices[i] = services[i].isEnabled ?? false;
          }
        }
      } else {
        error = response.message;
        debugPrint('getBranchServices API error: ${response.message}');
      }
    } catch (e) {
      isLoading = false;
      debugPrint('getBranchServices API catch error: $e');
    }

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
      await apiService.updateServiceStatus(
        branchId: branchId,
        serviceId: service.serviceId ?? 0,
        isEnabled: isEnabled,
        accessToken: accessToken,
      );
    }
  }
}
