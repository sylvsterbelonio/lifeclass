import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeclass/classes/clsApp.dart';
import 'package:lifeclass/classes/clsThemes.dart';
import 'package:lifeclass/pages/content/dailyverse/widgets/DailyVerseChapterGenerator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/VerseHighlighted.dart';
import '../../../models/modelBibleBook.dart';
import '../../../models/modelBibleVerse.dart';
import 'package:lifeclass/classes/sql/sqlHelper.dart';
import '../../../models/modelDailyVerse.dart';
import '../../../widgets/ads/BannerAds.dart';
class BibleVerseSelected{
  late int dailyVerseID;
  late int book_num;
  late String long_name;
  late String chapter;
  late List<modelBibleVerse> verses;
  late int index;
  late bool Checkvalue;
  BibleVerseSelected({required this.dailyVerseID ,required this.book_num,  required this.long_name,required this.chapter,required this.verses, required this.index,required this.Checkvalue});
}
class DailyVerseDetails extends StatefulWidget {
  const DailyVerseDetails({super.key}); @override State<DailyVerseDetails> createState() => _DailyVerseDetailsState();
}
class _DailyVerseDetailsState extends State<DailyVerseDetails> {
  int _currentFontSize = 3;
  bool _fontDecrease = true;
  bool _fontIncrease = true;
  List<double> availableFontSize = [10,12,16,18,20,24,28,32];
  late String colorTheme = clsApp.defaultColorThemes;
  late String appTitle = 'Lesson 1';
  late Function onRefresh;
  late List<VerseHighlighted> selectedVerses = [];
  late List<VerseHighlighted> coloredVerses = [];
  late BuildContext myContext;
  late bool isShowed = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late String dailyVerseID;
  @override
  void initState(){
    reloadTheme();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  void reloadTheme() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentFontSize = prefs.getInt('fontSize') ?? 3;
    if(_currentFontSize==0) _fontDecrease=false;
    else if(_currentFontSize==7) _fontIncrease=false;
    colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultColorThemes;
    reloadMarker();
    setState(() {});
  }
  void reloadMarker() async{
    final routeArg = ModalRoute.of(context)?.settings.arguments as Map<String, String>; // the question mark is needed but I don't know why..!
    dailyVerseID = routeArg["dailyVerseID"].toString();
    modelDailyVerse DevotionalRecord = await sqlHelper.getDailyVerseByID(int.parse(dailyVerseID));
    List<String> sector = DevotionalRecord.marker.split(';');
    coloredVerses = [];
    for(int i=0;i<sector.length;i++){
      List<String> sub_sector = sector[i].split(',');
      if(sub_sector.length>2){
        VerseHighlighted data =
        VerseHighlighted(
            long_name: sub_sector[0],
            book_num: int.parse(sub_sector[1]),
            chapter: int.parse(sub_sector[2]),
            verse: int.parse(sub_sector[3]),
            text: '',
            color: sub_sector[4]);
        coloredVerses.add(data);
      }
    }
  }
  void updateFontSize() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fontSize', _currentFontSize);
  }
  void checkChanged(int dailyVerseID, int book_num, int chapter, int index, bool value) async{
    //print(index.toString() + "->" + book_num.toString() + ' ' + chapter.toString() + ' value-' + value.toString());

    modelDailyVerse BibleReadCheckerList = await sqlHelper.getDailyVerseByID(dailyVerseID);
    late List<String> readBibleChecker = BibleReadCheckerList.status.split(',');

    readBibleChecker[index]=value?'y':'n';
    // print(index.toString() + "!!completion rate:" +BibleReadCheckerList.completion_rate.toString() );

    late String concat ='';
    for(int x=0;x<readBibleChecker.length;x++){
      if(x==0) concat=readBibleChecker[x];
      else concat+=','+readBibleChecker[x];
    }

    //SETTING UP A POINTS DISTRIBUTION
    double devotionalPoints=0;
    if(BibleReadCheckerList.devo_application.trim()!='') devotionalPoints++;
    if(BibleReadCheckerList.devo_commands.trim()!='') devotionalPoints++;
    if(BibleReadCheckerList.devo_promises.trim()!='') devotionalPoints++;
    if(BibleReadCheckerList.devo_rhema.trim()!='') devotionalPoints++;
    if(BibleReadCheckerList.devo_warnings.trim()!='') devotionalPoints++;
    devotionalPoints = (devotionalPoints/5) * 100;
    double readBiblePoints=0;
    readBibleChecker = concat.split(',');
    for(int b=0;b<BibleReadCheckerList.max_verse;b++){
      if(readBibleChecker[b]=='y') readBiblePoints++;
    }

    //print('readBiblePoints->'+readBiblePoints.toString() + "/" + BibleReadCheckerList.max_verse.toString());

    readBiblePoints = (readBiblePoints/BibleReadCheckerList.max_verse) * 100;
    double totalPointsEarned = ((devotionalPoints+readBiblePoints)/200) * 100;

    ///print('totalPoints->'+totalPointsEarned.toString());

    sqlHelper.updateCheckReadStatus(dailyVerseID, concat, totalPointsEarned,BibleReadCheckerList.createdDt.toString());
    // print('length->' + concat);

    setState(() {
    });

  }
  bool highlightVerseChecker(int book_number,int chapter, int verse){
    late bool blnFound = false;
    for(int i=0;i<selectedVerses.length;i++){
      if(selectedVerses[i].book_num==book_number && selectedVerses[i].chapter==chapter && selectedVerses[i].verse==verse){
        selectedVerses.removeAt(i);
        blnFound = true;
        break;
      }
    }
    return blnFound;
  }
  void onTapText(String long_name, int book_number,int chapter, int verse, String text,String color, BuildContext _context) async{
    if(!highlightVerseChecker(book_number,chapter,verse)){
      VerseHighlighted _localData = VerseHighlighted(
        long_name: long_name,
        book_num: book_number,
        chapter: chapter,
        verse: verse,
        text: text,
        color:color,
      );
      selectedVerses.add(_localData);
    }
    if(selectedVerses.length>0)  {
      if(isShowed==false) {showBottomSheet(_context); isShowed=true;}
    }
    else
    {isShowed=false;Navigator.pop(context);};

    setState(() {
    });
  }
  void showBottomSheet(BuildContext context){
    var bottom = Scaffold.of(context).showBottomSheet((context) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(height: 5,width: 50,color: Colors.grey),
                SizedBox(height: 10,),
                Divider(),
                Text("Select Color"),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: (){colorSelected('none');},
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color:Colors.transparent),
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                            width: 40,
                            height: 40,
                            child: Icon(Icons.close,color: Colors.red,),
                            decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(50)))),
                      ),
                    ),
                    InkWell(
                      onTap: (){colorSelected('Red');},
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.red.shade100, width: 1),
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(color: Colors.red.shade100,borderRadius:BorderRadius.all(Radius.circular(50)))),
                      ),
                    ),
                    InkWell(
                      onTap: (){colorSelected('Cyan');},
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.cyan.shade100, width: 1),
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(color: Colors.cyan.shade100,borderRadius:BorderRadius.all(Radius.circular(50)))),
                      ),
                    ),
                    InkWell(
                      onTap: (){colorSelected('Blue');},
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue.shade100, width: 1),
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(color: Colors.blue.shade100,borderRadius:BorderRadius.all(Radius.circular(50)))),
                      ),
                    ),
                    InkWell(
                      onTap: (){colorSelected('Green');},
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.green.shade100, width: 1),
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(color: Colors.green.shade100,borderRadius:BorderRadius.all(Radius.circular(50)))),
                      ),
                    ),
                    InkWell(
                      onTap: (){colorSelected('Amber');},
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.amber.shade100, width: 1),
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(color: Colors.amber.shade100,borderRadius:BorderRadius.all(Radius.circular(50)))),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){copyVerseClipboard();},style: ElevatedButton.styleFrom(backgroundColor: clsThemes.getColor(colorTheme)), child: Text('Copy Text')),
                    ElevatedButton(onPressed: (){sendNotes();},style: ElevatedButton.styleFrom(backgroundColor: clsThemes.getColor(colorTheme)), child: Text('Send To Notes'))
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
    );
    bottom.closed.then((value) => isShowed=false);
  }
  void sendNotes(){
    if(selectedVerses.length>0){
      late String sSelected='';

      for(int i=0;i<selectedVerses.length;i++){
        if(i==0)
          sSelected = selectedVerses[i].long_name + " " +selectedVerses[i].chapter.toString() + ": " + selectedVerses[i].verse.toString() + "\n" + selectedVerses[i].text;
        else
          sSelected += "\n" + selectedVerses[i].long_name + " " +selectedVerses[i].chapter.toString() + ": " + selectedVerses[i].verse.toString() + "\n" + selectedVerses[i].text;
      }

      selectedVerses = [];
      isShowed=false;
      Navigator.pop(context);
      Navigator.of(context)
          .pushNamed('/DailyDevotionalDetails', arguments: {
        'dailyVerseID': dailyVerseID.toString(),
        'content': '',
        'sSelected':sSelected,
      });
    }

  }
  void copyVerseClipboard() async{

    if(selectedVerses.length>0) {
      late String sSelected='';

      for(int i=0;i<selectedVerses.length;i++){
        if(i==0)
          sSelected = selectedVerses[i].long_name + " " +selectedVerses[i].chapter.toString() + ": " + selectedVerses[i].verse.toString() + "\n" + selectedVerses[i].text;
        else
          sSelected += "\n" + selectedVerses[i].long_name + " " +selectedVerses[i].chapter.toString() + ": " + selectedVerses[i].verse.toString() + "\n" + selectedVerses[i].text;
      }

      sSelected = sSelected
          .replaceAll('<i>', '')
          .replaceAll('</i>', '')
          .replaceAll('<t>', '')
          .replaceAll('</t>', '')
          .replaceAll('<pb>', '')
          .replaceAll('<pb/>', '')
          .replaceAll('<f>', '')
          .replaceAll('</f>', '');

      await Clipboard.setData(ClipboardData(text: sSelected));

      var snackBar = SnackBar(
          content: Text('You successfully copied into your clipboard!'));
      selectedVerses = [];
      isShowed = false;

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
      });
    }

  }
  void colorSelected(String color){
    print('color selected->'+color);
    for(int i=0;i<selectedVerses.length;i++){
      selectedVerses[i].color = color;
    }

    for(int x=0;x<selectedVerses.length;x++){
      bool blnFound = false;
      for(int a=0;a<coloredVerses.length;a++){
        if(selectedVerses[x].book_num==coloredVerses[a].book_num &&
            selectedVerses[x].chapter==coloredVerses[a].chapter &&
            selectedVerses[x].verse==coloredVerses[a].verse){
          coloredVerses[a].color = selectedVerses[x].color;
          blnFound=true;
          break;
        }
      }
      if(!blnFound){
        coloredVerses.add(selectedVerses[x]);
      }
    }


    isShowed=false;Navigator.pop(context);
    selectedVerses = [];
    sqlHelper.updateMarker(dailyVerseID, coloredVerses);
    setState(() {
    });

  }

  Future<List<BibleVerseSelected>> getBibleVerse(int dailyVerseID, List<String> my_list_data) async{
    late List<BibleVerseSelected> _data = [];
      print('dailyVerseID->' + dailyVerseID.toString());

    modelDailyVerse BibleReadCheckerList = await sqlHelper.getDailyVerseByID(dailyVerseID);
    late List<String> readBibleChecker = BibleReadCheckerList.status.split(',');

     print('BibleReadCheckerList->' +BibleReadCheckerList.status);

    for(int a=0;a<my_list_data.length;a++){

      List<String> perBible = my_list_data[a].split("-");
        print("aha"+a.toString()+ "->"+perBible[1]);

      modelBibleBook bibleBook = await sqlHelper.getBibleName(int.parse(perBible[0]));
      List<modelBibleVerse> bibleVerses = await sqlHelper.getBibleVerse(int.parse(perBible[0]),int.parse(perBible[1]));

        print("bibleBOok"+a.toString()+"->"+bibleBook.long_name);

      _data.add(BibleVerseSelected(
        dailyVerseID: dailyVerseID,
        book_num: bibleBook.book_number,
        long_name: bibleBook.long_name,
        chapter: perBible[1],
        verses:  bibleVerses,
        index: a,
        Checkvalue: readBibleChecker[a]=='y'?true:false,
      ));
    }

      print('-->mao na ni'+_data.length.toString());

    return _data;
  }
  Future<bool> _onBackPressed() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {

    final routeArg = ModalRoute.of(context)?.settings.arguments as Map<String, String>; // the question mark is needed but I don't know why..!
    dailyVerseID = routeArg["dailyVerseID"].toString();
    final content = routeArg["content"].toString();
    final title = routeArg["title"].toString();
    myContext = context;
    //getBibleVerse( int.parse(dailyVerseID), content.split(","));

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(appBar: AppBar(
        title: Text('Daily Verses: ' + title),
        backgroundColor: clsThemes.getColor(colorTheme),
        actions: [
          IconButton(onPressed: _fontDecrease ?  (){
            setState(() {
              int index = _currentFontSize - 1;
              if (index <= 0) {
                _currentFontSize = 0;
                _fontDecrease = false;
              } else {
                _fontIncrease=true;
                _currentFontSize--;
              }
              // print(_currentFontSize);
              updateFontSize();
            });
          }: null,
              icon: Icon(Icons.text_decrease,
                  color:  _fontDecrease ? Colors.white: Colors.grey[400])),

          IconButton(onPressed: _fontIncrease ? (){
            setState(() {
              int index = _currentFontSize + 1;
              if(index>6){
                _currentFontSize = 7;
                _fontIncrease = false;
              }else {
                _currentFontSize++;
                _fontDecrease=true;
              }
            });
            //  print(_currentFontSize);
            updateFontSize();
          }: null,
              icon: Icon(Icons.text_increase,
                  color: _fontIncrease ? Colors.white: Colors.grey[400])),
        ],
      ),
          body: SafeArea(
            child: Scaffold(
              body: Column(
                children:[
                  Expanded(
                    child: RawScrollbar(
                      child: SingleChildScrollView(
                        child: FutureBuilder(
                            future: getBibleVerse(int.parse(dailyVerseID), content.split(",")),
                            builder: (BuildContext context, AsyncSnapshot<List<BibleVerseSelected>> snapshot){
                              List<BibleVerseSelected>? newData = snapshot.data;
                              if(snapshot.hasData){
                                return Column(
                                  children: newData!.map((e) =>
                                      DailyVerseChapterGenerator(data: e,checkChanged: checkChanged, fontSize: availableFontSize[_currentFontSize],colorTheme: colorTheme,onTapText: onTapText,highlightVerse: selectedVerses,coloredVerse: coloredVerses)
                                  ).toList(),
                                );
                              }else{
                                return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Center(child: CircularProgressIndicator())]);
                              }
                            }),
                      ),
                    ),
                  ),
                  BannerAds(),
                ],
              ),
            ),
          ),
          floatingActionButton: !isShowed? FloatingActionButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context)
                      .pushNamed('/DailyDevotionalDetails', arguments: {
                    'dailyVerseID': dailyVerseID.toString(),
                    'content': content,
                  });
                });
              },
              backgroundColor: clsThemes.getColor(colorTheme),
              child: Icon(Icons.event_note_outlined),
              tooltip: 'Make A Devotional'):null
      ),
    );
  }
}
