import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lifeclass/classes/sql/sqlHelper.dart';
import 'package:lifeclass/pages/MainPage.dart';
import 'package:lifeclass/pages/SplashScreen.dart';
import 'package:lifeclass/pages/content/Copyright.dart';
import 'package:lifeclass/pages/content/dailyverse/DailyDevotionalDetails.dart';
import 'package:lifeclass/pages/content/dailyverse/DailyVerseDetails.dart';
import 'package:lifeclass/pages/content/lessons/Lesson_01.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  sqlHelper.initDefaultDB;
  sqlHelper.initNivDB;
  sqlHelper.initAsndDB;
  sqlHelper.initRcpvDB;
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true
  );

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MainPage(),
        '/copyright': (context) => const Copyright(),
        '/DailyVerseDetails': (context) => const DailyVerseDetails(),
        '/DailyDevotionalDetails': (context) => const DailyDevotionalDetails(),

        '/lesson_01': (context) => const Lesson_01(),
      }
  ));

}
