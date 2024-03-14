class modelLesson{
  late int lessonID;
  late int weekNo;
  late int lessonNo;
  late String week_title;
  late String lesson_title;
  late String answer_1;
  late String answer_2;
  late String answer_3;
  late String answer_4;
  late String answer_5;
  late String createdAt;
  late String updatedAt;
  late int maxAnswers;
  late int completionRate;
  modelLesson({
    required this.lessonID,
    required this.weekNo,
    required this.lessonNo,
    required this.week_title,
    required this.lesson_title,
    required this.answer_1,
    required this.answer_2,
    required this.answer_3,
    required this.answer_4,
    required this.answer_5,
    required this.createdAt,
    required this.updatedAt,
    required this.maxAnswers,
    required this.completionRate,
});

  factory modelLesson.fromJson(Map<String,dynamic> json) => modelLesson(
      lessonID: json['lessonID'],
      weekNo:  json['weekNo'],
      lessonNo: json['lessonNo'],
      week_title: json['week_title'],
      lesson_title: json['lesson_title'],
      answer_1: json['answer_1'],
      answer_2: json['answer_2'],
      answer_3: json['answer_3'],
      answer_4: json['answer_4'],
      answer_5: json['answer_5'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      maxAnswers: json['maxAnswers'],
      completionRate: json['completionRate'],
  );
  Map<String,dynamic> toJson() => {
    'lessonID':lessonID,
    'weekNo':  weekNo,
    'lessonNo': lessonNo,
    'week_title': week_title,
    'lesson_title':lesson_title,
    'answer_1': answer_1,
    'answer_2': answer_2,
    'answer_3': answer_3,
    'answer_4': answer_4,
    'answer_5': answer_5,
    'createdAt':createdAt,
    'updatedAt':updatedAt,
    'completionRate':completionRate,
  };
  modelLesson.fromMap(Map<String,dynamic> map) {
    lessonID =  map['lessonID'];
    weekNo = map['weekNo'];
    lessonNo = map['lessonNo'];
    week_title = map['week_title'];
    lesson_title = map['lesson_title'];
    answer_1 = map['answer_1'];
    answer_2 = map['answer_2'];
    answer_3 = map['answer_3'];
    answer_4 = map['answer_4'];
    answer_5 = map['answer_5'];
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
    maxAnswers = map['maxAnswers'];
    completionRate = map['completionRate'];
  }
  modelLesson.fromSnapshot(snapshot):
        lessonID = snapshot.data()['lessonID'],
        weekNo = snapshot.data()['weekNo'],
        lessonNo = snapshot.data()['lessonNo'],
        week_title = snapshot.data()['week_title'],
        lesson_title = snapshot.data()['lesson_title'],
        answer_1 = snapshot.data()['answer_1'],
        answer_2 = snapshot.data()['answer_2'],
        answer_3 = snapshot.data()['answer_3'],
        answer_4 = snapshot.data()['answer_4'],
        answer_5 = snapshot.data()['answer_5'],
        createdAt = snapshot.data()['createdAt'],
        updatedAt = snapshot.data()['updatedAt'],
        maxAnswers = snapshot.data()['maxAnswers'],
        completionRate = snapshot.data()['completionRate'];
}