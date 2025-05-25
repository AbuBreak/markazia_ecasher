import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:markazia_ecasher/presentation/providers/language_provider.dart';
import 'package:markazia_ecasher/presentation/routes/app_router.dart';
import 'package:markazia_ecasher/presentation/screens/splash/splash_screen.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageProvider>().currentLocale;
    const List<Locale> supportedLocales = [Locale('en', ''), Locale('ar', '')];

    return MaterialApp.router(
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: locale,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      builder: (context, child) {
        final appName = AppLocalizations.of(context).appName;
        return Title(
          title: appName,
          color: Colors.blue,
          child: child ?? const SplashScreen(),
        );
      },
    );
  }
}
