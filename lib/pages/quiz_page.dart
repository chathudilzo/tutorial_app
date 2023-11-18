import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/background.jpeg'),fit: BoxFit.cover)
        ),
        child: Obx(
          (){
            if(tutorialController.isLoading.value){
              return Center(
                child: LoadingAnimationWidget.waveDots(
                  color: Colors.red,
                  size: 40
                ),
              );
            }else if(tutorialController.Data.isEmpty){
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 250,),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                      
                        image: DecorationImage(image: NetworkImage('https://media.tenor.com/YoAqt_jAr-UAAAAi/sad-broken-heart.gif'),fit: BoxFit.contain)
                      ),
                    ),
                    Text('No Quizes Available',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ],
                ),
              );
            }else{
              return Column(
                children: [
                  SizedBox(height: 100,),
                  Text(widget.name,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(height: 30,),
                  QuizBox(name: widget.name,)
                ],
              );
            }
          }
        ),
      )
    );
  }
}