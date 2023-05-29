class QuestionUpdateModel{
  String? question_id;
  String? answer;

  QuestionUpdateModel({this.question_id, this.answer});
  Map<String, dynamic> toJson() => {
    "question_id": question_id == null ? null : question_id,
    "answer": answer == null ? null : answer,
  };
}
class LanguageListUpdateModel{
  String? language_id;
  String? language;
  LanguageListUpdateModel({this.language,this.language_id});
  Map<String, dynamic> toJson() => {
    "language_id": language_id == null ? null : language_id,
    "language": language == null ? null : language,
  };
}