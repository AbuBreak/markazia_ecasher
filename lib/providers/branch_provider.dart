import 'package:flutter/material.dart';
import 'package:markazia_ecasher/api/api_service.dart';
import 'package:markazia_ecasher/models/branch_model.dart';
import 'package:markazia_ecasher/models/get_branches.dart';
import 'package:markazia_ecasher/models/languuage_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BranchProvider with ChangeNotifier {
  final ApiService apiService = ApiService();

  List<Data> branches = [];
  List<SelectedBranch> filteredOptions = [];
  bool isLoading = false;
  String? error;
  SelectedBranch? selectedBranch;
  bool hasChanged = false;

  final List<SelectedBranch> _allFormattedOptions = [];

  Future<void> loadBranches(String lang) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await apiService.fetchBranches();

      if (response.success == true && response.data != null) {
        branches = response.data!;
        _allFormattedOptions.clear();

        for (var branch in branches) {
          final branchName =
              lang == LanguageEnumHelper.getLanguageName(LanguageEnum.english)
                  ? branch.branchNameEn
                  : branch.branchNameAr;
          final services = branch.services ?? [];
          final branchId = branch.id;

          for (var service in services) {
            final serviceName =
                lang == LanguageEnumHelper.getLanguageName(LanguageEnum.english)
                    ? service.nameEn
                    : service.nameAr;
            _allFormattedOptions.add(
              SelectedBranch(
                id: branchId,
                branchName: branchName,
                serviceName: serviceName,
                services: services,
              ),
            );
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

  Future<void> loadBranchesFromPrefs(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    final String? cached = prefs.getString('cached_branches');
    if (cached != null) {
      final List<dynamic> decoded = jsonDecode(cached);
      branches = decoded.map((e) => Data.fromJson(e)).toList();
      _allFormattedOptions.clear();
      for (var branch in branches) {
        final branchName =
            lang == LanguageEnumHelper.getLanguageName(LanguageEnum.english)
                ? branch.branchNameEn
                : branch.branchNameAr;
        final services = branch.services ?? [];
        final branchId = branch.id;

        for (var service in services) {
          final serviceName =
              lang == LanguageEnumHelper.getLanguageName(LanguageEnum.english)
                  ? service.nameEn
                  : service.nameAr;
          _allFormattedOptions.add(
            SelectedBranch(
              id: branchId,
              branchName: branchName,
              serviceName: serviceName,
              services: services,
            ),
          );
        }
      }
      filteredOptions = List.from(_allFormattedOptions);
      notifyListeners();
    }
  }

  void filterOptions(String input) {
    filteredOptions =
        selectedBranchOptions
            .where(
              (option) =>
                  option.branchName!.toLowerCase().contains(
                    input.toLowerCase(),
                  ) ||
                  option.serviceName!.toLowerCase().contains(
                    input.toLowerCase(),
                  ),
            )
            .toList();
    notifyListeners();
  }

  void setSelectedBranch(SelectedBranch? branch) {
    selectedBranch = branch;
    hasChanged = true;
    notifyListeners();
  }

  List<SelectedBranch> get selectedBranchOptions =>
      List.from(_allFormattedOptions);

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
