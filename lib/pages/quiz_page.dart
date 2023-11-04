import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/components/quiz_box.dart';
import 'package:tutorial_app/controllers/tutorial_controller.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key,required this.name});

  final String name;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TutorialController tutorialController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 124, 198, 221),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/background.jpeg'),fit: BoxFit.cover)
        ),
        child: Obx(
          (){
            if(tutorialController.isLoading.value){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(tutorialController.Data.isEmpty){
              return Center(
                child: Text('No Quizes Available'),
              );
            }else{
              return Column(
                children: [
                  Text(widget.name,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(height: 30,),
                  QuizBox()
                ],
              );
            }
          }
        ),
      )
    );
  }
}