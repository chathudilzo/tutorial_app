import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/controllers/story_controller.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key,required this.name});
  final String name;

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
StoryController storyController=Get.find();
final TextEditingController tytleController=TextEditingController();
final TextEditingController storytextController=TextEditingController();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    

  }
  void addStory()async{
    if(tytleController.text!=''&& storytextController.text!=''){
     final  result=await storyController.uploadStory(widget.name,tytleController.text ,storytextController.text);
     if(result){
      Get.snackbar('Success', '${tytleController.text} Added to the DB');
      tytleController.text='';
      storytextController.text='';
     }
    }else{
      Get.snackbar('Error', 'Field cannot be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
appBar: AppBar(
  title: Text(widget.name,style: TextStyle(color: Colors.white),),
  iconTheme: IconThemeData(color: Colors.white),
  backgroundColor: Colors.black12,
),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/addstory.jpeg'))
                ),
              ),
              SizedBox(height: 10,),
              Text('Add a Story',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: tytleController,
              decoration: InputDecoration(
                
                label: Text('Title'),
                
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                    color: const Color.fromARGB(255, 239, 243, 239)
                  ),
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: storytextController,
              maxLines: 10,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                label: Text('Story'),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 239, 243, 239)
                  ),
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            SizedBox(height:10),
            TextButton(onPressed: (){
              addStory();
            }, 
            style: TextButton.styleFrom(
              backgroundColor: Colors.white
            ),
            child:Text('Add Story'))
            
            
            ]
          ),
        ),
      ),
    );
  }
}