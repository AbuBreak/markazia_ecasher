import 'package:provider/provider.dart';
import 'package:markazia_ecasher/presentation/providers/branch_provider.dart';
import 'package:markazia_ecasher/presentation/providers/language_provider.dart';
import 'package:markazia_ecasher/presentation/providers/login_provider.dart';
import 'package:markazia_ecasher/presentation/providers/service_provider.dart';

List<ChangeNotifierProvider> buildProviders()  {
   return [
    ChangeNotifierProvider(create: (_) => BranchProvider()),
    ChangeNotifierProvider(create: (_) => LanguageProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => ServiceProvider()),
  ];
}
