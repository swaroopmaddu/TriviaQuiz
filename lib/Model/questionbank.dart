class QuestionBank {
  int responseCode;
  List<Question> questions;

  QuestionBank({this.responseCode, this.questions});

  QuestionBank.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['results'] != null) {
      questions = new List<Question>();
      json['results'].forEach((v) {
        questions.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    if (this.questions != null) {
      data['results'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  String question;
  String correctAnswer;
  List<String> options;

  Question({this.question, this.correctAnswer, this.options});

  Question.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    correctAnswer = json['correct_answer'];
    options = json['incorrect_answers'].cast<String>();
    options.add(correctAnswer);
    options.shuffle();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['correct_answer'] = this.correctAnswer;
    data['options'] = options;
    return data;
  }
}
