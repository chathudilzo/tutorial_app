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
        Get.to(QuizPage(name:widget.name));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 125,
          height: 40,
          decoration: BoxDecoration(
            
            boxShadow: [BoxShadow(
              blurRadius: 1,
              spreadRadius: 2,
              color: Color.fromARGB(255, 56, 56, 56),
              offset: Offset(1, 3)
            )],
            borderRadius: BorderRadius.circular(20),
            color:widget.color),
          child: Center(
            child: Text(widget.name,style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ),
    );
  }
}