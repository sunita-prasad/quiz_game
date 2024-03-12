part of 'radio_options_cubit.dart';

class RadioOptionsState extends OptionsState {
  final List<String> options;
  final String answer;
  final String? selectedAnswer;

  const RadioOptionsState({
    required this.options,
    required this.answer,
    this.selectedAnswer,
    bool isValid = false,
  }) : super(isValid: isValid);

  @override
  List<Object?> get props => [...super.props, selectedAnswer];

  RadioOptionsState copyWith({
    List<String>? options,
    String? answer,
    bool? isValid,
    String? selectedAnswer,
  }) {
    return RadioOptionsState(
      options: options ?? this.options,
      answer: answer ?? this.answer,
      isValid: isValid ?? super.isValid,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }
}
