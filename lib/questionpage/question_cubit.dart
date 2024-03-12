import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_questions/Options/checkbox_option/checkbox_option_cubit.dart';
import 'package:quiz_questions/Options/checkbox_option/checkbox_option_state.dart';
import 'package:quiz_questions/Options/chip_option/chip_option_cubit.dart';
import 'package:quiz_questions/Options/chip_option/chip_option_state.dart';
import 'package:quiz_questions/Options/dropdown_option/dropdown_option_cubit.dart';
import 'package:quiz_questions/Options/dropdown_option/dropdown_option_state.dart';
import 'package:quiz_questions/Options/input_option/input_option_cubit.dart';
import 'package:quiz_questions/Options/input_option/input_option_state.dart';
import 'package:quiz_questions/Options/radio_option/radio_options_cubit.dart';
import 'package:quiz_questions/Options/radio_option/radio_options_state.dart';
import 'package:quiz_questions/main.dart';
import 'package:quiz_questions/model/quiz_model.dart';
import 'package:quiz_questions/questionpage/question_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionCubit extends Cubit<BaseQuestionState> {
  final BuildContext context;

  QuestionCubit(this.context, int level, int queNo) : super(QuestionLoadingState(queNo, level)) {
    getQuestionLevel();
  }

  Future<void> getQuestionLevel() async {
    quizDAO.getQuestion(state.level, state.queNo).then((value) {
      if (value != null) {
        quiz question = value;
        switch (question.type) {
          case "radiobutton":
            var option = (jsonDecode(question.option) as Iterable).map((e) => e.toString()).toList();
            emit(QuestionState(
                level: state.level,
                queNo: state.queNo,
                quizObj: question,
                cubit: RadioOptionCubit(RadioOptionState(option: option, ans: question.ans))));
            break;

          case "checkbox":
            var option = (jsonDecode(question.option) as Iterable).map((e) => e.toString()).toList();
            var ans = (jsonDecode(question.ans) as Iterable).map((e) => e.toString()).toList();
            emit(QuestionState(
                level: state.level,
                queNo: state.queNo,
                quizObj: question,
                cubit: CheckBoxOptionCubit(CheckBoxOptionState(option: option, ans: ans, selectedAns: []))));
            break;

          case "input":
          // var ans = TextEditingController();
            emit(QuestionState(
                level: state.level,
                queNo: state.queNo,
                quizObj: question,
                cubit: InputOptionCubit(InputOptionState(ans: TextEditingController()))));
            break;

          case "dropdown":
            var option = (jsonDecode(question.option) as Iterable).map((e) => e.toString()).toList();
            emit(QuestionState(
                level: state.level,
                queNo: state.queNo,
                quizObj: question,
                cubit: DropDownOptionCubit(DropDownOptionState(option: option, ans: question.ans))));
            break;

          case "chip":
            var option = (jsonDecode(question.option) as Iterable).map((e) => e.toString()).toList();
            var ans = (jsonDecode(question.ans) as Iterable).map((e) => e.toString()).toList();
            emit(QuestionState(
                level: state.level,
                queNo: state.queNo,
                quizObj: question,
                cubit: ChipOptionCubit(ChipOptionState(option: option, ans: ans, selectedAns: []))));
            break;
        }
      }
    });
  }

  Future<void> onsubmit() async {
    if (state is QuestionState) {
      var questionstate = state as QuestionState;
      if (questionstate.cubit.state.isValid) {
        if (state.queNo % 5 == 0) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setInt("level",state.level + 1);
          Navigator.of(context)
              .pushReplacementNamed("questionpage", arguments: {"level": state.level + 1, "que_no": 1});
        } else {
          Navigator.of(context).pushReplacementNamed(
              "questionpage", arguments: {"level": state.level, "que_no": state.queNo + 1});
        }
      } else {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.orangeAccent.withOpacity(0.5),
                      )),
                  backgroundColor: Colors.white,
                  // title: Lottie.asset("assets/refresh.json",height: 90,width: 80,repeat: true,),
                  actions: [
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    clipBehavior: Clip.hardEdge,
                                      onPressed: () => Navigator.pop(context, 'Please Try Again'),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(250.0)),
                                        padding: EdgeInsets.all(10),
                                        backgroundColor: Colors.transparent

                                      ),
                                      child: Lottie.asset("assets/refresh.json",height: 120,width: 120,repeat: false,)),
                                ),
                  ],
                ));
      }
    }
  }
}
