import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:markazia_ecasher/providers/branch_provider.dart';
import 'package:markazia_ecasher/providers/login_provider.dart';
import 'package:markazia_ecasher/providers/service_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:markazia_ecasher/providers/language_provider.dart';
// import 'package:markazia_ecasher/providers/provider_setup.dart';
import 'package:markazia_ecasher/screens/splash_screen.dart';
import 'package:markazia_ecasher/routes/app_router.dart';

const List<Locale> supportedLocales = [Locale('en', ''), Locale('ar', '')];

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

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageProvider>().currentLocale;

    return MaterialApp.router(
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: locale,
      title: 'Markazia E-Casher',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      builder: (context, child) => child ?? const SplashScreen(),
    );
  }
}
