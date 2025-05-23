import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markazia_ecasher/screens/login_page.dart';

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
                      'assets/app-logo.png',
                      width: 90,
                      height: 80,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Image.asset(
                'assets/settings.png',
                width: 32,
                height: 32,
                color: Colors.white,
              ),
              title: Text(
                'Kiosk Settings',
                style: GoogleFonts.encodeSans(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                children: [
                  Text(
                    'Check for updates',
                    style: GoogleFonts.encodeSans(
                      fontSize: 14,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 2,
                    ),
                  ),
                  Text(
                    'Version 24.08.1',
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
