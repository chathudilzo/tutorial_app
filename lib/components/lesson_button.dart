import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/pages/lesson_page.dart';

class LessonButton extends StatelessWidget {
  const LessonButton({super.key,required this.subject});
  final String subject;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(LessonPage(subject: subject));
      },
      child: Container(
                  height: 40,
                  width: 110,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 2,
                      offset: Offset(2, 3)
                    )],
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [Color.fromARGB(124, 17, 148, 224),Color.fromARGB(160, 208, 209, 212)])
                  ),
                  child: Center(
                    child: Text(subject,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Color.fromARGB(255, 32, 32, 31)),),
                  ),
                ),
    );
  }
}