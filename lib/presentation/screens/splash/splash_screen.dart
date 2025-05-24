import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:markazia_ecasher/core/utils/assets.dart';
// import 'package:markazia_ecasher/presentation/providers/branch_provider.dart';
// import 'package:markazia_ecasher/presentation/providers/language_provider.dart';
// import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(CusotmAssets.logoAssets[6], fit: BoxFit.cover),
          Container(color: Colors.black.withValues()),
          Center(
            child: Image.asset(
              CusotmAssets.logoAssets[4],
              width: 180,
              height: 180,
            ),
          ),
        ],
      ),
    );
  }
}
