import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/controllers/tutorial_controller.dart';
import 'package:tutorial_app/pages/quiz_page.dart';

class QuizButton extends StatefulWidget {
  const QuizButton({super.key,required this.name,required this.color});

  final String name;
  final Color color;

  @override
  State<QuizButton> createState() => _QuizButtonState();
}

class _QuizButtonState extends State<QuizButton> {


final TutorialController tutorialController=Get.find();

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        tutorialController.fetchData(widget.name);
        Get.to(QuizPage());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width*0.6,
          height: 45,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              blurRadius: 3,
            )],
            borderRadius: BorderRadius.circular(10),
            color:widget.color),
          child: Center(
            child: Text(widget.name,style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ),
    );
  }
}