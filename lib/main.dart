import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:qurantest/searchpage.dart';
import 'package:qurantest/surahpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  SharedPreferences pref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Forqan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.cyanAccent,
        ),
        home: const HomePage(),
        routes: {
          'page1':(context) => SearchPage()
        },);
  }
}
