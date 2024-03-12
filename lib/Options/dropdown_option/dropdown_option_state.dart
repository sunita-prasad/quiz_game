

import 'package:quiz_questions/Options/option_state.dart';

class DropDownOptionState extends OptionState{
  final List<String> option;
  final String ans;
  final String? selectedAns;

  const DropDownOptionState({
    required this.option,
    required this.ans,
    this.selectedAns,
    bool isValid = false,
  }):super(isValid: isValid);

  @override
  List<Object?> get props => [...super.props,selectedAns];

  DropDownOptionState copyWith({
    List<String>? option,
    String? ans,
    bool? isValid,
    String? selectedAns,
  }) {
    return DropDownOptionState(
      option: option ?? this.option,
      ans: ans ?? this.ans,
      isValid: isValid ?? this.isValid,
      selectedAns: selectedAns ?? this.selectedAns,
    );
  }
}