import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markazia_ecasher/models/assets.dart';
import 'package:markazia_ecasher/providers/language_provider.dart';
import 'package:markazia_ecasher/screens/branch_page.dart';
import 'package:markazia_ecasher/shared-widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:markazia_ecasher/models/languuage_enum.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<StatefulWidget> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);

    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    return PopScope(
      canPop: true,
      child: Scaffold(
        endDrawer: CustomDrawer(),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(CusotmAssets.logoAssets[6]),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          CusotmAssets.logoAssets[4],
                          width: 120,
                          height: 180,
                        ),
                        const Spacer(),
                        //TODO: add sharedText
                        Text(
                          'Please choose the language',
                          style: GoogleFonts.encodeSans(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'الرجاء اختيار اللغة',
                          style: GoogleFonts.encodeSans(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                await langProvider.setLanguage(
                                  LanguageEnumHelper.getLanguageName(
                                    LanguageEnum.english,
                                  ),
                                );
                              },
                              child: Text(
                                'English',
                                style: GoogleFonts.encodeSans(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                await langProvider.setLanguage(
                                  LanguageEnumHelper.getLanguageName(
                                    LanguageEnum.arabic,
                                  ),
                                );
                              },
                              child: Text(
                                'العربية',
                                style: GoogleFonts.encodeSans(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
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
                                onPressed:
                                    () => {
                                      if (Navigator.of(context).canPop())
                                        {Navigator.of(context).pop()}
                                      else
                                        {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      const BranchPage(),
                                            ),
                                          ),
                                        },
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
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Builder(
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
