import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/language_provider.dart';

class LanguageSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;

    return Row(
      children: [
        Text(
          'En', // Text when the switch is off
          style: TextStyle(
            color: currentLanguage == 'en' ? Colors.white : Colors.grey,
            fontWeight:
                currentLanguage == 'en' ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Transform.scale(
          scale: 1, // Scale the switch for better visibility
          child: Switch(
            value: currentLanguage == 'fr',
            onChanged: (value) {
              languageProvider.changeLanguage(value ? 'fr' : 'en');
            },
            activeColor: Colors.white,
            inactiveThumbColor: Colors.white,
            activeTrackColor: const Color(0xFF2A3A27), // Active track color
            inactiveTrackColor: const Color(0xFF18291B), // Inactive track color
            splashRadius: 10, // Splash radius for the switch
            thumbColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                return Colors.white; // Thumb color for all states
              },
            ),
            trackOutlineColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                return Colors.white; // No outline color
              },
            ),
          ),
        ),
        Text(
          'Fr', // Text when the switch is on
          style: TextStyle(
            color: currentLanguage == 'fr' ? Colors.white : Colors.grey,
            fontWeight:
                currentLanguage == 'fr' ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
