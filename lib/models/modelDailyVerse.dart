class modelDailyVerse{
  late int dailyVerseID;
  late int weekNo;
  late int dayNo;
  late String content;
  late String content_description;
  late String status;
  late int max_verse;
  late String devo_rhema;
  late String devo_commands;
  late String devo_warnings;
  late String devo_promises;
  late String devo_application;
  late int completion_rate;
  late String createdDt;
  late String updateDt;
  late String marker;
  modelDailyVerse({
    required this.dailyVerseID,
    required this.weekNo,
    required this.dayNo,
    required this.content,
    required this.content_description,
    required this.status,
    required this.max_verse,
    required this.devo_rhema,
    required this.devo_commands,
    required this.devo_warnings,
    required this.devo_promises,
    required this.devo_application,
    required this.completion_rate,
    required this.createdDt,
    required this.updateDt,
    required this.marker
});

   modelDailyVerse.fromMap(Map<String,dynamic> map) {
    dailyVerseID = map['dailyVerseID'];
    weekNo = map['weekNo'];
    dayNo = map['dayNo'];
    content = map['content'];
    content_description = map['content_description'];
    status = map['status'];
    max_verse = map['max_verse'];
    devo_rhema = map['devo_rhema'];
    devo_commands = map['devo_commands'];
    devo_warnings = map['devo_warnings'];
    devo_promises = map['devo_promises'];
    devo_application = map['devo_application'];
    completion_rate =  map['completion_rate'];
    createdDt = map['createdDt'];
    updateDt = map['updateDt'];
    marker = map['marker'];
  }

  Map<String,dynamic> toJson() => {
    'dailyVerseID':dailyVerseID,
    'weekNo': weekNo,
    'dayNo': dayNo,
    'content': content,
    'content_description': content_description,
    'status': status,
    'max_verse': max_verse,
    'devo_rhema': devo_rhema,
    'devo_commands': devo_commands,
    'devo_warnings': devo_warnings,
    'devo_promises': devo_promises,
    'devo_application': devo_application,
    'completion_rate': completion_rate,
    'createdDt': createdDt,
    'updateDt': updateDt,
    'marker': marker
  };

  modelDailyVerse.fromSnapshot(snapshot):
        dailyVerseID = snapshot.data()['dailyVerseID'],
        weekNo = snapshot.data()['weekNo'],
        dayNo = snapshot.data()['dayNo'],
        content = snapshot.data()['content'],
        content_description = snapshot.data()['content_description'],
        status = snapshot.data()['status'],
        max_verse = snapshot.data()['max_verse'],
        devo_rhema = snapshot.data()['devo_rhema'],
        devo_commands = snapshot.data()['devo_commands'],
        devo_warnings = snapshot.data()['devo_warnings'],
        devo_promises = snapshot.data()['devo_promises'],
        devo_application = snapshot.data()['devo_application'],
        completion_rate = snapshot.data()['completion_rate'],
        createdDt = snapshot.data()['createdDt'],
        updateDt = snapshot.data()['updateDt'],
        marker = snapshot.data()['marker'];
}