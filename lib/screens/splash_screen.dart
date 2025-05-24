import 'package:flutter/material.dart';
import 'package:markazia_ecasher/models/assets.dart';
import 'package:markazia_ecasher/providers/branch_provider.dart';
import 'package:markazia_ecasher/providers/language_provider.dart';
import 'package:markazia_ecasher/screens/branch_page.dart';
import 'package:provider/provider.dart';

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
    var provider = Provider.of<BranchProvider>(context, listen: false);
    final selectedLang =
        Provider.of<LanguageProvider>(context, listen: false).currentLocale;
    await provider.loadBranches(selectedLang.languageCode);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BranchPage()),
      );
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
