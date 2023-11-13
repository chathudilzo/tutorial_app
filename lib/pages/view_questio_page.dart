import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/controllers/tutorial_controller.dart';

class ViewQuestionPage extends StatefulWidget {
  const ViewQuestionPage({super.key,required this.name});
  final String name;

  @override
  State<ViewQuestionPage> createState() => _ViewQuestionPageState();
}

class _ViewQuestionPageState extends State<ViewQuestionPage> {
  TutorialController tutorialController=Get.find();
 
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tutorialController.fetchData(widget.name) ;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Obx((){
        if(tutorialController.isLoading.value){
          return Center(child: CircularProgressIndicator());
        }else{
          if(!tutorialController.isEmpty.value){
            return ListView.builder(
            itemCount: tutorialController.Data.length,
            itemBuilder:(context,index){
              final questionData=tutorialController.Data[index];
              print(questionData);
              return QuestionItem(questionData:questionData);
            } );
          }else{
            return Center(
              child: Text('No data found!',style: TextStyle(color: Colors.white),),
            );
          }
        }
      })
    );
  }
}


class QuestionItem extends StatefulWidget {
  const QuestionItem({super.key,required this.questionData});

  final Map<String,dynamic> questionData;

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  late final String question;
  late final String correctAnswer;
  late List<dynamic> answers;
  late final String questionNumber;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignData();
  }

void assignData(){
  print(widget.questionData);
  question=widget.questionData['question'];
   correctAnswer=widget.questionData['answer'];
  answers=widget.questionData['answers'] as List<dynamic>;
  //questionNumber=widget.questionData['questionNumber'];

}

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text(questionNumber),
              Text(question)
            ],
          
        
      ),subtitle: Column(
        children: answers.map<Widget>((answer){
          final isCorrect=answer==correctAnswer;
          return AnswerItem(answer: answer, isCorrect: isCorrect);
        }).toList(),
      ),),
    );
  }
}


class AnswerItem extends StatelessWidget {
  const AnswerItem({super.key,required this.answer,required this.isCorrect});
  final bool isCorrect;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.6,
      decoration: BoxDecoration(
        color: isCorrect?Colors.green:null,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.all(8),
      child: Text(answer.toString()),
    );
  }
}