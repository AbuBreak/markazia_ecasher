import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markazia_ecasher/core/utils/assets.dart';
import 'package:markazia_ecasher/presentation/providers/branch_provider.dart';
import 'package:markazia_ecasher/presentation/providers/language_provider.dart';
import 'package:markazia_ecasher/presentation/providers/login_provider.dart';
import 'package:markazia_ecasher/presentation/widgets/drop_down_menu.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final provider = Provider.of<BranchProvider>(context, listen: false);
      final selectedLang =
          Provider.of<LanguageProvider>(context, listen: false).currentLocale;
      await provider.loadBranches(selectedLang.languageCode);
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
                          AppLocalizations.of(context).errorLoadingBranches,
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
                          AppLocalizations.of(context).chooseBranch,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.04),
                              Image.asset(
                                CusotmAssets.logoAssets[4],
                                width: width * 0.35,
                                height: height * 0.15,
                              ),
                              SizedBox(height: height * 0.04),
                              content,
                            ],
                          ),
                        ),
                      ),
                      if (provider.hasChanged)
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: height * 0.04,
                            top: height * 0.02,
                          ),
                          child: Row(
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
                                    context.go('/service');
                                  },
                                  child: Text(
                                    AppLocalizations.of(context).back,
                                    style: GoogleFonts.encodeSans(
                                      fontSize: width * 0.045,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              Spacer(),
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
                                    context.go('/service');
                                  } else {
                                    context.go('/language');
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context).signIn,
                                  style: GoogleFonts.encodeSans(
                                    fontSize: width * 0.045,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
