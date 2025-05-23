import 'package:flutter/material.dart';
import 'package:markazia_ecasher/api/api_service.dart';
import 'package:markazia_ecasher/models/get_branches.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BranchProvider with ChangeNotifier {
  final ApiService apiService = ApiService();

  List<Data> branches = [];
  List<String> filteredOptions = [];
  bool isLoading = false;
  String? error;
  String? selectedBranch;
  bool hasChanged = false;

  final List<String> _allFormattedOptions = [];

  Future<void> loadBranches() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await apiService.fetchBranches();

      if (response.success == true && response.data != null) {
        branches = response.data!;
        _allFormattedOptions.clear();

        for (var branch in branches) {
          final branchName = branch.branchNameEn ?? '';
          final services = branch.services ?? [];

          for (var service in services) {
            final serviceName = service.nameEn ?? '';
            final formatted = '$branchName ($serviceName)';

            _allFormattedOptions.add(formatted);
          }
        }

        filteredOptions = List.from(_allFormattedOptions);
        error = null;

        await _saveBranchesToPrefs(branches);
      } else {
        error = response.message ?? 'Unknown error';
      }
    } catch (e) {
      error = e.toString();
      debugPrint('Error fetching branches: $error');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> _saveBranchesToPrefs(List<Data> branches) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> branchList =
        branches.map((b) => b.toJson()).toList();
    await prefs.setString('cached_branches', jsonEncode(branchList));
  }

  Future<void> loadBranchesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cached = prefs.getString('cached_branches');
    if (cached != null) {
      final List<dynamic> decoded = jsonDecode(cached);
      branches = decoded.map((e) => Data.fromJson(e)).toList();
      _allFormattedOptions.clear();
      for (var branch in branches) {
        final branchName = branch.branchNameEn ?? '';
        final services = branch.services ?? [];
        for (var service in services) {
          final serviceName = service.nameEn ?? '';
          final formatted = '$branchName ($serviceName)';
          _allFormattedOptions.add(formatted);
        }
      }
      filteredOptions = List.from(_allFormattedOptions);
      notifyListeners();
    }
  }

  void filterOptions(String input) {
    filteredOptions =
        _allFormattedOptions
            .where(
              (option) => option.toLowerCase().contains(input.toLowerCase()),
            )
            .toList();
    notifyListeners();
  }

  void setSelectedBranch(String? branch) {
    selectedBranch = branch;
    hasChanged = true;
    notifyListeners();
  }

  void clearData() {
    branches = [];
    filteredOptions = [];
    isLoading = false;
    error = null;
    selectedBranch = null;
    hasChanged = false;
    _allFormattedOptions.clear();
    notifyListeners();
  }
}
