import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_questions/Options/checkbox_option/checkbox_option_state.dart';
import 'package:quiz_questions/model/quiz_model.dart';

class CheckBoxOptionCubit extends Cubit<CheckBoxOptionState> {
  CheckBoxOptionCubit(CheckBoxOptionState initialState) : super(initialState);

  void onSelected(bool? value, int index) {
    var selectedAnswers = List<String>.from(state.selectedAns);
    var list = List<String>.from(state.ans);
    var isValid = true;
    if (value == true) {
      selectedAnswers.add(state.option[index]);
    } else {
      selectedAnswers.remove(state.option[index]);
    }


    //match ans and selected answer
    if(selectedAnswers.length != list.length){
      isValid = false;
    }
    else{
      for (var element in list) {
        if (!selectedAnswers.contains(element)) {
          isValid = false;
          break;
        }
      }
    }



    // for (var i = 0; i <= list.length; i++) {
    //   if (!selectedAnswers.contains(state.ans[i])) {
    //     isValid = false;
    //     break;
    //   }
    // }

    print(list);
    print(selectedAnswers);
    emit(state.copyWith(selectedAns: selectedAnswers, isValid: isValid));
  }
}
