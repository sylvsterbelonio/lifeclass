import 'package:flutter/material.dart';
import 'package:lifeclass/classes/clsThemes.dart';
import 'package:lifeclass/pages/content/Dashboard/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/ads/BannerAds.dart';
import 'package:lifeclass/classes/clsApp.dart';
import 'Reports/Reports.dart';
import 'dailyverse/DailyVerseList.dart';
import 'lessons/LessonList.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  PageController _pageController = PageController(initialPage: 0);
  late String colorTheme= clsApp.defaultColorThemes;
  bool bannerAdsLoaded = false;
  Widget bannerAds = BannerAds();
  int adClickCount = 0;
  int currentTab = 0;
  String appMode = 'trial';
  late double percentageLove = 0;
  late double percentageVision = 0;
  late double percentageDailyVerse=0;

  void loadThemeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //calculation();
    setState(() {
      colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultColorThemes;
      appMode = prefs.getString('appMode') ??  clsApp.DEFAULT_APP_MODE;
      adClickCount = prefs.getInt('adClickCount') ??  0;
    });
  }
  void onTapDashboard(int _index){
    currentTab = _index;
    _pageController.animateToPage(_index, duration: Duration(microseconds: 500), curve: Curves.ease);
    //calculation();
    setState(() {
    }
    );
  }

  late List<Widget> screens = [
    Dashboard(colorTheme: colorTheme,onTap: onTapDashboard,lovePercentage: percentageLove,visionPercentage: percentageVision,dailyVersePercentage: percentageDailyVerse),
    LessonList(),
    DailyVerseList(),
    Reports()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:PageView(
          controller: _pageController,
          onPageChanged: (index){
            setState(() {
              //calculation();
              currentTab = index;
            });
          },
          children: [
            Dashboard(colorTheme: colorTheme,onTap: onTapDashboard,lovePercentage: percentageLove,visionPercentage: percentageVision,dailyVersePercentage: percentageDailyVerse),
            LessonList(),
            DailyVerseList(),
            Reports()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentTab,
            onTap: (index){
              _pageController.animateToPage(index, duration: Duration(microseconds: 500), curve: Curves.ease);
              setState(() {
                //calculation();
              });
            },
            selectedItemColor: clsThemes.getColor(colorTheme),
            unselectedItemColor: Colors.grey[300],
            showUnselectedLabels: false,
            showSelectedLabels: true,
            items:[
              BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.dashboard)),
              BottomNavigationBarItem(label: 'Lessons',  icon: Icon(Icons.book)),
              BottomNavigationBarItem(label: 'Daily Verse', icon: Icon(Icons.menu_book)),
              BottomNavigationBarItem(label: 'Reports', icon: Icon(Icons.print)),
            ]
        )
    );
  }
}
