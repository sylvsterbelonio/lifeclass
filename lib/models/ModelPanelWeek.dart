import 'package:flutter/cupertino.dart';

import 'ModelPanelWeekDay.dart';

class ModelPanelWeek{
  late String header;
  late List<ModelPanelWeekDay> details;
  late double completionRate;
  late String dateFinished;
  late int startIndex;
  late bool isExpanded;
  late int indexPage;
  ModelPanelWeek({required this.header,required this.details,required this.completionRate,required this.dateFinished,  required this.startIndex,  required this.isExpanded,required this.indexPage});
}