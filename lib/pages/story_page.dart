import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/controllers/story_controller.dart';

class StoryPage extends StatefulWidget {
   StoryPage({super.key,required this.name});
   final String name;

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
final StoryController storyController=Get.find();
int index=0;
int maxIndex=0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    storyController.fetchStories(widget.name);

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(),
      body: Obx((){
        if(storyController.isLoading.value){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else if(storyController.isEmpty.value){
            return Center(
              child: Text('No stories to show!'),
            );
        }else{
          maxIndex=storyController.stories.length-1;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(storyController.stories[index]['title'],style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(storyController.stories[index]['story'],style: TextStyle(fontSize: 18),),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 170, 199, 8)
                      ),
                        onPressed: (){
                          setState(() {
                            if(index+1<=maxIndex){
                              index++;
                            }
                          });
                      }, child: Text('Next')),
                    ],
                  )
                ],
              ),
            ),
          );
        } 
        
      }),
    );
  }
}