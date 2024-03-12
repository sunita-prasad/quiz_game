

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_questions/Options/dropdown_option/dropdown_option_state.dart';

class DropDownOptionCubit extends Cubit<DropDownOptionState>{
  DropDownOptionCubit(DropDownOptionState initialState) : super(initialState);

  void onSelected(String? value){

    print(state.ans);
    emit(state.copyWith(selectedAns: value, isValid: value == state.ans));
  }
}