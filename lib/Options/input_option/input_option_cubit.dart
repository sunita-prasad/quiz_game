

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_questions/Options/input_option/input_option_state.dart';

class InputOptionCubit extends Cubit<InputOptionState>{
  InputOptionCubit(InputOptionState initialState) : super(initialState);

  //String? value = _
  void getTextValue(_)async {
   emit(state.copyWith(isValid: state.ans.text.isNotEmpty));
 }
}