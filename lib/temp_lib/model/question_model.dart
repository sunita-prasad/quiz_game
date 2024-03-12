class Question {
  final String question;
  final String type;
  final int level;
  final String answer;
  final String option;

  const Question({
    required this.question,
    required this.type,
    required this.level,
    required this.answer,
    required this.option,
  });
}

var radioButtonQuestion = const Question(
  question: "Demo Question",
  type: "radio_button",
  level: 1,
  answer: "ans_1",
  option: "[\"ans_1\",\"ans_2\",\"ans_3\",\"ans_4\"]",
);
