import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:tutorial_app/controllers/user_controller.dart';

import '../controllers/tutorial_controller.dart';

class QuizBox extends StatefulWidget {
  const QuizBox({super.key,required this.name});

  final String name;

  @override
  State<QuizBox> createState() => _QuizBoxState();
}

class _QuizBoxState extends State<QuizBox> {
  final TutorialController tutorialController=Get.find();
  final ProfileController profileController=Get.find();
  int currentIndex=0;
  TextEditingController userAnswerController=TextEditingController();

String selectedAns='';
String correctAns='';
List<bool> isSelected=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //profileController.loadUserProfile(profileController.userProfile.value!.uid);
    getLastAnswerIndex();
    generateList();

  }

getLastAnswerIndex(){
  profileController.userProfile.value!.lcqNumber.forEach((map){
    final name=widget.name.toLowerCase();
      if(map.containsKey(name)){
        setState(() {
          currentIndex=map[name]!;
          print('CURRENT INDEX at start'+currentIndex.toString());
        });
      }
    });
}

//[{'name':'samith','marks': [{maths: 0}, {science: 25}, {english: 0}, {history: 0}, {ict: 0}, {geography: 0}]}]

void generateList(){
  print('length'+tutorialController.Data.length.toString());
  if(currentIndex<=tutorialController.Data.length-1){
  List<bool> isselected = List.generate(
  tutorialController.Data[currentIndex]['answers'].length, (index) => false,
);


setState(() {
  isSelected=isselected;
});
  }
}

void checkAnswer(){
  print(correctAns.length.toString() +' '+ selectedAns.length.toString());
  print(selectedAns.trim()==correctAns.trim());
  if (selectedAns.trim()==correctAns.trim()){
    profileController.updateSubject(widget.name.toLowerCase());


    setState(() {
              isSelected=[];
            });
              
              getLastAnswerIndex();
              // print('tutorials lenght'+tutorialController.Data.length.toString());
              // print('CURRENT INDEX'+currentIndex.toString());
              if(currentIndex<=tutorialController.Data.length-1){
                print('CURRENT INDEX'+currentIndex.toString());
                generateList();
              }else{
                Get.snackbar('End', 'No more quizes');
              }
setState(() {
  
});
    showDialog(context:context,builder:(context) {
      return GiffyDialog.image(
        Image.network('https://media.tenor.com/qg8K8VOmzJwAAAAi/party-popper-confetti.gif',height: 200,fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(image: AssetImage('assets/correct.jpeg'),fit: BoxFit.cover)
              ),
              
            );
        },
        ),

        title: Text('Answer Correct'),
        content: 
            Container(
              //width: 150,
              //height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                //image: DecorationImage(image: AssetImage('assets/correct.jpeg'),fit: BoxFit.cover)
              ),
              child: Text('Congratulations! Your are Correct.'),
            )
        ,
        actions: [
          TextButton(onPressed: (){
            
            
            Navigator.of(context).pop();
          }, child:Text('Next') )
        ],
      );
    },);
  }else{
    showDialog(context: context, builder:(context){
      return GiffyDialog.image(
        Image.network('https://media.tenor.com/oxG6Jka0LPUAAAAi/machiko-rabbit.gif',height: 200,fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container();
        },),
        title: Text('Incorrect Answer'),
        content: Text('Oooops!'),
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
    return isSelected.isNotEmpty? Center(
      child: Container(
        width: width-20,
        height: height*0.6,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/qzans.jpeg'),fit: BoxFit.cover),
          boxShadow: [BoxShadow(
            blurRadius: 7,
    
          )],
          borderRadius: BorderRadius.circular(10),
          //linear LinearGradient(colors: [Color.fromARGB(255, 45, 49, 51),Color.fromARGB(255, 93, 96, 99)])
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Q'+tutorialController.Data[currentIndex]['questionNumber'].toString()+'/ ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                Container(
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(221, 31, 30, 30)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tutorialController.Data[currentIndex]['question'],style: TextStyle(color: const Color.fromARGB(255, 252, 251, 249),fontSize: 25),),
                  )),
                SizedBox(
                  
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
                SizedBox(height: 10,),
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
      ),
    ):Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage('https://media.tenor.com/eaTvhJLzFBsAAAAi/%E3%82%8F%E3%83%BC%E3%81%84-%E5%AC%89%E3%81%97%E3%81%84%E3%81%AA.gif',
            
            ),fit: BoxFit.cover)
          ),
          child: Text(
            textAlign:TextAlign.center,
            'You have completed all the quizes in this subject!',style: TextStyle(
            
            fontSize: 25,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}