import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markazia_ecasher/providers/branch_provider.dart';
import 'package:markazia_ecasher/providers/login_provider.dart';
import 'package:markazia_ecasher/screens/language_page.dart';
import 'package:markazia_ecasher/screens/service_page.dart';
import 'package:markazia_ecasher/shared-widgets/drop_down_menu.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BranchPage extends StatefulWidget {
  const BranchPage({super.key});

  @override
  State<BranchPage> createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;

      final provider = Provider.of<BranchProvider>(context, listen: false);
      await provider.loadBranchesFromPrefs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn =
        Provider.of<LoginProvider>(context, listen: false).isAuthenticated;

    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/app-background.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Consumer<BranchProvider>(
                builder: (context, provider, child) {
                  Widget content;

                  if (provider.isLoading) {
                    content = const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    );
                  } else if (provider.error != null) {
                    content = Column(
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 40),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.errorLoadingBranches,
                          style: GoogleFonts.encodeSans(
                            color: Colors.redAccent,
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  } else {
                    content = Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.chooseBranch,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.encodeSans(
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.07,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        CustomDropDown(
                          initialValue: provider.selectedBranch,
                          onChanged: (branch) {
                            provider.setSelectedBranch(branch);
                          },
                        ),
                      ],
                    );
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.04),
                      Image.asset(
                        'assets/app-logo.png',
                        width: width * 0.35,
                        height: height * 0.15,
                      ),
                      const Spacer(),
                      content,
                      provider.hasChanged
                          ? Padding(
                            padding: EdgeInsets.only(top: height * 0.4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (isLoggedIn)
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
                                          builder:
                                              (context) => const ServicePage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.back,
                                      style: GoogleFonts.encodeSans(
                                        fontSize: width * 0.045,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                SizedBox(width: width * 0.04),
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
                                    if (isLoggedIn) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => ServicePage(),
                                        ),
                                      );
                                    } else {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => LanguagePage(),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.signIn,
                                    style: GoogleFonts.encodeSans(
                                      fontSize: width * 0.045,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : const SizedBox(),
                      const Spacer(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
