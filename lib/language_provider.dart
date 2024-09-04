import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'en'; // Default language

  // Getter for the current language
  String get currentLanguage => _currentLanguage;

  // Setter for the current language
  set currentLanguage(String language) {
    if (_isValidLanguage(language) && _currentLanguage != language) {
      _currentLanguage = language;
      notifyListeners(); // Notify listeners about the change
    }
  }

  // Optional: Method to change language
  void changeLanguage(String language) {
    if (_isValidLanguage(language)) {
      currentLanguage = language;
    }
  }

  // Helper method to validate language
  bool _isValidLanguage(String language) {
    return language == 'en' || language == 'fr';
  }
}
