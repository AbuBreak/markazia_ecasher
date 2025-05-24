class GetBranches {
  bool? success;
  String? message;
  List<Data>? data;
  String? errorCode;

  GetBranches({this.success, this.message, this.data, this.errorCode});

  GetBranches.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
  }
}

class Data {
  int? id;
  String? branchNameAr;
  String? branchNameEn;
  List<Services>? services;

  Data({this.id, this.branchNameAr, this.branchNameEn, this.services});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchNameAr = json['branchNameAr'];
    branchNameEn = json['branchNameEn'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['branchNameAr'] = branchNameAr;
    data['branchNameEn'] = branchNameEn;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? nameEn;
  String? nameAr;

  Services({this.id, this.nameEn, this.nameAr});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['nameEn'];
    nameAr = json['nameAr'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nameEn'] = nameEn;
    data['nameAr'] = nameAr;
    return data;
  }
}
