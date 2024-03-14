import 'dart:io';
import 'package:flutter/services.dart';
import 'package:lifeclass/models/modelBibleVerse.dart';
import 'package:lifeclass/models/modelDailyVerse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:lifeclass/classes/clsApp.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lifeclass/models/modelBibleBook.dart';
import '../../models/VerseHighlighted.dart';
import '../../models/modelLesson.dart';

class sqlHelper{

  static String getCurrentTimeStamp(){
    DateTime _now = DateTime.now();
    return '${_now.year}-${_now.month}-${_now.day} ${_now.hour}:${_now.minute}:${_now.second}';
  }
  static Future<void> createLessonTables(sql.Database database) async{
    await database.execute("""CREATE TABLE sol_lesson(
    lessonID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    lessonNo INTEGER,
    bookType TEXT,
    answer_1 TEXT,
    answer_2 TEXT,
    answer_3 TEXT,
    answer_4 TEXT,
    answer_5 TEXT,
    answer_6 TEXT,
    answer_7 TEXT,
    answer_8 TEXT,
    answer_9 TEXT,
    answer_10 TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP)
         """);
  }
  static Future<void> createDailyVerseTables(sql.Database database) async{
    await database.execute("""CREATE TABLE sol_daily_verse(
    dailyVerseId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    lessonID INTEGER,
    weekNo INTEGER,
    dayNo INTEGER,
    check_1 INTEGER NOT NULL DEFAULT 0,
    check_2 INTEGER NOT NULL DEFAULT 0,
    check_3 INTEGER NOT NULL DEFAULT 0,
    check_4 INTEGER NOT NULL DEFAULT 0,
    check_5 INTEGER NOT NULL DEFAULT 0,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP)
         """);
  }

