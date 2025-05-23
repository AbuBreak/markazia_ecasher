import 'package:markazia_ecasher/models/get_branches.dart';

class SelectedBranch {
  int? id;
  String? branchName;
  String? serviceName;
  List<Services>? services;

  SelectedBranch({this.id, this.branchName, this.serviceName, this.services});

  factory SelectedBranch.fromData(Data data) {
    return SelectedBranch(
      id: data.id,
      branchName: data.branchNameEn,
      services: data.services,
      serviceName: data.services?.map((service) => service.nameEn).join(', '),
    );
  }
}
