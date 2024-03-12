
import 'package:quiz_questions/Options/option_state.dart';

class CheckBoxOptionState extends OptionState{
  final List<String> option;
  final List<String> ans;
  final List<String> selectedAns;

  const CheckBoxOptionState({
    required this.option,
    required this.ans,
    required this.selectedAns,
    bool isValid = false,
  }):super(isValid: isValid);

  @override
  List<Object?> get props => [...super.props,selectedAns];

  CheckBoxOptionState copyWith({
    List<String>? option,
    List<String>? ans,
    bool? isValid,
    List<String>? selectedAns,
  }) {
    return CheckBoxOptionState(
      option: option ?? this.option,
      ans: ans ?? this.ans,
      isValid: isValid ?? super.isValid,
      selectedAns: selectedAns ?? this.selectedAns,
    );
  }
}