  static Future<Database> get initDefaultDB async {
    final dbPath = await sql.getDatabasesPath();
    final path = join(dbPath,clsApp.defaultDB);
    final exist = await sql.databaseExists(path);
      if(exist)
          {
           // print('db already existed');
          }
      else{
          //  print('creating a copy from assets');
            try{
              await Directory(dirname(path)).create(recursive: true);
            }catch(err){
         //     print('there was error on creating db: $err');
            }
            ByteData data = await rootBundle.load(join("assets",clsApp.defaultDB));
            List<int> bytes = data.buffer.asInt8List(data.offsetInBytes,data.lengthInBytes);
            await File(path).writeAsBytes(bytes,flush: true);
         //   print('db copied!');
          }
    return await sql.openDatabase(path);
  }
  static Future<Database> get initNivDB async {
    final dbPath = await sql.getDatabasesPath();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectorBibleVersion = prefs.getString('bibleVersion') ?? clsApp.defaultBibleVersion;
    late String currentBibleVersion = clsApp.bibleNIVDB;
    if(selectorBibleVersion=='ASND') currentBibleVersion = clsApp.bibleASNDDB;
    if(selectorBibleVersion=='RCPV') currentBibleVersion = clsApp.bibleRCPVDB;

    final path = join(dbPath,currentBibleVersion);
    final exist = await sql.databaseExists(path);
    if(exist)
    {
    //  print('db already existed' + currentBibleVersion);
    }
    else{
    //  print('creating a copy from assets');
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(err){
      //  print('there was error on creating db: $err');
      }
      ByteData data = await rootBundle.load(join("assets",currentBibleVersion));
      List<int> bytes = data.buffer.asInt8List(data.offsetInBytes,data.lengthInBytes);
      await File(path).writeAsBytes(bytes,flush: true);
    //  print('db copied!');
    }
    return await sql.openDatabase(path);
  }
  static Future<Database> get initAsndDB async {
    final dbPath = await sql.getDatabasesPath();

    final path = join(dbPath,clsApp.bibleASNDDB);
    final exist = await sql.databaseExists(path);
    if(exist)
    {
    //  print('db already existed');
    }
    else{
   //   print('creating a copy from assets');
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(err){
     //   print('there was error on creating db: $err');
      }
      ByteData data = await rootBundle.load(join("assets",clsApp.bibleASNDDB));
      List<int> bytes = data.buffer.asInt8List(data.offsetInBytes,data.lengthInBytes);
      await File(path).writeAsBytes(bytes,flush: true);
    //  print('db copied!');
    }
    return await sql.openDatabase(path);
  }
  static Future<Database> get initRcpvDB async {
    final dbPath = await sql.getDatabasesPath();

    final path = join(dbPath,clsApp.bibleRCPVDB);
    final exist = await sql.databaseExists(path);
    if(exist)
    {
    //  print('db already existed');
    }
    else{
    //  print('creating a copy from assets');
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(err){
    //    print('there was error on creating db: $err');
      }
      ByteData data = await rootBundle.load(join("assets",clsApp.bibleRCPVDB));
      List<int> bytes = data.buffer.asInt8List(data.offsetInBytes,data.lengthInBytes);
      await File(path).writeAsBytes(bytes,flush: true);
   //   print('db copied!');
    }
    return await sql.openDatabase(path);
  }
  //INSERT TABLE
  static Future<int> addLesson(modelLesson lessonData) async{
    final db = await initDefaultDB;
    final data = {
      'lessonNo' : lessonData.lessonNo,
      'weekNo' : lessonData.weekNo,
      'answer_1' : lessonData.answer_1,
      'answer_2' : lessonData.answer_2,
      'answer_3' : lessonData.answer_3,
      'answer_4' : lessonData.answer_4,
      'answer_5' : lessonData.answer_5,
      'updatedAt': DateTime.now().toString()
    };
    final id = await db.insert('sol_lesson', data,
    conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> updateCheckReadStatus(int dailyVerseID, String status, double totalEarnedPoints, String createdDt) async{
    final db = await initDefaultDB;
    late Map<String, dynamic> row;
    // row to update
    if(createdDt.trim()!=''){
      row = {
        'status' : status,
        'completion_rate' : totalEarnedPoints.toStringAsFixed(0),
        'updateDt': DateTime.now().toString()
      };
    }else{
      row = {
        'status' : status,
        'completion_rate' : totalEarnedPoints.toStringAsFixed(0),
        'updateDt': DateTime.now().toString(),
        'createdDt': DateTime.now().toString()
      };
    }

    return await db.update('tbl_daily_verse', row, where: "dailyVerseID = ?", whereArgs: [dailyVerseID]);
  }
  static Future<int> updateDevotionalStatus(int dailyVerseID,String rhema,String commands,String warnings,String promises,String application, double totalEarnedPoints, String createdDt) async{
    final db = await initDefaultDB;
    late Map<String, dynamic> row;
    // row to update
    if(createdDt.trim()!=''){
      row = {
        'devo_rhema': rhema,
        'devo_commands' : commands,
        'devo_warnings' : warnings,
        'devo_promises' : promises,
        'devo_application' : application,
        'completion_rate' : totalEarnedPoints.toStringAsFixed(0),
        'updateDt': DateTime.now().toString()
      };
    }else{
      row = {
        'devo_rhema': rhema,
        'devo_commands' : commands,
        'devo_warnings' : warnings,
        'devo_promises' : promises,
        'devo_application' : application,
        'completion_rate' : totalEarnedPoints.toStringAsFixed(0),
        'createdDt' : DateTime.now().toString(),
        'updateDt': DateTime.now().toString()
      };
    }

    return await db.update('tbl_daily_verse', row, where: "dailyVerseID = ?", whereArgs: [dailyVerseID]);
  }


  static Future<int> updateLesson(modelLesson lessonData) async{
    final db = await initDefaultDB;
    return await db.update('tbl_my_lesson', lessonData.toJson(), where: "lessonID = ?", whereArgs: [lessonData.lessonID]);
  }
  static Future<int> updateMarker(String dailyVerseID, List<VerseHighlighted> coloredVerse) async{
    final db = await initDefaultDB;
    late String marker='';
    for(int i=0;i<coloredVerse.length;i++){
      if(i==0)
        marker = coloredVerse[i].long_name + ","
            +  coloredVerse[i].book_num.toString() + ","
            + coloredVerse[i].chapter.toString() + ","
            + coloredVerse[i].verse.toString() + ","
            + coloredVerse[i].color;
      else marker += ";" +
          coloredVerse[i].long_name + ","
          +  coloredVerse[i].book_num.toString() + ","
          + coloredVerse[i].chapter.toString() + ","
          + coloredVerse[i].verse.toString() + ","
          + coloredVerse[i].color;
    }
    late Map<String, dynamic> row; row = {'marker' : marker};
    return await db.update('tbl_daily_verse', row, where: "dailyVerseID = ?", whereArgs: [int.parse(dailyVerseID)]);
  }

  static Future<int> importLessons(int lessonID,Map<String, dynamic> row) async{
    final db = await initDefaultDB;
    return await db.update('tbl_my_lesson', row, where: "lessonID = ?", whereArgs: [lessonID]);
  }
  static Future<int> importDailyVerse(int dailyVerseID,Map<String, dynamic> row) async{
    final db = await initDefaultDB;
    return await db.update('tbl_daily_verse', row, where: "dailyVerseID = ?", whereArgs: [dailyVerseID]);
  }


  static Future<int> resetLesson() async{
    final db = await initDefaultDB;
    Map<String, dynamic> row = {
      'answer_1' : '',
      'answer_2'  : '',
      'answer_3' : '',
      'answer_4'  : '',
      'answer_5' : '',
      'createdAt' : '',
      'updatedAt': '',
      'completionRate': 0
    };
    return await db.update('tbl_my_lesson', row);
  }
  static Future<int> resetDailyVerse() async{
    final db = await initDefaultDB;
    Map<String, dynamic> row = {
      'status' : 'n,n,n,n,n,n,n,n,n',
      'devo_rhema'  : '',
      'devo_commands' : '',
      'devo_warnings'  : '',
      'devo_promises' : '',
      'devo_application'  : '',
      'completion_rate' : 0,
      'createdDt'  : '',
      'updateDt' : '',
      'marker':'',
    };
    return await db.update('tbl_daily_verse', row);
  }

  //https://www.youtube.com/watch?v=9kbt4SBKhm0
  //SOURCE CODE FROM THAT VIDEO TO LEARN MORE...//
  static getBibleName(int book_number) async{
    final db = await initNivDB;
    final result = await db.rawQuery('''SELECT * from books where book_number=?''',[book_number]);
    return modelBibleBook.fromMap(result.first);
  }

  static getBibleVerse(int book_number, int chapter) async{
    List<modelBibleVerse> bibleVerse = [];
    final db = await initNivDB;
    final result = await db.rawQuery('''SELECT * from verses where book_number=? and chapter=?''',[book_number,chapter]);
    for(var dailyVerseMap in result){
      modelBibleVerse rows =
      modelBibleVerse(
          book_number: int.parse(dailyVerseMap['book_number'].toString()),
          chapter: int.parse(dailyVerseMap['chapter'].toString()),
          verse: int.parse(dailyVerseMap['verse'].toString()),
          text: dailyVerseMap['text'].toString());
      bibleVerse.add(rows);
    }
    return bibleVerse;
  }


  static getLessonByID(int id) async{
    final db = await initDefaultDB;
    final result = await db.rawQuery('''SELECT * from tbl_my_lesson where lessonID=?''',[id]);
    return modelLesson.fromJson(result.first);
  }
  Future<List<modelDailyVerse>> getAllDailyVerseOnlySelectedID(String whereStringArguments,  List<int> whereValue) async{
    List<modelDailyVerse> dailyverse = [];
    final db = await initDefaultDB;
    List<Map<String,dynamic>> mapValues = await db.rawQuery('''SELECT * from tbl_daily_verse where $whereStringArguments''',whereValue);
    for(var dailyverseMap in mapValues){
      modelDailyVerse rows = modelDailyVerse.fromMap(dailyverseMap);
      dailyverse.add(rows);
    }
    return dailyverse;
  }

  Future<List<modelLesson>> getAllLessonsOnlySelectedID(String whereStringArguments,  List<int> whereValue) async{
    List<modelLesson> lesson = [];
    final db = await initDefaultDB;
    List<Map<String,dynamic>> mapValues = await db.rawQuery('''SELECT * from tbl_my_lesson where $whereStringArguments''',whereValue);
    for(var lessonMap in mapValues){
      modelLesson rows = modelLesson.fromMap(lessonMap);
      lesson.add(rows);
    }
    return lesson;
  }

  static getDailyVerseByID(int id) async{
    final db = await initDefaultDB;
    final result = await db.rawQuery('''SELECT * from tbl_daily_verse where dailyVerseID=?''',[id]);
    return modelDailyVerse.fromMap(result.first);
  }

    Future<List<modelDailyVerse>> getAllDailyVerse() async{
    List<modelDailyVerse> dailyverse = [];
    final db = await initDefaultDB;
    List<Map<String,dynamic>> mapValues = await db.query('tbl_daily_verse',orderBy: 'dailyVerseID');
    for(var dailyVerseMap in mapValues){
      modelDailyVerse rows = modelDailyVerse.fromMap(dailyVerseMap);
      dailyverse.add(rows);
    }
    return dailyverse;
  }

  Future<List<modelLesson>> getAllLessons() async {
    List<modelLesson> lessons = [];
    final db = await initDefaultDB;
    final mapValues = await db.rawQuery('''SELECT * from tbl_my_lesson order by lessonID''');
    for(var lessonMap in mapValues){
      modelLesson rows = modelLesson.fromMap(lessonMap);
      print('lessons->' + rows.toString());
      lessons.add(rows);
    }
    return lessons;
  }


  //DELETE RECORD
  static Future<void> deleteLesson(int id) async{
    final db = await initDefaultDB;
    try{
      await db.delete('sol_lesson', where: "lessonID=?", whereArgs: [id]);
    }catch(err){
    //  print("Something went wrong when deleting an item: $err");
    }
  }


}