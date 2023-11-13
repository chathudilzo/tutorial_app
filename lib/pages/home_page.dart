import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutorial_app/components/lesson_button.dart';
import 'package:tutorial_app/components/quiz_button.dart';
import 'package:tutorial_app/controllers/user_controller.dart';
import 'package:tutorial_app/pages/admin_home_page.dart';
import 'package:tutorial_app/pages/profile_page.dart';
import 'package:tutorial_app/pages/story_page.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

   final List<String> imagePaths=['assets/stypes/bedtime.jpeg','assets/stypes/fiction.jpeg','assets/stypes/hist.jpeg'];
final ProfileController profileController=Get.find();

final user=FirebaseAuth.instance.currentUser!;

void signUserOut()async{
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
  //ProfileController().resetUserProfile();
}
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(26, 165, 164, 164),
      appBar: AppBar(actions: [
        if(profileController.userProfile.value!.role=='admin')
        IconButton(onPressed: (){
          Get.to(AdminHomePage());
        }, icon: Icon(Icons.admin_panel_settings))

        ,
        IconButton(onPressed: (){
        Get.to(ProfilePage());
      }, icon: Icon(Icons.person)),IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image(image: AssetImage('assets/logo.jpeg')),
                ),
              ),
        
              Row(
                children: [
                  Icon(Icons.book_rounded,color: Color.fromARGB(255, 128, 223, 21),),
                  Text('Story World',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: CarouselSlider(items: imagePaths.map((i){
                  
                  return Builder(builder: (BuildContext context){
                    return GestureDetector(
                      onTap: () {
                        String name='Children';
                        if(i=='assets/stypes/bedtime.jpeg'){
                          name='Children';
                        } else if (i == 'assets/stypes/fiction.jpeg') {
                          name = 'Fiction';
                        } else if (i == 'assets/stypes/hist.jpeg') {
                          name = 'Historical';
                        }
                        Get.to(StoryPage(name:name));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: width*0.8,
                          height: 150,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7,
                                
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: AssetImage(i),fit:BoxFit.cover),
                            
                          ),
                          child: Image(image:AssetImage(i))
                        ),
                      ),
                    );
                  },);
                }).toList(), 
                options: CarouselOptions(
                  autoPlay: true,
                  height: 150)),
              ),
              SizedBox(height: 10,),
              Text('Take a Quiz',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      QuizButton(name: 'Science',color: Color.fromARGB(144, 103, 219, 200),),
                      QuizButton(name:'History',color: Color.fromARGB(144, 103, 219, 200),),
                      QuizButton(name:'English',color: Color.fromARGB(144, 103, 219, 200),)
                    ],
                  ),
                   Column(
                    children: [
                      QuizButton(name: 'Maths',color: Color.fromARGB(144, 103, 219, 200),),
                      QuizButton(name:'ICT',color: Color.fromARGB(144, 103, 219, 200),),
                      QuizButton(name:'Geography',color: Color.fromARGB(144, 103, 219, 200),)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text('Lessons',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      LessonButton(subject: 'Science'),
                      SizedBox(height: 10,),
                      LessonButton(subject: 'Maths'),
                      SizedBox(height: 10,),
                      LessonButton(subject: 'History'),
                      SizedBox(height: 10,),
                    ],
                  ),
                  Column(
                    children: [
                      LessonButton(subject: 'English'),
                      SizedBox(height: 10,),
                      LessonButton(subject: 'Health'),
                      SizedBox(height: 10,),
                      LessonButton(subject: 'ICT'),
                      SizedBox(height: 10,),
                    ],
                  ),
                  Column(
                    children: [
                      LessonButton(subject: 'Geography'),
                      SizedBox(height: 10,),
                      LessonButton(subject: 'Music'),
                      SizedBox(height: 10,),
                      LessonButton(subject: 'Dancing'),
                      SizedBox(height: 10,),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}