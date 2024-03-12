
import 'package:quiz_questions/Options/option_state.dart';

class ChipOptionState extends OptionState{
  final List<String> option;
  final List<String> ans;
  final List<String> selectedAns;

  const ChipOptionState({
    required this.option,
    required this.ans,
    required this.selectedAns,
    bool isValid = false,
  }):super(isValid: isValid);

  @override
  List<Object?> get props => [...super.props,selectedAns];

  ChipOptionState copyWith({
    List<String>? option,
    List<String>? ans,
    bool? isValid,
    List<String>? selectedAns,
  }) {
    return ChipOptionState(
      option: option ?? this.option,
      ans: ans ?? this.ans,
      isValid: isValid ?? super.isValid,
      selectedAns: selectedAns ?? this.selectedAns,
    );
  }
}