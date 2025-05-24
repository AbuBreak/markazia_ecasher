class UpdateServiceStatus {
  bool? success;
  String? message;

  UpdateServiceStatus({this.success, this.message});

  UpdateServiceStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}
