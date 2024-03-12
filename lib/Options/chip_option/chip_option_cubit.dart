import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_questions/Options/chip_option/chip_option_state.dart';

class ChipOptionCubit extends Cubit<ChipOptionState> {
  ChipOptionCubit(ChipOptionState initialState) : super(initialState);

  void onSelected(bool? value, int index) {
    var selectedAnswer = List<String>.from(state.selectedAns);
    var list = List<String>.from(state.ans);
    var isValid = true;
    if (value == true) {
      selectedAnswer.add(state.option[index]);
    } else {
      selectedAnswer.remove(state.option[index]);
    }

    if (selectedAnswer.length != list.length) {
      isValid = false;
    } else {
      for (var element in list) {
        if (!selectedAnswer.contains(element)) {
          isValid = false;
          break;
        }
      }
    }

    print(list);
    print(selectedAnswer);
    emit(state.copyWith(selectedAns: selectedAnswer, isValid: isValid));
  }
}
