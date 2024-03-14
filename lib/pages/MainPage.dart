import 'package:flutter/material.dart';
import 'package:lifeclass/classes/clsApp.dart';
import 'package:lifeclass/classes/clsNetwork.dart';
import 'package:lifeclass/pages/settings/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lifeclass/classes/clsThemes.dart';
import 'content/Content.dart';
import 'package:lifeclass/classes/clsNavBarPanel.dart';

var indexClicked = 0;
var appBarTitle = 'Student Book: Lifeclass';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> pages = [];
  late String colorTheme = clsApp.defaultColorThemes;
  late int currentTabIndex = 0;
  late String bibleVersion = 'NIV';
  late bool isOnline=false;

  @override
  void initState() {
    initTheme();
    pages = [
      Content(),
      Container(child: Settings(colorTheme: colorTheme, bibleVersion: bibleVersion,selectedBibleVersion: loadBibleVersionData, selectedColor: loadThemeData,appMode: 'full',hasNetwork: isOnline,),
      ),
    ];
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void loadThemeData(String selectedColor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('colorThemes', selectedColor);
    colorTheme = selectedColor;
    isOnline = await clsNetwork.hasNetwork();
    pages = [
      Content(),
      Container(child: Settings(colorTheme: colorTheme,bibleVersion: bibleVersion,selectedBibleVersion: loadBibleVersionData,  selectedColor: loadThemeData,appMode:'full',hasNetwork: isOnline,),
      ),
    ];
    setState(() {
    });
  }
  void initTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isOnline = await clsNetwork.hasNetwork();
    setState(() {
      colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultColorThemes;
      bibleVersion = prefs.getString('bibleVersion') ?? clsApp.defaultBibleVersion;
    });
  }
  void loadBibleVersionData(String _bibleVersion) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bibleVersion', _bibleVersion);
    bibleVersion = _bibleVersion;
    isOnline = await clsNetwork.hasNetwork();
    print('->changed'+ bibleVersion);
    pages = [
      Content(),
      Container(child: Settings(colorTheme: colorTheme,bibleVersion: bibleVersion,selectedBibleVersion: loadBibleVersionData,  selectedColor: loadThemeData,appMode:'full',hasNetwork: isOnline,),
      ),
    ];
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback clickDrawer(int index) {
      return () {
        setState(() {
          initTheme();
          indexClicked = index;
          pages = [
            Content(),
            Container(child: Settings(colorTheme: colorTheme,
              bibleVersion: bibleVersion,
              selectedBibleVersion: loadBibleVersionData,
              selectedColor: loadThemeData,
              appMode: 'full',
              hasNetwork: isOnline,),
            )
          ];
          Navigator.pop(context);
          if (index == 0)
            appBarTitle = 'SOL1: School of Leaders';
          else
            appBarTitle = 'Settings';
        });
      };
    }
    Future<bool> _onBackPressed() async{
      return (await showDialog(
          context: context,
          builder: (context)=> AlertDialog(
            title: const Text('Do you really want to exit the app?',style: TextStyle(fontSize: 16.0),),
            actions: <Widget>[
              TextButton(
                  onPressed: ()=>Navigator.pop(context,false),
                  child:  Text('No',style: TextStyle(color: clsThemes.getColor(colorTheme)),)),
              TextButton(
                  onPressed: ()=>Navigator.pop(context,true),
                  child:  Text('Yes',style: TextStyle(color: clsThemes.getColor(colorTheme)),)),
            ],
          )
      )
      );
    }


    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: clsThemes.getColor(colorTheme),
          actions: indexClicked==0 ?  [
            IconButton(icon: Icon(Icons.info), onPressed: () {
              Navigator.pushNamed(context, '/copyright');
            },),
          ] : null,
        ),
        body: pages[indexClicked],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text('LIFECLASS',style: (TextStyle(fontWeight: FontWeight.bold)),),
                accountEmail: const Text('S t u d e n t  B o o k',overflow: TextOverflow.ellipsis, style: TextStyle(fontStyle: FontStyle.italic,fontSize: 12),),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset('assets/images/app_logo.png'),
                  ),
                ),
                decoration: BoxDecoration(
                    color: clsThemes.getColor(colorTheme),
                    image: DecorationImage(
                        image: AssetImage(''),
                        fit: BoxFit.cover)
                ),
              ),
              ListTile(
                  leading: Icon(
                      clsNavBarPanel.drawerItemIcon[0],
                      color: indexClicked ==0 ? clsThemes.getColor(colorTheme) : clsNavBarPanel.drawerItemColor),
                  title: Text(
                    clsNavBarPanel.drawerItemText[0],
                    style: TextStyle(color: indexClicked ==0 ? clsThemes.getColor(colorTheme) : clsNavBarPanel.drawerItemColor),),
                  onTap: clickDrawer(0)
              ),
              ListTile(
                  leading: Icon(
                      clsNavBarPanel.drawerItemIcon[1],
                      color: indexClicked ==1 ? clsThemes.getColor(colorTheme) : clsNavBarPanel.drawerItemColor),
                  title: Text(
                    clsNavBarPanel.drawerItemText[1],
                    style: TextStyle(color: indexClicked ==1 ? clsThemes.getColor(colorTheme) : clsNavBarPanel.drawerItemColor),),
                  onTap: clickDrawer(1)
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                    clsNavBarPanel.drawerItemIcon[2],
                    color: indexClicked ==2 ? clsThemes.getColor(colorTheme) : clsNavBarPanel.drawerItemColor),
                title: Text(
                  clsNavBarPanel.drawerItemText[2],
                  style: TextStyle(color: indexClicked ==2 ? clsThemes.getColor(colorTheme) : clsNavBarPanel.drawerItemColor),),
                onTap: (){
                  setState(() {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context)=> AlertDialog(
                          title: const Text('Do you really want to exit the app?',style: TextStyle(fontSize: 16.0),),
                          actions: <Widget>[
                            TextButton(
                                onPressed: ()=>Navigator.pop(context,false),
                                child:  Text('No',style: TextStyle(color: clsThemes.getColor(colorTheme)),)),
                            TextButton(
                                onPressed: ()=>Navigator.pop(context,true),
                                child:  Text('Yes',style: TextStyle(color: clsThemes.getColor(colorTheme)),)),
                          ],
                        )
                    );
                  });
                },
              )
            ],
          ),
        ),
      ),
    );




  }
}
