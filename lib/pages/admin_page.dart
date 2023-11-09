import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/controllers/tutorial_controller.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({super.key,required this.name});
  final String name;

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  TextEditingController questionNumberController=TextEditingController();
  TextEditingController questionController=TextEditingController();
  TextEditingController answerController=TextEditingController();
  TextEditingController answersController=TextEditingController();

  final TutorialController tutorialController=Get.find();


  void addQuestion()async{
    final question=questionController.text;
    final answer=answerController.text;
    final answers=answersController.text.split(',');
    
    if(question!='' && answer!=''&& answers.length>3&& answers.length<5){
      final result=await tutorialController.addNewQuestion(question, answer, answers, widget.name);
      if(result){
        questionController.text='';
        answerController.text='';
        answersController.text='';
      }
    }else{
      Get.snackbar('Error', 'All the fields must be filled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
appBar: AppBar(
  backgroundColor: Color.fromARGB(255, 46, 46, 46),
),
     
      body: Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        color: Color.fromARGB(255, 12, 12, 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          image: DecorationImage(image: AssetImage('assets/questionback2.jpeg'),fit: BoxFit.cover)),
                      ),
                    ),
                    SizedBox(height: 10,),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                      children: [
                        FormFieldWid(controller: questionController, label: 'Question'),
                     SizedBox(height: 10,),
                     FormFieldWid(controller: answerController, label: 'Correct Answer'),
                     SizedBox(height: 10,),
                     FormFieldWid(controller: answersController, label: 'List of Answers (comma-separated)'),
                      ],
                     ),
                   ),
                   ElevatedButton(
                    style: ButtonStyle(

                    ),
                    onPressed: (){
                      addQuestion();
                    }, child: Text('Add Question'))
                  ],
                ))
              ],
            ),
          ),
        ),
     
    );
  }
}


class FormFieldWid extends StatelessWidget {
  const FormFieldWid({super.key,required this.controller,required this.label});

  final TextEditingController controller;
  final String label;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
                    controller: controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: const Color.fromARGB(255, 202, 105, 240)),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white
                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: label),
                  );
  }
}