class GetServices {
  bool? success;
  String? message;
  Data? data;

  GetServices({this.success, this.message, this.data});

  GetServices.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? branchId;
  String? branchNameAr;
  String? branchNameEn;
  List<Services>? services;

  Data({this.branchId, this.branchNameAr, this.branchNameEn, this.services});

  Data.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    branchNameAr = json['branchNameAr'];
    branchNameEn = json['branchNameEn'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
  }
}

class Services {
  int? serviceId;
  String? serviceNameEn;
  String? serviceNameAr;
  bool? isEnabled;

  Services({
    this.serviceId,
    this.serviceNameEn,
    this.serviceNameAr,
    this.isEnabled,
  });

  Services.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceNameEn = json['serviceNameEn'];
    serviceNameAr = json['serviceNameAr'];
    isEnabled = json['isEnabled'];
  }
}
