import 'package:driving_license_exam/data.dart';
import 'package:driving_license_exam/home.dart';
import 'package:driving_license_exam/tf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'historyPage.dart';
import 'questionsPage.dart';
import 'selectionSquare.dart';

String radioSelection = "RQ";

bool catASelected  = false;
bool catGSelected  = true;
bool catCSelected  = false;
bool catBCSelected = true;

int signsNumber = 10;
int lawNumber = 10;
int safetyNumber = 10;
int edNumber = 10;
int rQNumber = 30;

void goToQuestionsPage(BuildContext context) {
  if(catASelected==false &&
      catGSelected==false &&
      catCSelected==false &&
      catBCSelected==false
  ) {
    showErrorDialog(
        title: "No Category Selected",
        description: "You have to select at least one category to continue.",
        context:context
    );
  }
  else {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => QuestionsPage(
          key: UniqueKey(),
        ),
      ),
    );
  }
}


void showErrorDialog({
  required title,
  required description,
  required context,
}) {
  showDialog(
    context:context,
      builder: (context) =>
      AlertDialog(
        title: Text(title),
        content: Text(
            description
        ),
        actions: [
          SelectionSquare(
            text: "",
            isSelected: false,
            isContinue: true,
            onTap: () {
              Get.close();
            },
          ),
        ],
      )
  );
}


void showExceedNumberDialog() {
  Get.dialog(
      AlertDialog(
        title: Text("Exceed Number"),
        content: Text(
            "You have exceeded the number of questions available. Please choose a smaller number."
        ),
        actions: [
          SelectionSquare(
            text: "",
            isSelected: false,
            isContinue: true,
            onTap: () {
              Get.close();
            },
          ),
        ],
      )
  );
}

class QuestionChoosePage extends StatefulWidget {
  const QuestionChoosePage({super.key});

  @override
  State<QuestionChoosePage> createState() => _QuestionChoosePageState();
}

class _QuestionChoosePageState extends State<QuestionChoosePage> {
  final TextEditingController signTF = TextEditingController(
      text:"10"
  );
  final TextEditingController lawTF = TextEditingController(
      text:"10"
  );
  final TextEditingController safetyTF = TextEditingController(
      text:"10"
  );
  final TextEditingController edTF = TextEditingController(
      text:"10"
  );
  final TextEditingController qNumberTF = TextEditingController(
      text:"30"
  );


