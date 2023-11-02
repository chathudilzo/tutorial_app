import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/components/quiz_box.dart';
import 'package:tutorial_app/controllers/tutorial_controller.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TutorialController tutorialController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
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
            return QuizBox();
          }
        }
      )
    );
  }
}