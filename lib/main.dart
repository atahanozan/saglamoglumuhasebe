import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/firebase_options.dart';
import 'package:saglamoglu_muhasebe/pages/home_navigate_page.dart';
import 'package:firebase_core/firebase_core.dart';

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
    return MaterialApp(
      title: 'Sağlamoğlu Muhasebe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffFFC400),
              foregroundColor: const Color(0xff212121)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeNavigatePage(),
    );
  }
}
