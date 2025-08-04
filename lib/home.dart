import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'questionChoose.dart';
import 'selectionSquare.dart';

String selectedLanguage = "";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                onTap:(){
                  Get.off(()=>QuestionChoosePage());
                },
              ),
            ):const SizedBox(),
          ],
        )
      ),
    );
  }
}
