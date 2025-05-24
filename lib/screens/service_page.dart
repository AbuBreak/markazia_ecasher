// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markazia_ecasher/models/assets.dart';
import 'package:markazia_ecasher/models/menu_option.dart';
import 'package:markazia_ecasher/providers/branch_provider.dart';
import 'package:markazia_ecasher/providers/language_provider.dart';
import 'package:markazia_ecasher/providers/login_provider.dart';
import 'package:markazia_ecasher/providers/service_provider.dart';
import 'package:markazia_ecasher/screens/branch_page.dart';
import 'package:markazia_ecasher/screens/branch_settings_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(
      context,
      listen: false,
    );
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CusotmAssets.logoAssets[6]),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    CusotmAssets.logoAssets[4],
                    width: width * 0.35,
                    height: height * 0.15,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 3,
                      separatorBuilder:
                          (context, index) =>
                              Divider(color: Colors.white24, thickness: 1),
                      itemBuilder: (context, index) {
                        final item = OptionItems.get(context)[index];
                        return ListTile(
                          title: Text(
                            item['title'] as String,
                            style: GoogleFonts.encodeSans(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () async {
                            switch (item['id']) {
                              case '1':
                                final selectedBranch =
                                    Provider.of<BranchProvider>(
                                      context,
                                      listen: false,
                                    ).selectedBranch;
                                final branchId =
                                    selectedBranch?.id?.toString() ?? '';
                                final accessToken =
                                    Provider.of<LoginProvider>(
                                      context,
                                      listen: false,
                                    ).accessToken;
                                serviceProvider.getBranchServices(
                                  branchId,
                                  accessToken!,
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const BranchSettingsPage(),
                                  ),
                                );
                                break;
                              case '2':
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const BranchPage(),
                                  ),
                                );
                                break;
                              case '3':
                                final shouldSignOut = await signOut(context);

                                if (shouldSignOut == true) {
                                  Provider.of<LoginProvider>(
                                    context,
                                    listen: false,
                                  ).clearData();
                                  Provider.of<LoginProvider>(
                                        context,
                                        listen: false,
                                      ).isAuthenticated =
                                      false;
                                  Provider.of<BranchProvider>(
                                    context,
                                    listen: false,
                                  ).clearData();
                                  Provider.of<LanguageProvider>(
                                    context,
                                    listen: false,
                                  ).clearData();

                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const BranchPage(),
                                    ),
                                  );
                                }
                                break;
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.018,
                            horizontal: width * 0.06,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const BranchPage(),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context).back,
                          style: GoogleFonts.encodeSans(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> signOut(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              AppLocalizations.of(context).signOut,
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              AppLocalizations.of(context).signOutConfirmation,
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  AppLocalizations.of(context).cancel,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  AppLocalizations.of(context).signOut,
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
    );
  }
}
