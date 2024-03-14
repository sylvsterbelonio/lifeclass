import 'package:flutter/material.dart';
import 'package:lifeclass/classes/clsThemes.dart';
import 'package:lifeclass/models/modelLesson.dart';
import 'package:lifeclass/models/modelLessonItemList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lifeclass/classes/clsApp.dart';
import '../../../classes/sql/sqlHelper.dart';
import '../../../models/ModelPanelWeek.dart';
import '../../../models/ModelPanelWeekDay.dart';
import '../../../widgets/ads/BannerAds.dart';

class LessonList extends StatefulWidget {
  const LessonList({super.key}); @override State<LessonList> createState() => _LessonListState();
}

class _LessonListState extends State<LessonList> {
  String colorTheme=clsApp.defaultColorThemes;
  late double fontSize=16;
  late List<ModelPanelWeek> panelData = [];
  int adClickCount = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
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
  double getTotalWeeklyCompletionRate(List<modelLesson> _data, int startIndex){
    double total=0;
    total =
        double.parse(_data[startIndex].completionRate.toString()) +
            double.parse(_data[startIndex+1].completionRate.toString()) +
            double.parse(_data[startIndex+2].completionRate.toString()) +
            double.parse(_data[startIndex+3].completionRate.toString()) +
            double.parse(_data[startIndex+4].completionRate.toString()) +
            double.parse(_data[startIndex+5].completionRate.toString()) +
            double.parse(_data[startIndex+6].completionRate.toString());
    return  ((total/700) * 100);
  }
  void loadData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    adClickCount = prefs.getInt('adClickCount') ?? 0;
    List<modelLesson> _data =  await sqlHelper().getAllLessons();
    panelData = [
      ModelPanelWeek(header: 'Week 1: ' + _data[0].week_title,details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: '50'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate: getTotalWeeklyCompletionRate(_data,0),startIndex: 0,dateFinished: '', isExpanded: false, indexPage: 0),
      ModelPanelWeek(header: 'Week 2: ' + _data[7].week_title,details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,7),startIndex: 7,dateFinished: '', isExpanded: false, indexPage: 1),
      ModelPanelWeek(header: 'Week 3: ' + _data[14].week_title,details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,14),startIndex: 14,dateFinished: '', isExpanded: false, indexPage: 2),
      ModelPanelWeek(header: 'Week 4: ' + _data[21].week_title,details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,21),startIndex: 21,dateFinished: '', isExpanded: false, indexPage: 3),
      ModelPanelWeek(header: 'Week 5: ' + _data[28].week_title,details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,28),startIndex: 28,dateFinished: '', isExpanded: false, indexPage: 4),
      ModelPanelWeek(header: 'Week 6: ' + _data[35].week_title,details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,35),startIndex: 35,dateFinished: '', isExpanded: false, indexPage: 5),
      ModelPanelWeek(header: 'Week 7: ' + _data[42].week_title,details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,42),startIndex: 42,dateFinished: '', isExpanded: false, indexPage: 6),
      ModelPanelWeek(header: 'Week 8: ' + _data[49].week_title,details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,49),startIndex: 49,dateFinished: '', isExpanded: false, indexPage: 7),
      ModelPanelWeek(header: 'Week 9: ' + _data[53].week_title,details: [
        ModelPanelWeekDay(title: 'Day 1', verses: ModelPanelWeekDay.get_daily_verse_outline(1,1),status: 'none'),
        ModelPanelWeekDay(title: 'Day 2', verses: ModelPanelWeekDay.get_daily_verse_outline(1,2),status: 'none'),
        ModelPanelWeekDay(title: 'Day 3', verses: ModelPanelWeekDay.get_daily_verse_outline(1,3),status: 'none'),
        ModelPanelWeekDay(title: 'Day 4', verses: ModelPanelWeekDay.get_daily_verse_outline(1,4),status: 'none'),
        ModelPanelWeekDay(title: 'Day 5', verses: ModelPanelWeekDay.get_daily_verse_outline(1,5),status: 'none'),
        ModelPanelWeekDay(title: 'Day 6', verses: ModelPanelWeekDay.get_daily_verse_outline(1,6),status: 'none'),
        ModelPanelWeekDay(title: 'Day 7', verses: ModelPanelWeekDay.get_daily_verse_outline(1,7),status: 'none'),
      ],completionRate:getTotalWeeklyCompletionRate(_data,56),startIndex: 56,dateFinished: '', isExpanded: false, indexPage: 8),
      ];
  }

  Widget getBody(List<modelLesson> data){
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
  Widget createPanelHeader(String title, double completionRate){
    if(completionRate==100){
      return Row(children: [
        Flexible(child: Text(title,overflow: TextOverflow.ellipsis,  style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold, color:clsThemes.getColor(colorTheme)))),
        Padding(padding:EdgeInsets.symmetric(horizontal: 10.0) ,child: Icon(Icons.check_circle_outline, color: Colors.green)),
        Text('Task Completed!',style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic))
      ]);
    }
    else if(completionRate>0){
      return Row(children: [
        Flexible(child: Text(title,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold, color:clsThemes.getColor(colorTheme)))),
        Padding(padding:EdgeInsets.symmetric(horizontal: 10.0) ,child: Icon(Icons.watch_later_rounded, color: Colors.amber)),
        Text("Completion Rate: " + completionRate.toStringAsFixed(2) + " %",style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),
      ]);
    }
    else{
      return Row(children: [
        Flexible(child: Text(title,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold, color:clsThemes.getColor(colorTheme)))),
      ]);
    }
  }
  Widget createPanelContainer(List<modelLesson> data, int startIndex){
    List<modelLessonItemList> subData = [];
    int dayNo=1;
    for(int i=startIndex;i<7+startIndex;i++){
      modelLessonItemList d = modelLessonItemList(dayNo: dayNo, startIndex: startIndex+i, data: data[i]);
      dayNo+=1;
      subData.add(d);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: subData.map((e) => createItemList(e)).toList(),
    );
  }

  Widget createItemList(modelLessonItemList data){
      return Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: InkWell(
          onTap:
              (){openLesson(data.data.lessonID);}
          ,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0)),
                    color: clsThemes.getLightColor(colorTheme),
                  ),
                  child: Center(
                      child:
                      SizedBox(
                        width: 24.0,
                        child: Center(
                          child: Text(data.dayNo.toString(),overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0, color: Colors.white),),
                        ),
                      )),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("DAY " +  data.data.lessonNo.toString(),overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: clsThemes.getColor(colorTheme)),),
                        Text(data.data.lesson_title,overflow: TextOverflow.ellipsis)
                      ],
                    ),
                  ),
                ),
                getIconStatus(data.data.completionRate),
              ],
            ),
          ),
        ),
      );
  }
  Widget getIconStatus(int percentage){
    if(percentage==0)
      return Icon(Icons.keyboard_arrow_right_outlined);
    else if(percentage==100)
      return Padding(padding:EdgeInsets.fromLTRB(0, 0, 10, 0),child: Icon(Icons.check_circle_outline,color: Colors.green));
    else
      return Padding(padding:EdgeInsets.fromLTRB(0, 0, 10, 0),child: Icon(Icons.watch_later_rounded,color: Colors.amber,));
  }
  void openLesson(int lessonID){
    String routeName='';
    if(lessonID.toString().length==1) routeName = '0' + lessonID.toString();
    else routeName = lessonID.toString();
    Navigator.of(context)
        .pushNamed('/lesson_' + routeName, arguments: {
      'lessonID': lessonID.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: FutureBuilder<List<modelLesson>>(
        future: sqlHelper().getAllLessons(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData)
          {
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
