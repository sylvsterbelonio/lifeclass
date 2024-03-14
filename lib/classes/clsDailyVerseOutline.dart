class clsDailyVerseOutline{
  late int day;
  late String status;
  late List<String> content;


  static List<String> get_daily_verse_outline(int week, int day){
    late List<String> data=[];

    switch(week){
      case 1:
        switch(day){
          case 1:
            data =  ['Genesis 1','Genesis 2','Titus 1','Titus 2','Titus 3'];
            break;
          case 2:
            data =  ['Genesis 3','Genesis 4','Genesis 5','Mathew 1'];
            break;
          case 3:
            data =  ['Genesis 6','Genesis 7','Genesis 8','Mathew 2','Mathew 3'];
            break;
          case 4:
            data =  ['Genesis 9','Genesis 10','Genesis 11','Mathew 4'];
            break;
          case 5:
            data =  ['Genesis 12','Mathew 5','Mathew 6'];
            break;
          case 6:
            data =  ['Genesis 13','Genesis 14','Genesis 15','Mathew 7'];
            break;
          case 7:
            data =  ['Genesis 16','Genesis 17','Genesis 18','Mathew 8'];
            break;
        }
    }
    return data;
    }
}