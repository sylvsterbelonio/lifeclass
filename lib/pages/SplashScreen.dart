import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lifeclass/classes/clsApp.dart';
import 'package:lifeclass/classes/clsThemes.dart';

import 'MainPage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String colorTheme = clsApp.defaultColorThemes;

  void loadThemeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultColorThemes;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadThemeData();

    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => MainPage()));
    }
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft
              )
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(children: [
                    Expanded(child: SizedBox(height: 100,)),
                    Container(alignment: Alignment.centerRight,
                        width: 50,
                        height: 100,
                        decoration: BoxDecoration(color: Colors.teal)),
                  ],),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('S T U D E N T   B O O K',textAlign: TextAlign.center,),
                      SizedBox(height:10.0 ,),
                      SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: CircleAvatar(
                          radius: 18,
                          child: ClipOval(
                            child: Image.asset('assets/images/app_logo.png',
                                width: 150,
                                height: 150,
                                fit:BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Text('LIFECLASS',
                          style: TextStyle(fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: clsThemes.getColor(colorTheme),
                              fontStyle: FontStyle.normal),),
                      )
                    ],
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Column(children: [
                    Text('All rights reserved \u00a9 2024',style: TextStyle(fontSize: 13),),
                    Text('CESAR CASTELLANOS D.',style: TextStyle(fontWeight: FontWeight.bold),),
                  ],),
                ),

              ]
          )),
    );
  }

}
