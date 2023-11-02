import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tutorial_controller.dart';

class QuizBox extends StatefulWidget {
  const QuizBox({super.key});

  @override
  State<QuizBox> createState() => _QuizBoxState();
}

class _QuizBoxState extends State<QuizBox> {
  final TutorialController tutorialController=Get.find();
  int currentIndex=0;
  TextEditingController userAnswerController=TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        width: width-20,
        height: height*0.8,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            blurRadius: 7,
    
          )],
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [Color.fromARGB(255, 87, 104, 114),Color.fromARGB(255, 81, 109, 133)])
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Q'+tutorialController.Data[currentIndex]['questionNumber']+'/ ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              Text(tutorialController.Data[currentIndex]['question'],style: TextStyle(color: const Color.fromARGB(255, 252, 251, 249),fontSize: 25),),
              Container(
                width: width,
                height: height*0.6,
                child: ListView.builder(
                  itemCount: tutorialController.Data[currentIndex]['answers'].length,
                  itemBuilder:(context,index){
                    final item=tutorialController.Data[currentIndex]['answers'][index];
                    if (item is String){
                      return Container(decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(10),
                      child: Text(index.toString()+'. '+item),
                      );
                    }
                    return Container();
                  }),
              )
              
              
              //text field to get the answer
              //submit button
              //if answer correct go to next question
              //else show retry button to answer again
              //view answer button to view the answer go to next question 
            ],
          ),
        ),
      ),
    );
  }
}