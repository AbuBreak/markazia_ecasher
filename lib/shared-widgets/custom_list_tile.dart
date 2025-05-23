import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceListTile extends StatelessWidget {
  final String title;
  final String logoAssetPath;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ServiceListTile({
    super.key,
    required this.title,
    required this.logoAssetPath,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(logoAssetPath, width: 32, height: 32),
      title: Text(
        title,
        style: GoogleFonts.encodeSans(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.green,
      ),
    );
  }
}
