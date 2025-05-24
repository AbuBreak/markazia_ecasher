import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:markazia_ecasher/screens/branch_page.dart';
import 'package:markazia_ecasher/screens/branch_settings_page.dart';
import 'package:markazia_ecasher/screens/language_page.dart';
import 'package:markazia_ecasher/screens/login_page.dart';
import 'package:markazia_ecasher/screens/service_page.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder:
          (BuildContext context, GoRouterState state) => const BranchPage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder:
              (BuildContext context, GoRouterState state) => const LoginPage(),
        ),
        GoRoute(
          path: 'branch',
          builder:
              (BuildContext context, GoRouterState state) => const BranchPage(),
        ),
        GoRoute(
          path: 'branchSettings',
          builder:
              (BuildContext context, GoRouterState state) =>
                  const BranchSettingsPage(),
        ),
        GoRoute(
          path: 'language',
          builder:
              (BuildContext context, GoRouterState state) =>
                  const LanguagePage(),
        ),
        GoRoute(
          path: 'service',
          builder:
              (BuildContext context, GoRouterState state) =>
                  const ServicePage(),
        ),
      ],
    ),
  ],
);
