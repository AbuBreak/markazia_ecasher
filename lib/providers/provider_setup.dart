import 'package:provider/provider.dart';
import 'package:markazia_ecasher/providers/branch_provider.dart';
import 'package:markazia_ecasher/providers/language_provider.dart';
import 'package:markazia_ecasher/providers/login_provider.dart';
import 'package:markazia_ecasher/providers/service_provider.dart';

List<ChangeNotifierProvider> buildProviders()  {
   return [
    ChangeNotifierProvider(create: (_) => BranchProvider()),
    ChangeNotifierProvider(create: (_) => LanguageProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => ServiceProvider()),
  ];
}
