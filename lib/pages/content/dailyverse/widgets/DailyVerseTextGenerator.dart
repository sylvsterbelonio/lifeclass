import 'package:flutter/material.dart';
import 'package:lifeclass/classes/clsThemes.dart';
import 'package:styled_text/styled_text.dart';
import '../../../../models/VerseHighlighted.dart';
import '../../../../models/modelBibleVerse.dart';

class DailyVerseTextGenerator extends StatelessWidget {
  final modelBibleVerse data;
  final double fontSize;
  final String colorTheme;
  final Function onTapText;
  final String long_name;
  final List<VerseHighlighted> highlightVerses;
  final List<VerseHighlighted> coloredVerses;
  const DailyVerseTextGenerator(
      {super.key, required this.data, required this.fontSize, required this.colorTheme, required this.onTapText, required this.long_name, required this.highlightVerses,required this.coloredVerses});

  @override
  Widget build(BuildContext context) {

    final Map<String, StyledTextTag> defaultStyledTextTags = {
      'u': StyledTextTag(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize - 5),
      ),
      'f': StyledTextTag(
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: fontSize - 5),
      ),
      't': StyledTextTag(
        style: TextStyle(fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: fontSize),
      ),
      'i': StyledTextTag(
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: fontSize),
      ),
    };
    late bool blnFound = false;
    late String color = '';
    for (int i = 0; i < highlightVerses.length; i++) {
      if (highlightVerses[i].book_num == data.book_number &&
          highlightVerses[i].chapter == data.chapter &&
          highlightVerses[i].verse == data.verse) {
        blnFound = true;
        color = highlightVerses[i].color;
        break;
      }
    }

    if(blnFound){




      late bool blnColorFound = false;
      late String colors = '';
      for (int i = 0; i < coloredVerses.length; i++) {
        if (coloredVerses[i].book_num == data.book_number &&
            coloredVerses[i].chapter == data.chapter &&
            coloredVerses[i].verse == data.verse) {
          blnFound = true;
          colors = coloredVerses[i].color;
          break;
        }
      }

      if(!blnColorFound){
        return InkWell(
          onTap: () {
            onTapText(
                long_name, data.book_number, data.chapter, data.verse, data.text,
                colors,context);
          },
          child: StyledText(text: '<u>' + data.verse.toString() + '</u> ' +
              data.text.toString().replaceAll('<pb/>', ''),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: fontSize,
                height: 2,
                decoration: TextDecoration.underline,
                decorationThickness: 3,
                decorationStyle: TextDecorationStyle.dotted,
                backgroundColor: clsThemes.getShade100Color(colors)),
            tags: defaultStyledTextTags ,
          ),);

      }
      else{
        return InkWell(
          onTap: () {
            onTapText(
                long_name, data.book_number, data.chapter, data.verse, data.text,
                color,context);
          },
          child: StyledText(text: '<u>' + data.verse.toString() + '</u> ' +
              data.text.toString().replaceAll('<pb/>', ''),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: fontSize,
                height: 2,
                decoration: TextDecoration.underline,
                decorationThickness: 3,
                decorationStyle: TextDecorationStyle.dotted,
                backgroundColor: clsThemes.getShade100Color(color)),
            tags: defaultStyledTextTags ,
          ),);
      }
    }
    else{
      late String colors = '';
      for (int i = 0; i < coloredVerses.length; i++) {
        if (coloredVerses[i].book_num == data.book_number &&
            coloredVerses[i].chapter == data.chapter &&
            coloredVerses[i].verse == data.verse) {
          blnFound = true;
          colors = coloredVerses[i].color;
          break;
        }
      }

      return InkWell(
        onTap: () {
          onTapText(
              long_name, data.book_number, data.chapter, data.verse, data.text,
              '',context);
        },
        child: StyledText(text: '<u>' + data.verse.toString() + '</u> ' +
            data.text.toString().replaceAll('<pb/>', ''),
          textAlign: TextAlign.center,

          style: TextStyle(fontSize: fontSize,height: 2,backgroundColor: clsThemes.getShade100Color(colors)),
          tags: defaultStyledTextTags ,
        ),);

    }

  }

}
