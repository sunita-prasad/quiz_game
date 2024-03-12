import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_questions/Options/option_state.dart';
import 'package:quiz_questions/model/quiz_model.dart';

class BaseQuestionState extends Equatable {
  final int queNo;
  final int level;

  @override
  List<Object?> get props => [];

  const BaseQuestionState({
    required this.queNo,
    required this.level,
  });
}

class QuestionLoadingState extends BaseQuestionState {
  const QuestionLoadingState(int queNo, int level) : super(level: level, queNo: queNo);
}

class QuestionState extends BaseQuestionState {
  final quiz quizObj;
  final Cubit<OptionState> cubit;

  const QuestionState({required int queNo, required int level, required this.quizObj, required this.cubit})
      : super(queNo: queNo, level: level);

  @override
  List<Object?> get props => [quizObj, cubit];

  QuestionState copyWith({

    quiz? quizObj,
    Cubit<OptionState>? cubit,
  }) {
    return QuestionState(
      queNo: queNo,
      level: level,
      quizObj: quizObj ?? this.quizObj,
      cubit: cubit ?? this.cubit,
    );
  }
}
