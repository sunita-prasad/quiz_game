import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
import 'package:quiz_questions/Options/option_cubit.dart';
import 'package:quiz_questions/Options/option_state.dart';
import 'package:quiz_questions/Options/radio_option/radio_options_cubit.dart';
import 'package:quiz_questions/Options/radio_option/radio_options_state.dart';
import 'package:quiz_questions/main.dart';
import 'package:quiz_questions/model/quiz_dao.dart';
import 'package:quiz_questions/model/quiz_model.dart';
import 'package:quiz_questions/questionpage/question_cubit.dart';
import 'package:quiz_questions/questionpage/question_state.dart';
import 'package:quiz_questions/temp_lib/questions/options/radio_options/radio_options_cubit.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  // List<String> parseListFromString(String value) {
  //   var decoded = jsonDecode(value);
  //   // return decoded;
  //   if (decoded is Iterable) {
  //     return decoded.map((e) => e.toString()).toList();
  //   } else {
  //     return [];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/img.jpeg"),fit: BoxFit.cover)
      ),
      child: BlocBuilder<QuestionCubit, BaseQuestionState>(
        builder: (context, state) {
          if (state is QuestionLoadingState) {
            var queno = state.queNo;
            return Column(
              children: [
                if (queno == 15)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                   Padding(
                    padding: const EdgeInsets.only(top: 220.0),
                    child: Center(
                      child: Lottie.asset("assets/wish.json",repeat: false)
                    ),
                  )
              ],
            );
          } else if (state is QuestionState) {
            var quizz = state.quizObj;
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Center(
                    child: Text(
                      "Level: ${quizz.level}",
                      style: const TextStyle(fontSize: 30, color: Colors.green,fontFamily: "Lobster",letterSpacing: 1),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Question No: ${quizz.que_no}",
                      style: const TextStyle(fontSize: 25, color: Colors.brown, fontFamily: "Lobster",letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    quizz.que,
                    style: const TextStyle(fontSize: 18, color: Colors.black, fontFamily: "BalsamiqSans"),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Builder(
                        builder: (context) {
                          switch (quizz.type) {
                            case 'radiobutton':
                              // var list = parseListFromString(quiz.option);
                              return BlocProvider.value(
                                value: state.cubit as RadioOptionCubit,
                                child: BlocBuilder<RadioOptionCubit, RadioOptionState>(
                                  builder: (context, state) {
                                    return ListView.builder(
                                      itemCount: state.option.length,
                                      itemBuilder: (context, index) {
                                        return RadioListTile<String>(
                                          activeColor: Colors.orangeAccent,
                                          value: state.option[index],
                                          groupValue: state.selectedAns,
                                          onChanged: BlocProvider.of<RadioOptionCubit>(context).onSelected,
                                          title: Text(state.option[index],style: const TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w200,fontFamily: "BalsamiqSans"),),
                                        );
                                      },
                                    );
                                  },
                                ),
                              );

                            case 'checkbox':
                              // var answer = parseListFromString(ctx.watch<ListCubit>().state.listQuiz[position].ans);
                              return BlocProvider.value(
                                value: state.cubit as CheckBoxOptionCubit,
                                child: BlocBuilder<CheckBoxOptionCubit, CheckBoxOptionState>(
                                  builder: (context, state) {
                                    return ListView.builder(
                                        itemCount: state.option.length,
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile(
                                            activeColor: Colors.orangeAccent,
                                              value: state.selectedAns.contains(state.option[index]),
                                              title: Text(state.option[index],style: const TextStyle(fontWeight: FontWeight.w200,fontFamily: "BalsamiqSans",fontSize: 15, color: Colors.black,),),
                                              onChanged: (value) =>
                                                  BlocProvider.of<CheckBoxOptionCubit>(context).onSelected(value, index));
                                        });
                                  },
                                ),
                              );

                            case 'input':
                              return BlocProvider.value(
                                value: state.cubit as InputOptionCubit,
                                child: BlocBuilder<InputOptionCubit, InputOptionState>(
                                  builder: (context, state) {
                                    return TextField(
                                      controller: state.ans,
                                      style: const TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w200,fontFamily: "BalsamiqSans"),
                                      decoration:  InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                                          focusedBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.orangeAccent),
                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                          focusedErrorBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red),
                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                          errorBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red),
                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                          filled: true,
                                          fillColor: Colors.white),
                                      onChanged: BlocProvider.of<InputOptionCubit>(context).getTextValue,
                                    );
                                  },
                                ),
                              );

                            case 'dropdown':
                              return BlocProvider.value(
                                value: state.cubit as DropDownOptionCubit,
                                child: BlocBuilder<DropDownOptionCubit, DropDownOptionState>(
                                  builder: (context, state) {
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: DropdownButton<String>(
                                        elevation: 2,
                                          borderRadius: BorderRadius.circular(10.0),
                                          iconEnabledColor: Colors.orangeAccent,
                                          icon: const Icon(Icons.arrow_drop_down_circle),
                                          value: state.selectedAns,
                                          hint: const Text("Select Option",style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w200,fontFamily: "BalsamiqSans"),),
                                          items: List.from(state.option
                                              .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e,
                                                      style: const TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w200,fontFamily: "BalsamiqSans"),
                                                    ),
                                                  ))
                                              .toList()),
                                          onChanged: BlocProvider.of<DropDownOptionCubit>(context).onSelected),
                                    );
                                  },
                                ),
                              );

                            case 'chip':
                              return BlocProvider.value(
                                value: state.cubit as ChipOptionCubit,
                                child: BlocBuilder<ChipOptionCubit, ChipOptionState>(
                                  builder: (context, state) {
                                    return Container(
                                      child: Wrap(
                                        spacing: 15,
                                        children: List.generate(
                                            state.option.length,
                                            (index) => ChoiceChip(
                                                  label: Text(state.option[index]),
                                                  labelStyle: state.selectedAns.contains(state.option[index])
                                                  ? const TextStyle(color: Colors.white,fontFamily: "BalsamiqSans")
                                                  : const TextStyle(color: Colors.black,fontFamily: "BalsamiqSans",fontWeight: FontWeight.w200),
                                                  selected: state.selectedAns.contains(state.option[index]),
                                                  selectedColor: Colors.orangeAccent,
                                                  side: state.selectedAns.contains(state.option[index])
                                                      ? BorderSide(
                                                          style: BorderStyle.solid, color: Colors.orangeAccent.withOpacity(0.7))
                                                      : BorderSide(
                                                          style: BorderStyle.solid, color: Colors.grey.withOpacity(0.3)),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                  //avatarBorder: CircleBorder(side: BorderSide(color: Colors.blue,style: BorderStyle.solid)),
                                                  onSelected: (value) =>
                                                      BlocProvider.of<ChipOptionCubit>(context).onSelected(value, index),
                                                  //     (bool selected) {
                                                  // setState(() {
                                                  // _choiceIndex = selected ? index : 0;
                                                  // });
                                                  // },
                                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                  backgroundColor: Colors.transparent,

                                                )),
                                      ),
                                    );
                                  },
                                ),
                              );
                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              backgroundColor: Colors.orangeAccent,
                              padding:const EdgeInsets.all(14.0),
                            ),
                            child: const Text("Next",style: TextStyle(fontSize: 18,fontFamily: "BalsamiqSans"),),
                            onPressed: BlocProvider.of<QuestionCubit>(context).onsubmit,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    )
        );
  }
}
