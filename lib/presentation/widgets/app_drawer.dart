import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markazia_ecasher/core/utils/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      width: 260,
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Builder(
                        builder: (context) {
                          return IconButton(
                            onPressed:
                                () => Scaffold.of(context).closeEndDrawer(),
                            icon: Icon(Icons.close, color: Colors.white),
                          );
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: Image.asset(
                      CusotmAssets.logoAssets[4],
                      width: 90,
                      height: 80,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Image.asset(
                CusotmAssets.logoAssets[5],
                width: 32,
                height: 32,
                color: Colors.white,
              ),
              title: Text(
                AppLocalizations.of(context).kioskSettings,
                style: GoogleFonts.encodeSans(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                context.go('/login');
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context).checkForUpdate,
                    style: GoogleFonts.encodeSans(
                      fontSize: 14,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 2,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).versionNum,
                    style: GoogleFonts.encodeSans(
                      fontSize: 14,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
