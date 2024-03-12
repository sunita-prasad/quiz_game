import 'package:flutter_bloc/flutter_bloc.dart';

import '../options_state.dart';

part 'radio_options_state.dart';

class RadioOptionsCubit extends Cubit<RadioOptionsState> {
  RadioOptionsCubit(RadioOptionsState initialState) : super(initialState);

  void onSelectionChange(String? value) {
    emit(state.copyWith(selectedAnswer: value, isValid: value == state.answer));
  }
}
