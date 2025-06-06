// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markazia_ecasher/core/utils/assets.dart';
import 'package:markazia_ecasher/core/enums/language_enum.dart';
import 'package:markazia_ecasher/presentation/providers/branch_provider.dart';
import 'package:markazia_ecasher/presentation/providers/language_provider.dart';
import 'package:markazia_ecasher/presentation/providers/login_provider.dart';
import 'package:markazia_ecasher/presentation/providers/service_provider.dart';
import 'package:markazia_ecasher/presentation/widgets/custom_list_tile.dart';
import 'package:provider/provider.dart';

class BranchSettingsPage extends StatefulWidget {
  const BranchSettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _BranchSettingsPageState();
}

class _BranchSettingsPageState extends State<BranchSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final selectedLang =
        Provider.of<LanguageProvider>(context, listen: false).currentLocale;
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
                  Expanded(
                    child: Consumer<ServiceProvider>(
                      builder: (context, serviceProvider, child) {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: serviceProvider.services.length,
                          separatorBuilder:
                              (context, index) =>
                                  Divider(color: Colors.white24, thickness: 1),
                          itemBuilder: (context, index) {
                            final logoAssetPath =
                                CusotmAssets.logoAssets[index %
                                    CusotmAssets.logoAssets.length];
                            return ServiceListTile(
                              title:
                                  selectedLang.languageCode ==
                                          LanguageEnumHelper.getLanguageName(
                                            LanguageEnum.english,
                                          )
                                      ? serviceProvider
                                              .services[index]
                                              .serviceNameEn ??
                                          ''
                                      : serviceProvider
                                              .services[index]
                                              .serviceNameAr ??
                                          '',

                              logoAssetPath: logoAssetPath,
                              value:
                                  serviceProvider.toggledIndices[index] ??
                                  false,
                              onChanged: (val) {
                                serviceProvider.toggleService(index, val);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
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
                          Provider.of<ServiceProvider>(
                            context,
                            listen: false,
                          ).clearToggles();
                          context.go('/service');
                        },
                        child: Text(
                          AppLocalizations.of(context).back,
                          style: GoogleFonts.encodeSans(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
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
                        onPressed: () async {
                          final branchId =
                              Provider.of<BranchProvider>(
                                context,
                                listen: false,
                              ).selectedBranch?.id ??
                              0;
                          final accessToken =
                              Provider.of<LoginProvider>(
                                context,
                                listen: false,
                              ).accessToken;
                          try {
                            await Provider.of<ServiceProvider>(
                              context,
                              listen: false,
                            ).updateAllServiceStatuses(branchId, accessToken!);

                            if (!mounted) return;
                            context.go('/service');
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context).updateFailed,
                                  style: GoogleFonts.encodeSans(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context).confirm,
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
}
