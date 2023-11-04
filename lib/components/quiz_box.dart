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

String selectedAns='';
String correctAns='';
List<bool> isSelected=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateList();

  }

void generateList(){
  List<bool> isselected = List.generate(
  tutorialController.Data[currentIndex]['answers'].length, (index) => false,
);

setState(() {
  isSelected=isselected;
});
}

void checkAnswer(){
  if (selectedAns==correctAns){
    showDialog(context:context,builder:(context) {
      return AlertDialog(
        title: Text('Answer Correct'),
        content: 
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(image: AssetImage('assets/correct.jpeg'),fit: BoxFit.cover)
              ),
            )
        ,
        actions: [
          TextButton(onPressed: (){
            setState(() {
              currentIndex++;
              generateList();
            });
            Navigator.of(context).pop();
          }, child:Text('Next') )
        ],
      );
    },);
  }else{
    showDialog(context: context, builder:(context){
      return AlertDialog(
        title: Text('Incorrect Answer'),
        content: Text('Try again'),
        actions: [
          TextButton(onPressed:() {
            Navigator.of(context).pop();
          }, child:Text('Try again'))
        ],
      );
    });
  }
}

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        width: width-20,
        height: height*0.6,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            blurRadius: 7,
    
          )],
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [Color.fromARGB(255, 45, 49, 51),Color.fromARGB(255, 93, 96, 99)])
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Q'+tutorialController.Data[currentIndex]['questionNumber']+'/ ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              Text(tutorialController.Data[currentIndex]['question'],style: TextStyle(color: const Color.fromARGB(255, 252, 251, 249),fontSize: 25),),
              Container(
                
                width: width,
                height:300,
                child: ListView.builder(
                  itemCount: tutorialController.Data[currentIndex]['answers'].length,
                  itemBuilder:(context,index){
                    final item=tutorialController.Data[currentIndex]['answers'][index];
                    if (item is String){
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected[index]) {
                              // If the item was already selected, deselect it
                              isSelected[index] = false;
                            } else {
                              // If the item was not selected, select it and deselect others
                              for (int i = 0; i < isSelected.length; i++) {
                                isSelected[i] = false;
                              }
                              isSelected[index] = true;
                            }

                            correctAns=tutorialController.Data[currentIndex]['answer'];
                            selectedAns=item;
                          });
                        },
                        child: Container(decoration: BoxDecoration(
                          boxShadow: [BoxShadow(
                            blurRadius: 7

                          )],
                          color:isSelected[index]? Colors.grey[200]:Color.fromARGB(255, 100, 98, 94),
                          borderRadius: BorderRadius.circular(10),
                          border:Border.all(color: Color.fromARGB(255, 6, 122, 143),width: 2)
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        child: Text(index.toString()+'). '+item),
                        ),
                      );
                    }
                    return Container();
                  }),
              ),

              GestureDetector(
                onTap: () {
                  checkAnswer();
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:BorderRadius.circular(10),
                    boxShadow: [BoxShadow(blurRadius: 7)]
                    
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Submit',style: TextStyle(
                        color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ),
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