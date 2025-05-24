class AppConstent {
  static String apiUrl = 'https://ecashiertest.markaziaapis.com/api';
  static String loginUrl = '$apiUrl/Users/loginToken';
  static String getBranchesUrl = '$apiUrl/Branch/GetBranch';
  static String getServicesUrl =
      '$apiUrl/Kiosk/GetSettingsBybranchId?branchId=';
  static String updateServiceStatusUrl =
      '$apiUrl/Kiosk/UpdateBranchServiceStatus';
}
