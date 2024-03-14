import 'package:flutter/material.dart';
import '../../../../models/VerseHighlighted.dart';
import '../../../../models/modelBibleVerse.dart';
import '../DailyVerseDetails.dart';
import 'DailyVerseTextGenerator.dart';
import 'package:lifeclass/classes/clsThemes.dart';

class DailyVerseChapterGenerator extends StatelessWidget {
  final BibleVerseSelected data;
  final double fontSize;
  final String colorTheme;
  final Function checkChanged;
  final Function onTapText;
  final List<VerseHighlighted> highlightVerse;
  final List<VerseHighlighted> coloredVerse;

  const DailyVerseChapterGenerator({super.key,required this.data, required this.checkChanged,  required this.fontSize,required this.colorTheme,required this.onTapText, required this.highlightVerse,required this.coloredVerse});

  TextSpan getData(modelBibleVerse _verse) {
    return TextSpan(
        children: [
          TextSpan(text: _verse.chapter.toString() + " "),
          TextSpan(text: _verse.toString(), style: TextStyle(color: Colors.black))
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              children: [
                Center(child: Text(data.long_name + " " + data.chapter,textAlign: TextAlign.center,  style: TextStyle(fontWeight: FontWeight.bold,fontSize: fontSize+2,color: clsThemes.getColor(colorTheme))))
                ,
                SizedBox(height: 20,)
                ,
                Column(
                    children: data.verses.map((e) =>  DailyVerseTextGenerator(data: e,fontSize: fontSize,colorTheme: colorTheme,onTapText: onTapText,long_name: data.long_name,highlightVerses: highlightVerse,coloredVerses: coloredVerse)).toList()
                )
                ,
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Container(
                    width: 170,
                    child: CheckboxListTile(
                        activeColor: clsThemes.getColor(colorTheme),
                        value: data.Checkvalue,
                        title: Text('I Read It',textAlign: TextAlign.right,),
                        onChanged: (value){
                          checkChanged(data.dailyVerseID, data.book_num,int.parse(data.chapter),data.index,value);
                        }),
                  )],
                ),
                SizedBox(height: 30,)
                ,Divider()]),
        ),
      ),
    );
  }
}
