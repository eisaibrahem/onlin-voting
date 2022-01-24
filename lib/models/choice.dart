// ignore_for_file: non_constant_identifier_names

class Choice {
  final int id;
  final int question_id;
  final String choice_text;
  int votes = 0;

  Choice(
      {required this.id, required this.choice_text, required this.question_id});

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
        id: json["id"],
        question_id: json["question"],
        choice_text: json["choice_text"]);
  }
}