  @override
  void initState() {
    super.initState();
    catASelected  = false;
    catGSelected  = true;
    catCSelected  = false;
    catBCSelected = true;

    signsNumber = 10;
    lawNumber = 10;
    safetyNumber = 10;
    edNumber = 10;
    rQNumber = 30;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SizedBox(
        width:Get.width,
        height:Get.height,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:60,
                      ),

                      Text(
                        "Choose How You Need to Examine Yourself",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        height:20,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child:Column(
                          children: [
                            RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              value: "RQ",
                              title: Text("Random Questions"),
                              groupValue: radioSelection,
                              onChanged: (value) {
                                setState(() {
                                  radioSelection = value.toString();
                                });
                              },
                            ),
                            (radioSelection=="RQ")?Column(
                              children: [
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Choose Number of Random Questions Out of ${questions.length}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFieldApp(
                                        controller:qNumberTF,
                                        onChanged: (value) {
                                          if(value!=""){
                                            int a = int.parse(value);
                                            if(a<=questions.length){
                                              rQNumber = a;
                                            }
                                            else {
                                              qNumberTF.text = questions.length.toString();
                                              showExceedNumberDialog();
                                            }
                                          }
                                          else {
                                            rQNumber=-1;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ):const SizedBox(),


                          ],
                        ),
                      ),



                      SizedBox(height:10,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child:Column(
                          children: [

                            RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              value: "CQ",
                              title: Text("Customize Questions"),
                              groupValue: radioSelection,
                              onChanged: (value) {
                                setState(() {
                                  radioSelection = value.toString();
                                });
                              },
                            ),

                            (radioSelection=="CQ")?Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Signs Out Of ${signQuestionsData.length}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFieldApp(
                                        controller:signTF,
                                        onChanged: (value) {
                                          if(value!=""){
                                            int a = int.parse(value);
                                            if(a<=signQuestionsData.length){
                                              signsNumber = a;
                                            }
                                            else {
                                              signTF.text = signQuestionsData.length.toString();
                                              showExceedNumberDialog();
                                            }
                                          }
                                          else {
                                            signsNumber=-1;
                                          }
                                        },
                                      ),

                                      Text(
                                        "Law Out Of ${lawQuestionsData.length}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFieldApp(
                                        controller:lawTF,
                                        onChanged: (value) {
                                          if(value!=""){
                                            int a = int.parse(value);
                                            if(a<=lawQuestionsData.length){
                                              lawNumber = a;
                                            }
                                            else {
                                              lawTF.text = lawQuestionsData.length.toString();
                                              showExceedNumberDialog();
                                            }
                                          }
                                          else {
                                            lawNumber=-1;
                                          }
                                        },
                                      ),
                                      Text(
                                        "Safety Out Of ${safetyQuestionsData.length}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFieldApp(
                                        controller:safetyTF,
                                        onChanged: (value) {
                                          if(value!=""){
                                            int a = int.parse(value);
                                            if(a<=safetyQuestionsData.length){
                                              safetyNumber = a;
                                            }
                                            else {
                                              safetyTF.text = safetyQuestionsData.length.toString();
                                              showExceedNumberDialog();
                                            }
                                          }
                                          else {
                                            safetyNumber=-1;
                                          }

                                        },
                                      ),

                                      Text(
                                        "ED Out Of ${edQuestionsData.length}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFieldApp(
                                        controller:edTF,
                                        onChanged: (value) {
                                          if(value!=""){
                                            int a = int.parse(value);
                                            if(a<=edQuestionsData.length){
                                              edNumber = a;
                                            }
                                            else {
                                              edTF.text = edQuestionsData.length.toString();
                                              showExceedNumberDialog();
                                            }
                                          }
                                          else {
                                            edNumber=-1;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ):const SizedBox(),

                          ],
                        ),
                      ),

                      Divider(),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        value: catASelected,
                        title: Text("A [Motorcycles]"),
                        onChanged: (value) {
                          setState(() {
                            catASelected = value!;
                          });
                        },
                      ),

                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        value: catGSelected,
                        title: Text("G [General]"),
                        onChanged: (value) {
                          setState(() {
                            catGSelected = value!;
                          });
                        },
                      ),

                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        value: catCSelected,
                        title: Text("C [Trucks]"),
                        onChanged: (value) {
                          setState(() {
                            catCSelected = value!;
                          });
                        },
                      ),

                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        value: catBCSelected,
                        title: Text("BC [Cars and trucks]"),
                        onChanged: (value) {
                          setState(() {
                            catBCSelected = value!;
                          });
                        },
                      ),

                      Divider(),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child:ListTile(
                      title: Text("History"),
                      trailing:  Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder:
                                (context) => HistoryPage()
                            )
                        );
                      },

                  ),
                  ),





                    ],
                  ),
                ),
              ),
            ),
            SelectionSquare(
              text: "",
              isSelected:false,
              isContinue:true,
              onTap:(){
                if(radioSelection=="RQ"){
                  if(rQNumber==-1){
                    showErrorDialog(
                        title:"Choose Random Questions",
                        description:"You have to choose a number of random questions to continue.",
                        context:context
                    );
                  }
                  else {
                    goToQuestionsPage(context);
                  }
                }
                else if(radioSelection=="CQ"){
                  if(signsNumber==-1){
                    showErrorDialog(
                        title:"Choose Signs Questions",
                        description:"You have to choose a number of signs questions to continue.",
                        context:context
                    );
                  }
                  else if(lawNumber==-1){
                    showErrorDialog(
                        title:"Choose Law Questions",
                        description:"You have to choose a number of law questions to continue.",
                        context:context

                    );
                  }
                  else if(safetyNumber==-1){
                    showErrorDialog(
                        title:"Choose Safety Questions",
                        description:"You have to choose a number of safety questions to continue.",
                        context:context
                    );
                  }
                  else if(lawNumber==-1){
                    showErrorDialog(
                        title:"Choose Law Questions",
                        description:"You have to choose a number of Law questions to continue.",
                        context:context

                    );
                  }
                  else if(safetyNumber==-1){
                    showErrorDialog(
                        title:"Choose Safety Questions",
                        description:"You have to choose a number of Safety questions to continue.",
                        context:context
                    );
                  }
                  else if(edNumber==-1){
                    showErrorDialog(
                        title:"Choose ED Questions",
                        description:"You have to choose a number of ED questions to continue.",
                        context:context
                    );
                  }
                  else {
                    goToQuestionsPage(context);
                  }
                }
                else{
                  goToQuestionsPage(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}