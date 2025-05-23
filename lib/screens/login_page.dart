// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markazia_ecasher/providers/login_provider.dart';
import 'package:markazia_ecasher/screens/language_page.dart';
import 'package:markazia_ecasher/screens/service_page.dart';
import 'package:markazia_ecasher/shared-widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    return PopScope(
      canPop: true,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/app-background.gif'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/app-logo.png',
                          width: width * 0.3,
                          height: height * 0.2,
                        ),
                        SizedBox(height: height * 0.015),
                        Padding(
                          padding: EdgeInsets.all(width * 0.04),
                          child: CustomTextField(
                            title: AppLocalizations.of(context)!.empNum,
                            hintText: AppLocalizations.of(context)!.enterEmpNum,
                            errorText: loginProvider.employeeError,
                            onChanged: loginProvider.setEmployeeNumber,
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        Padding(
                          padding: EdgeInsets.all(width * 0.04),
                          child: CustomTextField(
                            title: AppLocalizations.of(context)!.password,
                            hintText: AppLocalizations.of(context)!.enterPassword,
                            obscureText: true,
                            errorText: loginProvider.passwordError,
                            onChanged: loginProvider.setPassword,
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                      const LanguagePage(),
                                            ),
                                          ),
                                          loginProvider.clearData(),
                                        },
                                    },
                                child: Text(
                                  AppLocalizations.of(context)!.back,
                                  style: GoogleFonts.encodeSans(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.05),

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
                                  if (!loginProvider.validate()) {
                                    return;
                                  }
                                  await loginProvider.userLogin(
                                    loginProvider.employeeNum,
                                    loginProvider.employeePass,
                                  );

                                  if (!mounted) return;
                                  if (loginProvider.isAuthenticated) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const ServicePage(),
                                      ),
                                    );
                                    loginProvider.clearData();
                                  } else {
                                    loginProvider.clearData();
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            backgroundColor: Colors.black87,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            title:  Text(
                                              AppLocalizations.of(context)!.errorLogin,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: Text(
                                              loginProvider.errorTitle ??
                                                  AppLocalizations.of(context)!.generalError,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed:
                                                    () =>
                                                        Navigator.of(
                                                          context,
                                                        ).pop(),
                                                child:  Text(
                                                  AppLocalizations.of(context)!.ok,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    );
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.confirm,
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
                    ),
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
