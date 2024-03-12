part of 'question_view.dart';

class BaseQuestionState extends Equatable {
  const BaseQuestionState();

  @override
  List<Object?> get props => [];
}

class QuestionLoadingState extends BaseQuestionState {}

class QuestionState extends BaseQuestionState {
  final Question question;
  final Cubit<OptionsState> cubit;

  const QuestionState({
    required this.question,
    required this.cubit,
  });

  QuestionState copyWith({
    Question? question,
    Cubit<OptionsState>? cubit,
  }) {
    return QuestionState(
      question: question ?? this.question,
      cubit: cubit ?? this.cubit,
    );
  }
}
