import 'package:driving_license_exam/tf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                        height:100,
                      ),

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
                      (radioSelection=="RQ")?Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Choose Number of Random Questions",
                            ),
                            TextFieldApp(
                              controller:qNumberTF,
                              onChanged: (value) {
                                rQNumber = int.parse(value);
                              },
                            ),
                          ],
                        ),
                      ):const SizedBox(),

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

                      (radioSelection=="CQ")?Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Signs"
                            ),
                            TextFieldApp(
                              controller:signTF,
                              onChanged: (value) {
                                signsNumber = int.parse(value);
                              },
                            ),

                            Text(
                                "Law"
                            ),
                            TextFieldApp(
                              controller:lawTF,
                              onChanged: (value) {
                                lawNumber = int.parse(value);
                              },
                            ),
                            Text(
                                "Safety"
                            ),
                            TextFieldApp(
                              controller:safetyTF,
                              onChanged: (value) {
                                safetyNumber = int.parse(value);
                              },
                            ),

                            Text(
                                "ED"
                            ),
                            TextFieldApp(
                              controller:edTF,
                              onChanged: (value) {
                                edNumber = int.parse(value);
                              },
                            ),

                          ],
                        ),
                      ):const SizedBox(),


                      Divider(),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Categories",
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
























                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom:18.0
              ),
              child: SelectionSquare(
                text: "",
                isSelected:false,
                isContinue:true,
                onTap:(){
                  Get.off(()=>QuestionsPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
