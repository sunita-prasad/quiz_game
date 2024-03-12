
import 'package:floor/floor.dart';
import 'package:quiz_questions/model/quiz_model.dart';

@dao
abstract class QuizDAO{

  @Query('SELECT * FROM quiz')
  Future<List<quiz>> retrieveQuiz();

  @Query('SELECT * FROM quiz WHERE level=:level AND que_no=:queNo')
  Future<quiz?> getQuestion(int level, int queNo);

}