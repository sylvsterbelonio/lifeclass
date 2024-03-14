import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lifeclass/classes/clsThemes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../classes/clsSetting.dart';
import '../../classes/clsThemeColor.dart';
import '../../widgets/BibleVersionSwitcher.dart';
import '../../widgets/ColorThemeSwitcher.dart';
import '../../widgets/SettingsCardTemplate.dart';
import 'package:lifeclass/classes/sql/sqlHelper.dart';


class Settings extends StatelessWidget {
  final String colorTheme;
  final String bibleVersion;
  final Function selectedColor;
  final Function selectedBibleVersion;
  final String appMode;
  final bool hasNetwork;
  const Settings({super.key,required this.colorTheme,required this.bibleVersion,required this.selectedColor,required this.selectedBibleVersion, required this.appMode,required this.hasNetwork});

  @override
  Widget build(BuildContext context) {
    List<String> options = ['Gray','Black', 'Green', 'Blue', 'Orange', 'Pink', 'Red', 'Purple', 'Teal','Amber','Indigo','Cyan','Lime'];
    List<clsSetting> clsSettings = [];
    Timer? countdownTimer;
    late String AutogenID = '-';
    late bool readyBackup = true;

    Future<void> _launchUrl(String url) async {
      final Uri _url = Uri.parse(url);
      if (!await launchUrl(_url,mode: LaunchMode.inAppWebView)) {
        throw Exception('Could not launch $_url');
      }
    }

    if(appMode=='trial'){
      clsSettings = [
        clsSetting(icon: 'language',title: 'Language', rightBox: 'Cebuano',color: colorTheme),
        clsSetting(icon: 'theme',title: 'Theme:', rightBox: 'yes',color: colorTheme),
        clsSetting(icon: 'locker',title: 'Privacy Policy', rightBox: '',color: colorTheme),
        clsSetting(icon: 'exclamation',title: 'Terms & Condition', rightBox: '',color: colorTheme),
        //clsSetting(icon: 'star',title: 'Rate Us', rightBox: '',color: colorTheme),
        clsSetting(icon: 'nativeAds',title: 'Buy', rightBox: '',color: colorTheme),
      ];
    }else{
      clsSettings = [
        clsSetting(icon: 'language',title: 'Language', rightBox: 'English',color: colorTheme),
        clsSetting(icon: 'bibleVersion',title: 'Bible Version', rightBox: bibleVersion,color: colorTheme),
        clsSetting(icon: 'theme',title: 'Theme:', rightBox: 'yes',color: colorTheme),
        clsSetting(icon: 'reset',title: 'Reset Data', rightBox: '',color: colorTheme),
        clsSetting(icon: 'import',title: 'Import Data', rightBox: '',color: colorTheme),
        clsSetting(icon: 'backup',title: 'Backup Data', rightBox: '',color: colorTheme),
        clsSetting(icon: 'locker',title: 'Privacy Policy', rightBox: '',color: colorTheme),
        clsSetting(icon: 'exclamation',title: 'Terms & Condition', rightBox: '',color: colorTheme),
        //clsSetting(icon: 'star',title: 'Rate Us', rightBox: '',color: colorTheme),
        clsSetting(icon: 'nativeAds',title: 'Buy', rightBox: '',color: colorTheme),
      ];
    }

    void reloadThemeColorSelected(String value) async{
      Navigator.pop(context);
      clsSettings = [
        clsSetting(icon: 'theme',title: 'Theme:', rightBox: 'yes',color: colorTheme),
        clsSetting(icon: 'locker',title: 'Privacy Policy', rightBox: '',color: colorTheme),
        clsSetting(icon: 'exclamation',title: 'Terms & Condition', rightBox: '',color: colorTheme),
        //clsSetting(icon: 'star',title: 'Rate Us', rightBox: '',color: colorTheme),
      ];
      selectedColor(value);
    }
    void reloadBibleVersionSelected(String value) async{
      Navigator.pop(context);
      clsSettings = [
        clsSetting(icon: 'language',title: 'Language', rightBox: 'English',color: colorTheme),
        clsSetting(icon: 'bibleVersion',title: 'Bible Version', rightBox: value,color: colorTheme),
        clsSetting(icon: 'theme',title: 'Theme:', rightBox: 'yes',color: colorTheme),
        clsSetting(icon: 'reset',title: 'Reset Data', rightBox: '',color: colorTheme),
        clsSetting(icon: 'import',title: 'Import Data', rightBox: '',color: colorTheme),
        clsSetting(icon: 'backup',title: 'Backup Data', rightBox: '',color: colorTheme),
        clsSetting(icon: 'locker',title: 'Privacy Policy', rightBox: '',color: colorTheme),
        clsSetting(icon: 'exclamation',title: 'Terms & Condition', rightBox: '',color: colorTheme),
        //clsSetting(icon: 'star',title: 'Rate Us', rightBox: '',color: colorTheme),
        clsSetting(icon: 'nativeAds',title: 'Buy', rightBox: '',color: colorTheme),
      ];
      print('aha->');
      selectedBibleVersion(value);
    }

    List<clsThemeColor> cls_themeColor = [
      clsThemeColor(title: options[0], groupValue: colorTheme),
      clsThemeColor(title: options[1], groupValue: colorTheme),
      clsThemeColor(title: options[2], groupValue: colorTheme),
      clsThemeColor(title: options[3], groupValue: colorTheme),
      clsThemeColor(title: options[4], groupValue: colorTheme),
      clsThemeColor(title: options[5], groupValue: colorTheme),
      clsThemeColor(title: options[6], groupValue: colorTheme),
      clsThemeColor(title: options[7], groupValue: colorTheme),
      clsThemeColor(title: options[8], groupValue: colorTheme),
      clsThemeColor(title: options[9], groupValue: colorTheme),
      clsThemeColor(title: options[10], groupValue: colorTheme),
      clsThemeColor(title: options[11], groupValue: colorTheme),
      clsThemeColor(title: options[12], groupValue: colorTheme),
    ];
    List<clsThemeColor> cls_bible_version = [
      clsThemeColor(title: 'NIV', groupValue: bibleVersion),
      clsThemeColor(title: 'ASND', groupValue: bibleVersion),
      clsThemeColor(title: 'RCPV', groupValue: bibleVersion),
    ];


    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: clsSettings.map((e) =>
              SettingsCardTemplate(
                cls_setting: e,
                openClick: () async{
                  print(e.title);
                  if(e.title=='Theme:' && readyBackup){
                    //load bottom sheet dialog
                    showModalBottomSheet(context: context, builder: (context){
                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                              children: cls_themeColor.map((ef) =>
                                  ColorThemeSwitcher(cls_themeColor: ef, changeClick: reloadThemeColorSelected)).toList()
                          ),
                        ),
                      );
                    });
                  }
                  else if(e.title=='Bible Version' && readyBackup){
                    showModalBottomSheet(context: context, builder: (context){
                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                              children: cls_bible_version.map((ef) =>
                                  BibleVersionSwitcher(cls_themeColor: ef, changeClick: reloadBibleVersionSelected)).toList()
                          ),
                        ),
                      );
                    });
                  }
                  else if(e.title=='Reset Data' && readyBackup){
                    await showDialog(
                        context: context,
                        builder: (context)=> AlertDialog(
                          title: const Text('Are you sure you want to reset your record? All of your record will be deleted permanently and reset back to default.',style: TextStyle(fontSize: 16.0),),
                          actions: <Widget>[
                            TextButton(
                                onPressed: ()=>Navigator.pop(context,false),
                                child:  Text('No',style: TextStyle(color: clsThemes.getColor(colorTheme)),)),
                            TextButton(
                                onPressed: () async{
                                  Navigator.pop(context,false);
                                  //sqlHelper.resetLesson();
                                  sqlHelper.resetDailyVerse();
                                  var snackBar = SnackBar(content: Text('You have successfully reset the data!'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                                child:  Text('Yes',style: TextStyle(color: clsThemes.getColor(colorTheme)),)),
                          ],
                        )
                    );
                  }
                  else if(e.title=='Import Data' && readyBackup){
                    if(hasNetwork){
                      //showBottomDialogForImportData(context,'');
                    }else{
                      var snackBar = SnackBar(content: Text('Error! You need an internet connection.'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                  else if(e.title=='Backup Data' && readyBackup){
                    if(hasNetwork){
                      var snackBar = SnackBar(content: Text('Creating a back up data, do not close the app while processing.'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      readyBackup=false;

                      //AutogenID = await backupData();

                      countdownTimer =
                          Timer.periodic(Duration(seconds: 3), (_) async {
                            Navigator.of(context).pop();
                            countdownTimer?.cancel();
                            readyBackup=true;
                            //showBottomDialogForBackupData(context,AutogenID);
                          });

                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Padding(
                              padding: EdgeInsets.all(30.0),
                              child:
                              new Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  new CircularProgressIndicator(),
                                  Expanded(child: Padding(padding:EdgeInsets.symmetric(horizontal: 50.0),child: new Text("Loading...",textAlign: TextAlign.center))),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                    }else{
                      var snackBar = SnackBar(content: Text('Error! You need an internet connection.'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                  else if(e.title=='Privacy Policy' && readyBackup){
                    _launchUrl('https://doc-hosting.flycricket.io/sol1-school-of-leaders-1-privacy-policy/ec4cad88-7572-4518-9ee7-4bafd7012f10/privacy');
                  }
                  else if(e.title=='Terms & Condition' && readyBackup){
                    _launchUrl('https://doc-hosting.flycricket.io/sol1-school-of-leaders-1-terms-conditions/6a02c337-ef6e-4553-ba99-8e95a9bb0111/terms');
                  }
                }, buyAction: () {  }, restoreAction: () {  },
              )).toList(),
        ),
      ),
    );;
  }
}
