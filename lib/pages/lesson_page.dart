import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/controllers/lessons_controller.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key,required this.subject});
  final String subject;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final LessonController lessonController=Get.find();
int index=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lessonController.fetchLessons(widget.subject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx((){
        if(lessonController.isLoading.value){
          return Center(child: CircularProgressIndicator());
        }else if(lessonController.isEmpty.value){
          return Center(
            child: Text('No lessons yet!'),
          );
        }else{
          return TutorialBox(index: index,controller: lessonController,);
        }
      }),
    );
  }
}

class TutorialBox extends StatefulWidget {
   TutorialBox({super.key,required this.index,required this.controller});
final LessonController controller;
  final int index;

  @override
  State<TutorialBox> createState() => _TutorialBoxState();
}

class _TutorialBoxState extends State<TutorialBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                    color: Color.fromARGB(255, 3, 30, 61),
                    width: 3
                  ))
                ),
                child: Center(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.book_online_rounded,color: Colors.orange,size: 50,),
                    Expanded(
                      child: Text(
                        
                        widget.controller.lessons[0]['title'],style: TextStyle(
                          
                          color: const Color.fromARGB(255, 39, 39, 41),fontSize: 24,fontWeight: FontWeight.bold),),
                    ),
                  ],
                )),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(97, 193, 206, 9)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Objective',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),),
                
                      Text('* '+widget.controller.lessons[widget.index]['objective']),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Image.network(
                
                widget.controller.lessons[widget.index]['imageUrl'],
                loadingBuilder: (BuildContext context,Widget child,ImageChunkEvent? loadingProgress){
                  if(loadingProgress==null){
                    return child;
                  }else{
                    return Center(
                      child: CircularProgressIndicator(value:loadingProgress.expectedTotalBytes!=null?loadingProgress.cumulativeBytesLoaded/loadingProgress.expectedTotalBytes!:null),
                    );
                  }
                },errorBuilder: (BuildContext context,Object exception,StackTrace? stackTrace) {
                  return Center(
                    child: Text('Faild to load the image'),
                  );

                },
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(96, 9, 176, 206)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Introduction',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),),
                
                      Text(widget.controller.lessons[widget.index]['intro']),
                    ],
                  ),
                ),
              ),
               SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(95, 223, 23, 163)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Content',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),),
                
                      Text(widget.controller.lessons[widget.index]['lesson']),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(166, 203, 238, 3)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Activity',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),),
                
                      Text(widget.controller.lessons[widget.index]['activity']),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}