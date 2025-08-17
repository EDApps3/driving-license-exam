import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'classData.dart';
import 'data.dart';
import 'questionChoose.dart';
import 'questionsPage.dart';
import 'selectionSquare.dart';

String selectedLanguage = "";

List<Question> signQuestionsData   = [];
List<Question> lawQuestionsData    = [];
List<Question> safetyQuestionsData = [];
List<Question> edQuestionsData     = [];
List<Question> cQQuestionsData     = [];



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    questionsData = [];
    for(int i = 0; i < questions.length; i++) {
      Question questionObj = Question.fromJson(questions[i]);
      questionsData.add(questionObj);
    }

    signQuestionsData   = questionsData.where((q) => q.type == "Signs").toList();
    lawQuestionsData    = questionsData.where((q) => q.type == "Law").toList();
    safetyQuestionsData = questionsData.where((q) => q.type == "Safety").toList();
    edQuestionsData     = questionsData.where((q) => q.type == "ED").toList();
    cQQuestionsData     = questionsData.where((q) => q.type == "Car Question").toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SizedBox(
          width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [

                    Text(
                        "Choose Language",
                        style:TextStyle(
                            fontSize:24,
                            fontWeight:FontWeight.bold
                        )
                    ),

                    SelectionSquare(
                      text: "English",
                      isSelected:(selectedLanguage == "English"),
                      onTap:(){
                        selectedLanguage = "English";
                        setState(() {});
                      },
                    ),

                    SelectionSquare(
                      text: "العربية",
                      isSelected:(selectedLanguage == "Arabic"),
                      onTap:(){
                        selectedLanguage = "Arabic";
                        setState(() {});
                      },
                    ),

                    SelectionSquare(
                      text: "French",
                      isSelected:(selectedLanguage == "French"),
                      onTap:(){
                        selectedLanguage = "French";
                        setState(() {});
                      },
                    ),

                  ],
                ),
              ),
              (selectedLanguage != "")?Padding(
                padding: const EdgeInsets.only(
                    bottom:18.0
                ),
                child: SelectionSquare(
                    text: "",
                    isSelected:false,
                    isContinue:true,
                    onTap:() {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder:
                              (context) => QuestionChoosePage()
                          )
                      );
                    }

                ),
              ):const SizedBox(),
            ],
          )
      ),
    );
  }
}
