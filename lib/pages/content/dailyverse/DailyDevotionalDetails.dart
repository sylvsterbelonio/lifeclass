import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeclass/classes/clsThemes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lifeclass/classes/clsApp.dart';
import 'package:lifeclass/classes/sql/sqlHelper.dart';

import '../../../models/modelDailyVerse.dart';

class DailyDevotionalDetails extends StatefulWidget {
  const DailyDevotionalDetails({super.key});@override State<DailyDevotionalDetails> createState() => _DailyDevotionalDetailsState();
}

class _DailyDevotionalDetailsState extends State<DailyDevotionalDetails> {
  late String colorTheme = clsApp.defaultColorThemes;
  late TextEditingController txt_rhema = TextEditingController();
  late TextEditingController txt_commands = TextEditingController();
  late TextEditingController txt_warnings = TextEditingController();
  late TextEditingController txt_promises = TextEditingController();
  late TextEditingController txt_application = TextEditingController();
  @override void initState() {
    reloadTheme();
    super.initState();
  }
  void reloadTheme() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultColorThemes;
    reloadRecord();
    setState(() {});
  }
  void reloadRecord() async{
    final routeArg = ModalRoute.of(context)?.settings.arguments as Map<String, String>; // the question mark is needed but I don't know why..!
    final String dailyVerseID = routeArg["dailyVerseID"].toString();
    final String sSelected = routeArg["sSelected"].toString();
    modelDailyVerse DevotionalRecord = await sqlHelper.getDailyVerseByID(int.parse(dailyVerseID));
    txt_rhema.text = DevotionalRecord.devo_rhema.trim();
    txt_commands.text = DevotionalRecord.devo_commands.trim();
    txt_warnings.text = DevotionalRecord.devo_warnings.trim();
    txt_promises.text = DevotionalRecord.devo_promises.trim();
    txt_application.text = DevotionalRecord.devo_application.trim();

    if(sSelected!='null') txt_rhema.text = sSelected
        .replaceAll('<i>', '')
        .replaceAll('</i>', '')
        .replaceAll('<t>', '')
        .replaceAll('</t>', '')
        .replaceAll('<pb>', '')
        .replaceAll('<pb/>', '')
        .replaceAll('<f>', '')
        .replaceAll('</f>', '');

    setState(() {
    });

  }
  void updateRecord() async{

    final routeArg = ModalRoute.of(context)?.settings.arguments as Map<String, String>; // the question mark is needed but I don't know why..!
    final String dailyVerseID = routeArg["dailyVerseID"].toString();


    modelDailyVerse DevotionalRecord = await sqlHelper.getDailyVerseByID(int.parse(dailyVerseID));
    late List<String> readBibleChecker = DevotionalRecord.status.split(',');
    double devotionalPoints=0;
    if(txt_rhema.text.trim()!='') devotionalPoints++;
    if(txt_commands.text.trim()!='') devotionalPoints++;
    if(txt_promises.text.trim()!='') devotionalPoints++;
    if(txt_warnings.text.trim()!='') devotionalPoints++;
    if(txt_application.text.trim()!='') devotionalPoints++;
    devotionalPoints = (devotionalPoints/5) * 100;
    double readBiblePoints=0;
    for(int b=0;b<DevotionalRecord.max_verse;b++){
      if(readBibleChecker[b]=='y') readBiblePoints++;
    }
    readBiblePoints = (readBiblePoints/DevotionalRecord.max_verse) * 100;
    double totalPointsEarned = ((devotionalPoints+readBiblePoints)/200) * 100;

    sqlHelper.updateDevotionalStatus(int.parse(dailyVerseID),txt_rhema.text,txt_commands.text,txt_warnings.text,txt_promises.text,txt_application.text, totalPointsEarned,DevotionalRecord.createdDt);

    setState(() {
      var snackBar = SnackBar(content: Text('You have successfully updated your answers!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        SystemNavigator.pop();
      }
    });
  }
  void clearFields(){
    txt_rhema.text='';
    txt_commands.text='';
    txt_promises.text='';
    txt_warnings.text='';
    txt_application.text='';
    Navigator.pop(context,false);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              showDialog(
                  context: context,
                  builder: (context)=> AlertDialog(
                    title: const Text('Do you want to clear all your answers?',style: TextStyle(fontSize: 16.0),),
                    actions: <Widget>[
                      TextButton(
                          onPressed: ()=>Navigator.pop(context,false),
                          child:  Text('No',style: TextStyle(color: clsThemes.getColor(colorTheme)),)),
                      TextButton(
                          onPressed: ()=> clearFields(),
                          child:  Text('Yes',style: TextStyle(color: clsThemes.getColor(colorTheme)),)),
                    ],
                  )
              );

            }, icon: Icon(Icons.delete),tooltip: 'Clear All Fields',)
          ],
          title:  Text('Daily Devotional Notes'),
          backgroundColor: clsThemes.getColor(colorTheme),
        ),
        body: SingleChildScrollView(
          child: Padding(padding:EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('I. RHEMA',textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:clsThemes.getColor(colorTheme))),
                SizedBox(height: 10.0,),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  controller: txt_rhema,
                  cursorColor: clsThemes.getColor(colorTheme),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: null,
                    hintText: 'Write your most impacted verse in the bible.',
                  ),
                  style: TextStyle(fontSize: 16),),
                Divider(),
                Text('II. COMMANDS',textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:clsThemes.getColor(colorTheme))),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  controller: txt_commands,
                  cursorColor: clsThemes.getColor(colorTheme),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: null,
                    hintText: 'What commands did you hear from God?',
                  ),
                  style: TextStyle(fontSize: 16),),
                Divider(),
                Text('III. WARNINGS',textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:clsThemes.getColor(colorTheme))),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  controller: txt_warnings,
                  cursorColor: clsThemes.getColor(colorTheme),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: null,
                    hintText: 'Did God warns you from the verses you have selected? If yes, what is it all about?',
                  ),
                  style: TextStyle(fontSize: 16),),
                Divider(),
                Text('IV. PROMISES',textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:clsThemes.getColor(colorTheme))),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  controller: txt_promises,
                  cursorColor: clsThemes.getColor(colorTheme),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: null,
                    hintText: 'What promises from God will give you?',
                  ),
                  style: TextStyle(fontSize: 16),),
                Divider(),
                Text('V. APPLICATION',textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:clsThemes.getColor(colorTheme))),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  controller: txt_application,
                  cursorColor: clsThemes.getColor(colorTheme),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: null,
                    hintText: 'How can you apply in your daily life?',
                  ),
                  style: TextStyle(fontSize: 16),),
                Divider(),
                SizedBox(height: 100,)
              ],),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                updateRecord();
              });
            },
            child: Icon(Icons.save),
            backgroundColor: clsThemes.getColor(colorTheme),
            tooltip: 'Save your Devotional Notes')
    ));
  }
}
