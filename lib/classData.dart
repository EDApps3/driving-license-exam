import 'dart:convert';
import 'dart:developer';

// The main class for a single question object.
class Question {
  final String id, image;
  final String type;
  final String category;
  final QuestionData question;
  List<Answer> answers;

  Question({
    required this.id,
    required this.type,
    required this.category,
    required this.question,
    required this.answers,
    this.image = "",
  });

  void clearSelections() {
    for (var answer in answers) {
      answer.isSelected = false;
    }
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    var answersList = json['answers'] as List;
    List<Answer> answers = answersList.map((i) => Answer.fromJson(i)).toList();

    return Question(
      id: json['id'],
      image: json['image'] ?? "",
      type: json['type'],
      category: json['category'],
      question: QuestionData.fromJson(json['question']),
      answers: answers,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'type': type,
    'category': category,
    'question': question.toJson(),
    'answers': answers.map((a) => a.toJson()).toList(),
  };
}

// Class to handle the multi-language question text.
class QuestionData {
  final String arabic;
  final String english;
  final String french;

  QuestionData({
    required this.arabic,
    required this.english,
    required this.french,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      arabic: json['arabic'],
      english: json['english'],
      french: json['french'],
    );
  }

  Map<String, dynamic> toJson() => {
    'arabic': arabic,
    'english': english,
    'french': french,
  };
}

// Class to handle each answer, including the correct status.
class Answer {
  final String arabic;
  final String english;
  final String french;
  final bool isCorrect;
  bool isSelected;

  Answer({
    required this.arabic,
    required this.english,
    required this.french,
    required this.isCorrect,
    this.isSelected = false,
  });

  void printAnswer() {
    log("Answer: $arabic, Correct: $isCorrect, Selected: $isSelected");
  }

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      arabic: json['arabic'],
      english: json['english'],
      french: json['french'],
      isCorrect: json['is_correct'],
      isSelected: json['is_selected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'arabic': arabic,
    'english': english,
    'french': french,
    'is_correct': isCorrect,
    'is_selected': isSelected,
  };
}
