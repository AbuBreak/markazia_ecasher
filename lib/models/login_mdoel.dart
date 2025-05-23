class LoginModel {
  bool? success;
  String? accessToken;
  Permissions? permissions;
  String? status;
  String? title;

  LoginModel({this.success, this.accessToken, this.permissions, this.status, this.title});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    accessToken = json['accessToken'];
    permissions =
        json['permissions'] != null
            ? Permissions.fromJson(json['permissions'])
            : null;
    status = json['status']?.toString();
    title = json['title']?.toString();
  }
}

class Permissions {
  bool? accessLogOut;

  Permissions({this.accessLogOut});

  Permissions.fromJson(Map<String, dynamic> json) {
    accessLogOut = json['accessLogOut'];
  }
}
