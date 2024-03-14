import 'package:flutter/material.dart';
import 'package:lifeclass/classes/clsApp.dart';
import 'package:lifeclass/classes/clsThemes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../classes/sql/sqlHelper.dart';
import '../../../models/ModelPanelWeek.dart';
import '../../../models/ModelPanelWeekDay.dart';
import '../../../models/modelDailyVerse.dart';
import '../../../widgets/ads/AppOpenAds.dart';
import '../../../widgets/ads/BannerAds.dart';

class DailyVerseList extends StatefulWidget {
  const DailyVerseList({super.key}); @override State<DailyVerseList> createState() => _DailyVerseListState();
}

class _DailyVerseListState extends State<DailyVerseList> {
  String colorTheme=clsApp.defaultColorThemes;
  late double fontSize=16;
  late List<ModelPanelWeek> panelData = [];
  int adClickCount = 0;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    loadData();
    initTheme();
    super.initState();
  }
  void updateAdClickCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('adClickCount', adClickCount);
  }
  void initTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultColorThemes;
      fontSize = prefs.getDouble('fontSize') ?? 16;
    });
  }
  double getTotalWeeklyCompletionRate(List<modelDailyVerse> _data, int startIndex){
    double total=0;
    total =
        double.parse(_data[startIndex].completion_rate.toString()) +
            double.parse(_data[startIndex+1].completion_rate.toString()) +
            double.parse(_data[startIndex+2].completion_rate.toString()) +
            double.parse(_data[startIndex+3].completion_rate.toString()) +
            double.parse(_data[startIndex+4].completion_rate.toString()) +
            double.parse(_data[startIndex+5].completion_rate.toString()) +
            double.parse(_data[startIndex+6].completion_rate.toString());
    return  ((total/700) * 100);
  }
  void loadData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    adClickCount = prefs.getInt('adClickCount') ?? 0;
    List<modelDailyVerse> _data =  await sqlHelper().getAllDailyVerse();
    panelData = [
      ModelPanelWeek(header: 'Week 1:',details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate: getTotalWeeklyCompletionRate(_data,0),startIndex: 0,dateFinished: '', isExpanded: false, indexPage: 0),
      ModelPanelWeek(header: 'Week 2:',details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,7),startIndex: 7,dateFinished: '', isExpanded: false, indexPage: 1),
      ModelPanelWeek(header: 'Week 3:',details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,14),startIndex: 14,dateFinished: '', isExpanded: false, indexPage: 2),
      ModelPanelWeek(header: 'Week 4:',details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,21),startIndex: 21,dateFinished: '', isExpanded: false, indexPage: 3),
      ModelPanelWeek(header: 'Week 5:',details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,28),startIndex: 28,dateFinished: '', isExpanded: false, indexPage: 4),
      ModelPanelWeek(header: 'Week 6:',details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,35),startIndex: 35,dateFinished: '', isExpanded: false, indexPage: 5),
      ModelPanelWeek(header: 'Week 7:',details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,42),startIndex: 42,dateFinished: '', isExpanded: false, indexPage: 6),
      ModelPanelWeek(header: 'Week 8:',details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,49),startIndex: 49,dateFinished: '', isExpanded: false, indexPage: 7),
      ModelPanelWeek(header: 'Week 9:',details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,56),startIndex: 56,dateFinished: '', isExpanded: false, indexPage: 8),
      ModelPanelWeek(header: 'Week 10:',details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,63),startIndex: 63,dateFinished: '', isExpanded: false, indexPage: 9),
    ];
  }
  Future<void> loadDataWIthOutRefresh(List<modelDailyVerse> _data) async {
    if(_data.length>0){
      panelData[0].completionRate = getTotalWeeklyCompletionRate(_data,0);
      panelData[1].completionRate = getTotalWeeklyCompletionRate(_data,7);
      panelData[2].completionRate = getTotalWeeklyCompletionRate(_data,14);
      panelData[3].completionRate = getTotalWeeklyCompletionRate(_data,21);
      panelData[4].completionRate = getTotalWeeklyCompletionRate(_data,28);
      panelData[5].completionRate = getTotalWeeklyCompletionRate(_data,35);
      panelData[6].completionRate = getTotalWeeklyCompletionRate(_data,42);
      panelData[7].completionRate = getTotalWeeklyCompletionRate(_data,49);
      panelData[8].completionRate = getTotalWeeklyCompletionRate(_data,56);
      panelData[9].completionRate = getTotalWeeklyCompletionRate(_data,63);
    }
  }

  Widget getBody(List<modelDailyVerse> data){
    return Column(
      children: [Expanded(
        child: RawScrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
              child: ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded){
                  setState(() {
                    panelData[index].isExpanded = !isExpanded;
                  });
                },
                children: panelData.map<ExpansionPanel>((ModelPanelWeek panelItem){
                  return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded){
                      return InkWell(
                        onTap: (){
                          setState(() {
                            panelItem.isExpanded = !isExpanded;
                          });
                        },
                        child: ListTile(
                          title: createPanelHeader(panelItem.header, panelItem.completionRate),
                        ),
                      );
                    },
                    body: createPanelContainer(data,panelItem.startIndex),
                    isExpanded: panelItem.isExpanded,
                  );
                }).toList(),
              )
          ),
        ),
      ),
        BannerAds()],
    );
  }

  void openDailyVerse(int dailyVerseID, String content, String title){
    adClickCount++;
    if(adClickCount>7){
      adClickCount=0;
      AppOpenAds.loadAd();
    }
    updateAdClickCount();
    print('adCount=' + adClickCount.toString());

    print('content->'+ content);
    Navigator.of(context)
        .pushNamed('/DailyVerseDetails', arguments: {
      'dailyVerseID': dailyVerseID.toString(),
      'content': content,
      'title' : title
    });
  }
  Widget createPanelHeader(String title, double completionRate){
    if(completionRate==100){
      return Row(children: [
        Text(title,style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold, color:clsThemes.getColor(colorTheme))),
        Padding(padding:EdgeInsets.symmetric(horizontal: 10.0) ,child: Icon(Icons.check_circle_outline, color: Colors.green)),
        Text('Task Completed!',style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic))
      ]);
    }
    else if(completionRate>0){
      return Row(children: [
        Text(title,style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold, color:clsThemes.getColor(colorTheme))),
        Padding(padding:EdgeInsets.symmetric(horizontal: 10.0) ,child: Icon(Icons.watch_later_rounded, color: Colors.amber)),
        Text("Completion Rate: " + completionRate.toStringAsFixed(2) + " %",style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),
      ]);
    }
    else{
      return Row(children: [
        Text(title,style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold, color:clsThemes.getColor(colorTheme))),
      ]);
    }
  }
  Widget createPanelContainer(List<modelDailyVerse> data, int startIndex){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getThreeCards(data,startIndex),
        getThreeCards(data,startIndex+3),
        getOneCard(data,startIndex+6)
      ],
    );
  }
  Widget getThreeCards(List<modelDailyVerse> _data, int startIndex){
    print('completion rate->'+ _data[startIndex].completion_rate.toString());

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onTap: (){
                  openDailyVerse(_data[startIndex].dailyVerseID,_data[startIndex].content, "Week " + _data[startIndex].weekNo.toString() + " (Day " + _data[startIndex].dayNo.toString() + ")" );
                },
                child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),topRight: Radius.circular(20.0),bottomRight: Radius.circular(20.0),),),
                    child:Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('DAY ' + _data[startIndex].dayNo.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: clsThemes.getColor(colorTheme))),
                          Container(child: _data[startIndex].completion_rate==0 ?
                          Icon(Icons.question_mark_sharp, color: Colors.grey)
                              :
                          Container(child:
                          _data[startIndex].completion_rate==100 ?
                          Icon(Icons.task_alt_outlined, color: Colors.green)
                              :
                          Icon(Icons.watch_later_rounded, color: Colors.amber)),
                          ),
                          Text(_data[startIndex].content_description.replaceAll('\\n', '\n'),textAlign: TextAlign.center),
                          Divider(),
                          Padding(padding: EdgeInsets.all(10.0),child: Text(_data[startIndex].updateDt.trim()!=''?'Date Recorded\n' + _data[startIndex].updateDt.trim().substring(0,10) :'---',textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic,fontSize: fontSize-5,fontWeight: FontWeight.bold,color: Colors.grey),))
                        ],
                      ),
                    )
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onTap: (){
                  openDailyVerse(_data[startIndex+1].dailyVerseID,_data[startIndex+1].content , "Week " + _data[startIndex+1].weekNo.toString() + " (Day " + _data[startIndex+1].dayNo.toString() + ")" );
                },
                child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),topRight: Radius.circular(20.0),bottomRight: Radius.circular(20.0),),),
                    child:Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('DAY ' + _data[startIndex+1].dayNo.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: clsThemes.getColor(colorTheme))),
                          //Text('100.00%'),
                          //Icon(Icons.watch_later_rounded, color: Colors.amber,),
                          Container(child: _data[startIndex+1].completion_rate==0 ?
                          Icon(Icons.question_mark_sharp, color: Colors.grey)
                              :
                          Container(child:
                          _data[startIndex+1].completion_rate==100 ?
                          Icon(Icons.task_alt_outlined, color: Colors.green)
                              :
                          Icon(Icons.watch_later_rounded, color: Colors.amber)),
                          ),

                          Text(_data[startIndex+1].content_description.replaceAll('\\n', '\n'),textAlign: TextAlign.center),
                          Divider(),
                          Padding(padding: EdgeInsets.all(10.0),child: Text(_data[startIndex+1].updateDt.trim()!=''?'Date Recorded\n' + _data[startIndex+1].updateDt.trim().substring(0,10) :'---',textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic,fontSize: fontSize-5,fontWeight: FontWeight.bold,color: Colors.grey),))
                        ],
                      ),
                    )
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onTap: (){
                  openDailyVerse(_data[startIndex+2].dailyVerseID,_data[startIndex+2].content, "Week " + _data[startIndex+2].weekNo.toString() + " (Day " + _data[startIndex+2].dayNo.toString() + ")" );
                },
                child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),topRight: Radius.circular(20.0),bottomRight: Radius.circular(20.0),),),
                    child:Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('DAY ' + _data[startIndex+2].dayNo.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: clsThemes.getColor(colorTheme))),
                          Container(child: _data[startIndex+2].completion_rate==0 ?
                          Icon(Icons.question_mark_sharp, color: Colors.grey)
                              :
                          Container(child:
                          _data[startIndex+2].completion_rate==100 ?
                          Icon(Icons.task_alt_outlined, color: Colors.green)
                              :
                          Icon(Icons.watch_later_rounded, color: Colors.amber)),
                          ),
                          Text(_data[startIndex+2].content_description.replaceAll('\\n', '\n'),textAlign: TextAlign.center),
                          Divider(),
                          Padding(padding: EdgeInsets.all(10.0),child: Text(_data[startIndex+2].updateDt.trim()!=''?'Date Recorded\n' + _data[startIndex+2].updateDt.trim().substring(0,10) :'---',textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic,fontSize: fontSize-5,fontWeight: FontWeight.bold,color: Colors.grey),))
                        ],
                      ),
                    )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget getOneCard(List<modelDailyVerse> _data, int startIndex){

    print('-->day7---' + _data[startIndex].completion_rate.toString());

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(height: 100,),
          ),
          Expanded(
              flex: 1,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onTap: (){
                    openDailyVerse(_data[startIndex].dailyVerseID,_data[startIndex].content, "Week " + _data[startIndex].weekNo.toString() + " (Day " + _data[startIndex].dayNo.toString() + ")" );
                  },
                  child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),topRight: Radius.circular(20.0),bottomRight: Radius.circular(20.0),),),
                      child:Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('DAY ' + _data[startIndex].dayNo.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: clsThemes.getColor(colorTheme))),
                            //Text('100.00%'),
                            //Icon(Icons.watch_later_rounded, color: Colors.amber,),
                            Container(child: _data[startIndex].completion_rate==0 ?
                            Icon(Icons.question_mark_sharp, color: Colors.grey)
                                :
                            Container(child:
                            _data[startIndex].completion_rate==100 ?
                            Icon(Icons.task_alt_outlined, color: Colors.green)
                                :
                            Icon(Icons.watch_later_rounded, color: Colors.amber)),
                            ),
                            Text(_data[startIndex].content_description.replaceAll('\\n', '\n'),textAlign: TextAlign.center),
                            Divider(),
                            Padding(padding: EdgeInsets.all(10.0),child: Text(_data[startIndex].updateDt.trim()!=''?'Date Recorded\n' + _data[startIndex].updateDt.trim().substring(0,10) :'---',textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic,fontSize: fontSize-5,fontWeight: FontWeight.bold,color: Colors.grey),))
                          ],
                        ),
                      )
                  ),
                ),
              )
          ),
          Expanded(
              flex: 1,
              child: SizedBox(height: 100)
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: FutureBuilder<List<modelDailyVerse>>(
        future: sqlHelper().getAllDailyVerse(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData)
          {
            loadDataWIthOutRefresh(snapshot.data);
            return getBody(snapshot.data!);
          }
          else
          {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ));
  }
}
