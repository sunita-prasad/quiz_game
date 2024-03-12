
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:quiz_questions/model/quiz_model.dart';
import 'package:quiz_questions/model/quiz_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [quiz])
abstract class QuizDatabase extends FloorDatabase{
  QuizDAO get  quizDAO;

  static Future<QuizDatabase> get instance async{
    return $FloorQuizDatabase.databaseBuilder("sqlite.db").build();
  }
}
