import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutorial_app/components/quiz_button.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

   final List<String> imagePaths=['assets/stypes/bedtime.jpeg','assets/stypes/fiction.jpeg','assets/stypes/hist.jpeg'];


final user=FirebaseAuth.instance.currentUser!;

void signUserOut()async{
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
}
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(26, 165, 164, 164),
      appBar: AppBar(actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],),
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: width*0.8,
                        height: 200,
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
                    );
                  },);
                }).toList(), 
                options: CarouselOptions(
                  autoPlay: true,
                  height: 200)),
              ),
              SizedBox(height: 10,),
              Text('Take a Quiz',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              Column(
                children: [
                  QuizButton(name: 'Science',color: Color.fromARGB(255, 25, 197, 240),),
                  QuizButton(name:'History',color: Color.fromARGB(255, 25, 197, 240),),
                  QuizButton(name:'English',color: Color.fromARGB(255, 25, 197, 240),)
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}