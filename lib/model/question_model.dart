class QuestionModel {
  String? question;
  List<String>? options;
  int? answerIndex;
  int? answer;

  QuestionModel({this.question, this.options, this.answerIndex, this.answer});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    options = json['options'].cast<String>();
    answerIndex = json['answer_index'];
    answer = json['answer'];
  }
  static List<QuestionModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => QuestionModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['options'] = this.options;
    data['answer_index'] = this.answerIndex;
    data['answer'] = this.answer;
    return data;
  }
}
