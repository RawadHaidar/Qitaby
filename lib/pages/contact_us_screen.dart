import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/customized_widgets/contact_us_section.dart';
import 'package:qitaby_web/customized_widgets/pages_appbar.dart';
import 'package:qitaby_web/language_provider.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    return Scaffold(
        appBar: PagesAppbar(theme: AppBarThemeType.light),
        body: ContactUsSection());
  }
}
