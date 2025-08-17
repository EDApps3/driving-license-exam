import 'dart:convert';
import 'dart:math';
import 'package:driving_license_exam/data.dart';
import 'package:driving_license_exam/questionChoose.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'classData.dart';
import 'home.dart';
import 'selectionSquare.dart';
import 'storage.dart';



List<Question> questionsData = [];

List<T> getRandomUniqueItems<T>(List<T> list, int n) {
  if (n > list.length) {
    throw ArgumentError("Can't pick more elements than exist in the list");
  }

  List<T> tempList = List.from(list); // clone list to avoid modifying original
  tempList.shuffle(Random());

  return tempList.take(n).toList();
}

class QuestionsPage extends StatefulWidget {
  final List<Question>? sentQuestions;

  const QuestionsPage({
    super.key,
    this.sentQuestions
  });

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  List<Question> toAskQuestions = [];
  int rightAnswers = 0;
  bool proceed=false;
  bool wrongAnswersOnly = false;
  List<Question> mainAllList = [];


  void generateQuestions() {
    if(widget.sentQuestions!=null) {
      toAskQuestions = widget.sentQuestions!;
    }
    else {
      try {
        questionsData = [];
        List<String> selectedCategories = [];
        if(catBCSelected) {
          selectedCategories.add("BC");
        }
        if(catASelected) {
          selectedCategories.add("A");
        }
        if(catCSelected) {
          selectedCategories.add("C");
        }
        if(catGSelected) {
          selectedCategories.add("G");
        }
        for(int i = 0; i < questions.length; i++) {
          Question questionObj = Question.fromJson(questions[i]);
          if(selectedCategories.contains(questionObj.category)){
            questionsData.add(questionObj);
          }
        }
        if(radioSelection=="RQ") {
          if(questionsData.isNotEmpty) {
            toAskQuestions = getRandomUniqueItems(questionsData,rQNumber);
          }
        }
        else if(radioSelection=="CQ") {
          if(questionsData.isNotEmpty) {
            List<Question> onlySignsQuestion   = signQuestionsData.where((q) => selectedCategories.contains(q.category)).toList();
            if(onlySignsQuestion.isNotEmpty){
              List<Question> randomSignsQuestion = getRandomUniqueItems(onlySignsQuestion,signsNumber);
              toAskQuestions.addAll(randomSignsQuestion);
            }

            List<Question> onlyLawQuestion   = lawQuestionsData.where((q) => selectedCategories.contains(q.category)).toList();
            if(onlyLawQuestion.isNotEmpty) {
              List<Question> randomLawQuestion = getRandomUniqueItems(onlyLawQuestion,lawNumber);
              toAskQuestions.addAll(randomLawQuestion);
            }

            List<Question> onlySafetyQuestion   = safetyQuestionsData.where((q) => selectedCategories.contains(q.category)).toList();
            if(onlySafetyQuestion.isNotEmpty){
              List<Question> randomSafetyQuestion = getRandomUniqueItems(onlySafetyQuestion,safetyNumber);
              toAskQuestions.addAll(randomSafetyQuestion);
            }


            List<Question> onlyEDQuestion   = edQuestionsData.where((q) => selectedCategories.contains(q.category)).toList();
            if(onlyEDQuestion.isNotEmpty){
              List<Question> randomEDQuestion = getRandomUniqueItems(onlyEDQuestion,edNumber);
              toAskQuestions.addAll(randomEDQuestion);
            }

            List<Question> onlyCQQuestion   = cQQuestionsData.where((q) => selectedCategories.contains(q.category)).toList();
            if(onlyCQQuestion.isNotEmpty){
              List<Question> randomCQQuestion = getRandomUniqueItems(onlyCQQuestion,cQNumber);
              toAskQuestions.addAll(randomCQQuestion);
            }

            toAskQuestions.shuffle();
          }
        }
      }
      catch (e) {
        print("Error: $e");
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder:
                  (context) => HomePage()
              )
          );
        });
      }
    }
    for(int i=0;i<toAskQuestions.length;i++){
      List<Answer> shuffledAnswers = toAskQuestions[i].answers;
      shuffledAnswers.shuffle();
      toAskQuestions[i].answers = shuffledAnswers;
    }
  }

  @override
  void initState() {
    generateQuestions();
    super.initState();
  }

  void showOnlyWrongAnswers() {
    if(wrongAnswersOnly==true){
      List<Question> wrongQuestions = [];
      for(int i = 0; i < toAskQuestions.length; i++) {
        bool hasWrongAnswer = false;
        for(int j = 0; j < toAskQuestions[i].answers.length; j++) {
          if(toAskQuestions[i].answers[j].isSelected && !toAskQuestions[i].answers[j].isCorrect) {
            hasWrongAnswer = true;
            break;
          }
        }
        if(hasWrongAnswer) {
          wrongQuestions.add(toAskQuestions[i]);
        }
      }
      toAskQuestions = wrongQuestions;
    }
    else {
      toAskQuestions = mainAllList;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child: Column(
            children: [


              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:(selectedLanguage=="Arabic")?CrossAxisAlignment.end: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height:40,
                      ),

                      for(int i=0;i<toAskQuestions.length;i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment:(selectedLanguage=="Arabic")?CrossAxisAlignment.end: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Question ${i+1} - #${toAskQuestions[i].id} - Cat ${toAskQuestions[i].category} - Type ${toAskQuestions[i].type}",
                                    textDirection: (selectedLanguage == "Arabic")?TextDirection.rtl:TextDirection.ltr,
                                    style: TextStyle(
                                      fontSize: 18.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    (selectedLanguage == "Arabic")?toAskQuestions[i].question.arabic:
                                    (selectedLanguage == "French")?toAskQuestions[i].question.french:
                                    toAskQuestions[i].question.english,
                                    textDirection: (selectedLanguage == "Arabic")?TextDirection.rtl:TextDirection.ltr,
                                    style: TextStyle(
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  (toAskQuestions[i].image!="")?
                                  Image.asset(
                                    toAskQuestions[i].image,
                                  ):
                                  Container(),
                                  Divider(),
                                  for(int j=0;j<toAskQuestions[i].answers.length;j++)
                                    SelectionSquare(
                                      textAlign: (selectedLanguage == "Arabic")?TextAlign.right:TextAlign.left,
                                      fullWidth: true,
                                      text: (selectedLanguage == "Arabic")?toAskQuestions[i].answers[j].arabic:
                                      (selectedLanguage == "French")?toAskQuestions[i].answers[j].french:
                                      toAskQuestions[i].answers[j].english,
                                      isSelected: toAskQuestions[i].answers[j].isSelected,
                                      selectedColor:(toAskQuestions[i].answers[j].isCorrect && proceed==true)?Colors.green:(
                                          proceed==true && toAskQuestions[i].answers[j].isSelected?Colors.red:null
                                      ),
                                      onTap: () {
                                        toAskQuestions[i].clearSelections(); // Clear previous selections
                                        // Handle answer selection
                                        // You can implement your logic here
                                        print("Selected Answer: ${toAskQuestions[i].answers[j]}");
                                        toAskQuestions[i].answers[j].isSelected = true;
                                        setState(() {});
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        )





                    ],
                  ),
                ),
              ),

              (proceed==false)?SelectionSquare(
                text: "",
                isSelected:false,
                isContinue:true,
                onTap:(){
                  rightAnswers =0;
                  for(int i=0;i<toAskQuestions.length;i++) {
                    for(int j=0;j<toAskQuestions[i].answers.length;j++) {
                      if(toAskQuestions[i].answers[j].isSelected) {
                        toAskQuestions[i].answers[j].printAnswer();
                        if(toAskQuestions[i].answers[j].isCorrect) {
                          rightAnswers++;
                        }
                      }
                    }
                  }
                  proceed = true;
                  setState(() {});
                  if(widget.sentQuestions==null) {
                    KeyValueStringStorage().saveHistory(toAskQuestions);
                  }
                  showDialog(
                    context:context,
                      barrierDismissible: false,
                    builder:(context) => AlertDialog(
                      title: Text("Results"),
                      content: Text("You answered $rightAnswers out of ${toAskQuestions.length} questions correctly."),
                      actions: [
                        SelectionSquare(
                          text: "Close",
                          isSelected: false,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SelectionSquare(
                          text: "OK",
                          isSelected: false,
                          isContinue: true,
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                        ),

                      ],
                    )
                  );
                  mainAllList = toAskQuestions;
                },
              ):SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SelectionSquare(
                      text: "Home",
                      isSelected:false,
                      onTap:(){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder:
                                (context) => HomePage()
                            )
                        );
                        },
                    ),
                    SelectionSquare(
                      text: (wrongAnswersOnly==true)?"Wrong Answers Only":"All Answers",
                      isSelected:false,
                      onTap:(){
                        setState(() {
                          wrongAnswersOnly = !wrongAnswersOnly;
                        });
                        showOnlyWrongAnswers();

                      },
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
