import 'package:flutter/material.dart';
import 'package:lifeclass/classes/clsThemeColor.dart';

class BibleVersionSwitcher extends StatelessWidget {
  final clsThemeColor cls_themeColor;
  final Function(String) changeClick;
  const BibleVersionSwitcher({super.key,required this.cls_themeColor,required this.changeClick});

  @override
  Widget build(BuildContext context) {

    return RadioListTile<String>(
      title: Row(
        children: [
          Expanded(
              child: Text(getLabel(cls_themeColor.title))),
        ],
      ),
      value: cls_themeColor.title,
      groupValue: cls_themeColor.groupValue,
      onChanged: (value){
        changeClick(value!);
      },
      selected: cls_themeColor.groupValue == cls_themeColor.title ? true:false,
    );
  }

  String getLabel(String version){
    if(version=='NIV'){
      return 'NIV: New International Bible (English)';
    }
    else if(version=='RCPV'){
      return 'RCPV: Ang Bag ong Maayong Balita (Cebuano)';
    }
    else if(version=='ASND'){
      return 'ASND: Ang Salita Ng Diyos (Tagalog)';
    }
    else
      return '';
  }

}
