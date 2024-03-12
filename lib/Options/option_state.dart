

import 'package:equatable/equatable.dart';
import 'package:quiz_questions/model/quiz_model.dart';

class OptionState extends Equatable{
  // final String option;
  // final String ans;
  final bool isValid;

  @override
  List<Object?> get props =>[isValid];

  const OptionState({
    // required this.option,
    // required this.ans,
    required this.isValid,
  });

  OptionState copyWith({
    // String? ans,
    bool? isValid,
  }) {
    return OptionState(
      // option: option,
      // ans: ans ?? this.ans,
      isValid: isValid ?? this.isValid,
    );
  }
}