import 'package:flutter/material.dart';
import 'package:quiz_questions/Options/option_state.dart';

class InputOptionState extends OptionState {
  final TextEditingController ans;

  const InputOptionState({required this.ans, bool isValid = false}) : super(isValid: isValid);

  @override
  List<Object?> get props => [...super.props];

  InputOptionState copyWith({
    bool? isValid,
  }) {
    return InputOptionState(ans: ans, isValid: isValid ?? super.isValid);
  }
}
