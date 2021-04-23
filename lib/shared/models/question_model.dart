import 'dart:convert';

import 'package:dev_quiz/shared/models/awnser_model.dart';

class QuestionModel {
  final String title;
  final List<AwnserModel> answers;

  QuestionModel({
    required this.title,
    required this.answers,
  }) : assert(answers.length == 4); // o assert ele assegura uma integridade
  // por exemplo, ele acima garante que vai haver 4 respostas(nem menos, nem mais) por tela

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'awnsers': answers.map((x) => x.toMap()).toList(),
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      title: map['title'],
      answers: List<AwnserModel>.from(
          map['answers']?.map((x) => AwnserModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source));
}
