// ignore_for_file: non_constant_identifier_names

import 'choice.dart';

class Poll {
  final int id;
  final String question_text;
  List<Choice> choices = [];
  String pubdate = "";

  Poll({required this.id, required this.question_text});

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(id: json["id"], question_text: json["question_text"]);
  }
}
