import 'dart:convert';

import 'package:floor/floor.dart';

@entity
class quiz {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String que;
  String type;
  String level;
  String ans;
  String option;
  int que_no;

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  quiz({
    this.id,
    required this.que,
    required this.type,
    required this.level,
    required this.ans,
    required this.option,
    required this.que_no,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'que': que,
      'type': type,
      'level': level,
      'ans': ans,
      'option': option,
      'que_no': que_no,
    };
  }

  factory quiz.fromMap(Map<String, dynamic> map) {
    return quiz(
      id: map['id'] as int,
      que: map['que'] as String,
      type: map['type'] as String,
      level: map['level'] as String,
      ans: map['ans'] as String,
      option: map['option'] as String,
      que_no: map['que_no'] as int,
    );
  }

}
