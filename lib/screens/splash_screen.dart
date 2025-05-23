import 'package:flutter/material.dart';
import 'package:markazia_ecasher/providers/branch_provider.dart';
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
    await provider.loadBranches();

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
          Image.asset('assets/app-background.gif', fit: BoxFit.cover),
          Container(color: Colors.black.withValues(),),
          Center(
            child: Image.asset('assets/app-logo.png', width: 180, height: 180),
          ),
        ],
      ),
    );
  }
}
