import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class clsThemes{

  static Future<String> loadThemeColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = await prefs.getString('colorThemes') ?? 'Blue';
    return data;
  }

  static Color getColor(String colorType){
    Color cColor = Colors.red;
    switch(colorType){
      case 'Indigo':
        cColor = Colors.indigo;
        break;
      case 'Gray':
        cColor = Colors.grey;
        break;
      case 'Black':
        cColor = Colors.black;
        break;
      case 'Green':
        cColor = Colors.green;
        break;
      case 'Blue':
        cColor = Colors.blue;
        break;
      case 'Orange':
        cColor = Colors.orange;
        break;
      case 'Pink':
        cColor = Colors.pink;
        break;
      case 'Red':
        cColor = Colors.red;
        break;
      case 'Purple':
        cColor = Colors.purple;
        break;
      case 'Teal':
        cColor = Colors.teal;
        break;
      case 'Amber':
        cColor = Colors.amber;
        break;
      case 'Cyan':
        cColor = Colors.cyanAccent;
        break;
      case 'Lime':
        cColor = Colors.lime;
        break;
    }
    return cColor;
  }

  static Color getShadeColor(String colorType){
    Color cColor = Colors.red;
    switch(colorType){
      case 'Indigo':
        cColor = Colors.indigo.shade100;
        break;
      case 'Gray':
        cColor = Colors.grey.shade100;
        break;
      case 'Black':
        cColor = Colors.grey;
        break;
      case 'Green':
        cColor = Colors.green.shade100;
        break;
      case 'Blue':
        cColor = Colors.blue.shade100;
        break;
      case 'Orange':
        cColor = Colors.orange.shade100;
        break;
      case 'Pink':
        cColor = Colors.pink.shade100;
        break;
      case 'Red':
        cColor = Colors.red.shade100;
        break;
      case 'Purple':
        cColor = Colors.purple.shade100;
        break;
      case 'Teal':
        cColor = Colors.teal.shade100;
        break;
      case 'Amber':
        cColor = Colors.amber.shade100;
        break;
      case 'Cyan':
        cColor = Colors.cyanAccent.shade100;
        break;
      case 'Lime':
        cColor = Colors.lime.shade100;
        break;
    }
    return cColor;
  }

  static Color? getLightColor(String colorType){
    Color? cColor = Colors.red[300];
    switch(colorType){
      case 'Indigo':
        cColor = Colors.indigo[400];
        break;
      case 'Gray':
        cColor = Colors.grey[400];
        break;
      case 'Black':
        cColor = Colors.grey[800];
        break;
      case 'Green':
        cColor = Colors.green[300];
        break;
      case 'Blue':
        cColor = Colors.blue[300];
        break;
      case 'Orange':
        cColor = Colors.orange[300];
        break;
      case 'Pink':
        cColor = Colors.pink[300];
        break;
      case 'Red':
        cColor = Colors.red[300];
        break;
      case 'Purple':
        cColor = Colors.purple[300];
        break;
      case 'Teal':
        cColor = Colors.teal[300];
        break;
      case 'Amber':
        cColor = Colors.amber[400];
        break;
      case 'Cyan':
        cColor = Colors.cyanAccent[400];
        break;
      case 'Lime':
        cColor = Colors.lime[400];
        break;
      case 'Yellow':
        cColor = Colors.amberAccent[200];
        break;
      default:
        cColor = Colors.transparent;
        break;
    }
    return cColor;
  }
  static Color? getTabColor(String colorType){
    Color? cColor = Colors.red[400];
    switch(colorType){
      case 'Indigo':
        cColor = Colors.indigo[400];
        break;
      case 'Gray':
        cColor = Colors.grey[400];
        break;
      case 'Black':
        cColor = Colors.grey[700];
        break;
      case 'Green':
        cColor = Colors.green[400];
        break;
      case 'Blue':
        cColor = Colors.blue[400];
        break;
      case 'Orange':
        cColor = Colors.orange[400];
        break;
      case 'Pink':
        cColor = Colors.pink[400];
        break;
      case 'Red':
        cColor = Colors.red[400];
        break;
      case 'Purple':
        cColor = Colors.purple[400];
        break;
      case 'Teal':
        cColor = Colors.teal[400];
        break;
      case 'Amber':
        cColor = Colors.amber[400];
        break;
      case 'Cyan':
        cColor = Colors.cyanAccent[400];
        break;
      case 'Lime':
        cColor = Colors.lime[400];
        break;
      default:
        cColor = Colors.transparent;
        break;
    }
    return cColor;
  }

  static Color? getShade100Color(String colorType){
    Color? cColor = Colors.red.shade100;
    switch(colorType){
      case 'Indigo':
        cColor = Colors.indigo.shade100;
        break;
      case 'Gray':
        cColor = Colors.grey.shade100;
        break;
      case 'Black':
        cColor = Colors.grey.shade100;
        break;
      case 'Green':
        cColor = Colors.green.shade100;
        break;
      case 'Blue':
        cColor = Colors.blue.shade100;
        break;
      case 'Orange':
        cColor = Colors.orange.shade100;
        break;
      case 'Pink':
        cColor = Colors.pink.shade100;
        break;
      case 'Red':
        cColor = Colors.red.shade100;
        break;
      case 'Purple':
        cColor = Colors.purple.shade100;
        break;
      case 'Teal':
        cColor = Colors.teal.shade100;
        break;
      case 'Amber':
        cColor = Colors.amber.shade100;
        break;
      case 'Cyan':
        cColor = Colors.cyanAccent.shade100;
        break;
      case 'Lime':
        cColor = Colors.lime.shade100;
        break;
      case 'Yellow':
        cColor = Colors.amberAccent.shade100;
        break;
      default:
        cColor = Colors.transparent;
        break;
    }
    return cColor;
  }

}