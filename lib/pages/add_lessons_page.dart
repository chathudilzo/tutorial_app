import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tutorial_app/controllers/lessons_controller.dart';

class AddLessonsPage extends StatefulWidget {
  const AddLessonsPage({super.key,required this.subject});
  final String subject;
 

  @override
  State<AddLessonsPage> createState() => _AddLessonsPageState();
}

class _AddLessonsPageState extends State<AddLessonsPage> {
  final LessonController lessonController=Get.find();
  final TextEditingController titleController=TextEditingController();
  final TextEditingController contentController=TextEditingController();
  final TextEditingController objController=TextEditingController();
  final TextEditingController introController=TextEditingController();
  final TextEditingController activityController=TextEditingController();

 File? imageFile;

void uploadLesson()async{
  if(titleController.text!=''&& contentController.text!=''&&
  objController.text!=''&&introController.text!=''&&activityController.text!=''
  ){
    final result=await lessonController.uploadLessons(widget.subject, contentController.text, titleController.text,objController.text,introController.text,activityController.text,imageFile);

    if(result){
      Get.snackbar('Success', 'Lesson Successfully Uploaded!');
      titleController.text='';
      contentController.text='';
      objController.text='';
      introController.text='';
      activityController.text='';
      imageFile=null;
    }else{
      Get.snackbar('Error', 'Something went wrong!');
    }

  }else{
    Get.snackbar('Error', 'Fields cannot be empty!');
  }
}

Future<void> uploadImage()async{
  final picker=ImagePicker();

  final pickedFile=await picker.pickImage(source: ImageSource.gallery);

  if(pickedFile!=null){
     setState(() {
       imageFile=File(pickedFile.path);
     });

}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 4, 19),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 23, 24),
      ),
      body: Padding(padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(image: AssetImage('assets/lessons1.jpeg'),fit: BoxFit.contain)
                ),
              ),
              
            ),
            SizedBox(height: 20,),
            Text('Add a Lesson',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
            SizedBox(height: 20,),

            Text("*** Add '\\n' to break the rules ***",style: TextStyle(color: Colors.white,fontSize: 16),),
            TextField(style: TextStyle(color: Colors.white),
              
              controller: titleController,
              decoration: InputDecoration(
                
                label: Text('Title',),
                enabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 155, 214, 16)
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
         
            SizedBox(height: 20,),
            TextField(style: TextStyle(color: Colors.white),
              
              controller: objController,
              decoration: InputDecoration(
                label: Text('Objective'),
                enabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 155, 214, 16)
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(style: TextStyle(color: Colors.white),
              
              controller: introController,
              maxLines: 3,
              decoration: InputDecoration(
                label: Text('Introduction'),
                enabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 155, 214, 16)
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            
            SizedBox(
              height: 20,
            ),
            TextField(style: TextStyle(color: Colors.white),
              
              controller: contentController,
              maxLines: 10,
              decoration: InputDecoration(
                label: Text('Lesson'),
                enabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 155, 214, 16)
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            
            SizedBox(
              height: 20,
            ),
            TextField(style: TextStyle(color: Colors.white),
              
              controller: activityController,
              maxLines: 3,
              decoration: InputDecoration(
                label: Text('Activity'),
                enabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 155, 214, 16)
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  
                  style:TextButton.styleFrom(
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    backgroundColor: Colors.blueAccent
                  ) ,
                  onPressed: (){
                    uploadImage();
                }, child: 
                Row(
                  children: [
                    Icon(Icons.upload,color: Colors.yellow,),
                    SizedBox(width: 3,),
                    Text('Image',
                    style: TextStyle(color: Colors.white,fontSize: 14),),
                  ],
                )),
              ],
            ),

            SizedBox(height: 20,),
            SizedBox(
              width: 100,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white
                ),
                onPressed: (){
                  uploadLesson();
              }, child: Center(
                child: Text('Submit'),
              )),
            )
            
          ],
        ),
      ),),
    );
  }
}