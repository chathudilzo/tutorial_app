
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
bool isPlaying=false;




 FlutterTts flutterTts=FlutterTts();

  Future<void> configureTts()async{
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setVolume(1.0);
  }

  void speakText(String text)async{
    await flutterTts.speak(text);
    setState(() {
      isPlaying=true;
    });
  
  }

  void stopSpeaking()async{
  await flutterTts.stop();
  setState(() {
    isPlaying=false;
  });
  }




@override
  void dispose() {
     //TODO: implement dispose
    super.dispose();
    flutterTts.stop();
  }



@override
  void initState() {
     //TODO: implement initState
    super.initState();
    storyController.fetchStories(widget.name);
    configureTts();

  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/storytell.jpeg'),fit: BoxFit.fitWidth)
        ),
        child: Obx((){
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
                    Row(
                      children: [
                         IconButton(onPressed: (){
                           !isPlaying?speakText(storyController.stories[index]['story']):stopSpeaking();
                         }, icon: !isPlaying?Icon(Icons.play_circle_outline,color: Colors.blue,size: 50,):Icon(Icons.stop_circle_outlined,color: Color.fromARGB(255, 179, 10, 5),size: 50,)),
                       
                      ],
                    ),
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
      ),
    );
  }
}