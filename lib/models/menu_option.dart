import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OptionItems {
  static List<Map<String, String>> get(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return [
      {'id': '1', 'title': localizations.serviceControl},
      {'id': '2', 'title': localizations.branchSelection},
      {'id': '3', 'title': localizations.signOut},
    ];
  }
}
