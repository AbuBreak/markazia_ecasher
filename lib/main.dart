import 'package:flutter/material.dart';
import 'package:markazia_ecasher/core/utils/app_view.dart';
import 'package:markazia_ecasher/presentation/providers/branch_provider.dart';
import 'package:markazia_ecasher/presentation/providers/login_provider.dart';
import 'package:markazia_ecasher/presentation/providers/service_provider.dart';
import 'package:provider/provider.dart';
import 'package:markazia_ecasher/presentation/providers/language_provider.dart';
// import 'package:markazia_ecasher/providers/provider_setup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    //TODO: When trying to use provider setup, it causes an error
    // because the providers are not initialized correctly.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BranchProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}