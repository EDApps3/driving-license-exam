import 'package:driving_license_exam/questionChoose.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'classData.dart';
import 'questionsPage.dart';
import 'selectionSquare.dart';
import 'storage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<List<Question>> historyQuestion = [];


  Future<void> loadHistory() async {
    historyQuestion = await KeyValueStringStorage().getHistory();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadHistory();
  }


  String getRightAnswers(List<Question> questions){
    int rightAnswers = 0;
    for (var question in questions) {
      if (question.answers.any((answer) => answer.isCorrect && answer.isSelected)) {
        rightAnswers++;
      }
    }
    return rightAnswers.toString();
  }

  List<Question> getWrongQuestions(List<Question> questions){
    List<Question> wrongQuestions = [];
    for (var question in questions) {
      if (question.answers.any((answer) => answer.isCorrect && !answer.isSelected)) {
        wrongQuestions.add(question);
      }
    }
    return wrongQuestions;
  }

  String getSignQuestionsNumber(List<Question> questions){
    int signQuestions = 0;
    for (var question in questions) {
      if (question.type == "Signs") {
        signQuestions++;
      }
    }
    return signQuestions.toString();
  }

  String getEDQuestionsNumber(List<Question> questions){
    int edQuestions = 0;
    for (var question in questions) {
      if (question.type == "ED") {
        edQuestions++;
      }
    }
    return edQuestions.toString();
  }

  String getSafetyQuestionsNumber(List<Question> questions){
    int safetyQuestions = 0;
    for (var question in questions) {
      if (question.type == "Safety") {
        safetyQuestions++;
      }
    }
    return safetyQuestions.toString();
  }

  String getLawQuestionsNumber(List<Question> questions){
    int lawQuestions = 0;
    for (var question in questions) {
      if (question.type == "Law") {
        lawQuestions++;
      }
    }
    return lawQuestions.toString();
  }


  String getCarQuestionNumber(List<Question> questions){
    int cqQuestions = 0;
    for (var question in questions) {
      if (question.type == "Car Question") {
        cqQuestions++;
      }
    }
    return cqQuestions.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading:GestureDetector(
          onTap:(){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionChoosePage(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        titleSpacing:3,
        leadingWidth:40,
        title:Text(
            "Back"
        ),
        actions: [
          TextButton(
            onPressed: () {
              KeyValueStringStorage().remove("historyData").then((value) {
                historyQuestion.clear();
                setState(() {});
              });
            },
            child: Text(
              "Clear All",
            ),
          ),
        ],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [

            for(int i=0;i<historyQuestion.length;i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width:Get.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Result: ${getRightAnswers(historyQuestion[i])}/${historyQuestion[i].length}",
                          ),
                          Wrap(
                            children: [
                              Chip(
                                label: Text(
                                  "Signs: ${getSignQuestionsNumber(historyQuestion[i])}",
                                  style:TextStyle(
                                    fontSize: 8
                                  ),
                                ),
                              ),
                              const SizedBox(width:1.5),
                              Chip(
                                label:Text(
                                  "ED: ${getEDQuestionsNumber(historyQuestion[i])}",
                                  style:TextStyle(
                                      fontSize: 8
                                  ),
                                ),
                              ),
                              const SizedBox(width:1.5),
                              Chip(
                                label:Text(
                                  "Safety: ${getEDQuestionsNumber(historyQuestion[i])}",
                                  style:TextStyle(
                                      fontSize: 8
                                  ),
                                ),
                              ),
                              const SizedBox(width:1.5),
                              Chip(
                                label:Text(
                                  "Law: ${getLawQuestionsNumber(historyQuestion[i])}",
                                  style:TextStyle(
                                      fontSize: 8
                                  ),
                                ),
                              ),
                              const SizedBox(width:1.5),
                              Chip(
                                label:Text(
                                  "Car Questions: ${getCarQuestionNumber(historyQuestion[i])}",
                                  style:TextStyle(
                                      fontSize: 8
                                  ),
                                ),
                              ),
                            ],
                          ),



                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: SingleChildScrollView(
                              scrollDirection:Axis.horizontal,
                              child: Row(
                                children: [
                                  SelectionSquare(
                                    text: "Repeat All",
                                    fontSize:11,
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder:
                                              (context) => QuestionsPage(
                                                sentQuestions: historyQuestion[i],
                                              )
                                          )
                                      );
                                    },
                                  ),
                                  SelectionSquare(
                                    text: "Repeat Only Wrong Question",
                                    fontSize:11,
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder:
                                              (context) => QuestionsPage(
                                                sentQuestions: getWrongQuestions(historyQuestion[i]),
                                              )
                                          )
                                      );

                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),





                        ],
                    ),
                ),
              ),





              ),
          ],
        ),
      ),
    );
  }
}
