import 'package:flutter/material.dart';


class ServiceProvider extends ChangeNotifier {
  final optionItems = [
    {'id': '1','title': 'Service Control'},
    {'id': '2','title': 'Branch Selection'},
    {'id': '3','title': 'Sign Out'},
  ];


  Future<void> getBranchServices() async {
    //TODO: Implement the logic to get branch services

  }

}
