import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_questions/temp_lib/model/question_model.dart';

import 'options/options_state.dart';
import 'options/radio_options/radio_options_cubit.dart';

part 'question_cubit.dart';

part 'question_state.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QuestionCubit, BaseQuestionState>(
        builder: (context, state) {
          if (state is QuestionLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuestionState) {
            var question = state.question;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(question.question, style: Theme.of(context).textTheme.headline5),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Builder(
                          builder: (context) {
                            switch (question.type) {
                              case "radio_button":
                                return BlocProvider.value(
                                  value: state.cubit as RadioOptionsCubit,
                                  child: BlocBuilder<RadioOptionsCubit, RadioOptionsState>(
                                    builder: (context, state) {
                                      return ListView.builder(
                                        itemCount: state.options.length,
                                        itemBuilder: (context, index) {
                                          return RadioListTile<String>(
                                            value: state.options[index],
                                            groupValue: state.selectedAnswer,
                                            title: Text(state.options[index]),
                                            onChanged: BlocProvider.of<RadioOptionsCubit>(context).onSelectionChange,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: BlocProvider.of<QuestionCubit>(context).onSubmitted,
                      child: SizedBox(width: double.infinity, child: Center(child: Text("Submit"))),
                    )
                  ],
                ),
              ),
            );
          } else
            return SizedBox.shrink();
        },
      ),
    );
  }
}
