part of 'question_view.dart';

class QuestionCubit extends Cubit<BaseQuestionState> {
  final BuildContext _context;

  QuestionCubit(this._context) : super(QuestionLoadingState()) {
    Timer(Duration(seconds: 10), () {
      var question = radioButtonQuestion;
      switch (question.type) {
        case "radio_button":
          var options = (jsonDecode(question.option) as Iterable).map((e) => e.toString()).toList();
          emit(
            QuestionState(
              question: question,
              cubit: RadioOptionsCubit(RadioOptionsState(
                options: options,
                answer: question.answer,
              )),
            ),
          );
      }
    });
  }

  void onSubmitted() {
    if (state is QuestionState) {
      var questionState = state as QuestionState;
      if (questionState.cubit.state.isValid) {
        print("true");
      } else {
        print("false");
      }
    }
  }
}
