
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_questions/Options/radio_option/radio_options_state.dart';


class RadioOptionCubit extends Cubit<RadioOptionState>{
  RadioOptionCubit(RadioOptionState initialState) : super(initialState);

  void onSelected(String? value){
    print(state.ans);
    emit(state.copyWith(selectedAns: value, isValid: value == state.ans));
  }
}