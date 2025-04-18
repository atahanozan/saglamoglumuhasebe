import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:saglamoglu_muhasebe/pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const Color customBlack = Color(0xff212121);
    const Color customWhite = Color(0xffFAFAFA);
    return MaterialApp(
      title: 'Sağlamoğlu Muhasebe',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: const Color(0xffFFC400),
                foregroundColor: const Color(0xff212121)),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                foregroundColor: const Color(0xff212121)),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: customBlack,
            foregroundColor: customWhite,
          )),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
