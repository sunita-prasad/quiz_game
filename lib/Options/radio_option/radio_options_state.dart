


import 'package:quiz_questions/Options/option_state.dart';

class RadioOptionState extends OptionState{
  final List<String> option;
  final String ans;
  final String? selectedAns;

  const RadioOptionState({
    required this.option,
    required this.ans,
    this.selectedAns,
    bool isValid = false,
}):super(isValid: isValid);

  @override
  List<Object?> get props => [...super.props,selectedAns];

  @override
  RadioOptionState copyWith({
    List<String>? option,
    String? ans,
    bool? isValid,
    String? selectedAns,
  }) {
    return RadioOptionState(
      option: option ?? this.option,
      ans: ans ?? this.ans,
      isValid: isValid ?? super.isValid,
      selectedAns: selectedAns ?? this.selectedAns,
    );
  }
}