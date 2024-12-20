import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/book_service.dart';
import 'package:qitaby_web/language_provider.dart';
import 'package:qitaby_web/pages/home_page.dart';
import 'auth_service.dart';
// import 'firebase_options.dart'; // Generated by Firebase CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPMs1t9wkBkgR5Kf6AbpEfRoBlmaRQ_yE",
      authDomain: "qitaby-ad7ac.firebaseapp.com",
      projectId: "qitaby-ad7ac",
      storageBucket: "qitaby-ad7ac.appspot.com",
      messagingSenderId: "166154266280",
      appId: "1:166154266280:web:79a208976dec24bf43449d",
      measurementId: "G-WZMVWZZFGZ",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(
            create: (_) =>
                BookService()), // Use Provider here instead of ChangeNotifierProvider
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: MaterialApp(
        title: 'Qitaby Book Shop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
