import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/controllers/user_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
final ProfileController profileController=Get.find();



  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;

    return  Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.greenAccent,Colors.blueAccent]),
                        borderRadius: BorderRadius.circular(100)
                        
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(image: AssetImage('assets/usericn.jpg'),fit: BoxFit.cover,),
                        )
                      ),
                      ),
                  ),
                  SizedBox(height: 10,),
                  Text(profileController.userProfile.value!.displayName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      
                  SizedBox(height: 20,),
      
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MarksColumn(title: 'Maths', subject: 'maths', index: 0),
                          MarksColumn(title: 'Science', subject: 'science', index: 1),
                          MarksColumn(title: 'English', subject: 'english', index: 2),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MarksColumn(title: 'History', subject: 'history', index: 3),
                          MarksColumn(title: 'ICT', subject: 'ict', index: 4),
                          MarksColumn(title: 'Geography', subject: 'geography', index: 5),
                        ],
                      ),
                    ],
                  )
                ],
        
              ),
      )
        
      
    );
  }
}


class MarksColumn extends StatefulWidget {
  const MarksColumn({super.key,required this.title,required this.subject,required this.index});

  final String title;
  final String subject;
  final int index;

  @override
  State<MarksColumn> createState() => _MarksColumnState();
}

class _MarksColumnState extends State<MarksColumn> {
  final ProfileController profileController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.title,style: TextStyle(color: Color.fromARGB(225, 48, 47, 47),fontSize: 20,fontWeight: FontWeight.bold),),
      
        SizedBox(height: 5,),
      
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [const Color.fromARGB(255, 26, 25, 25),Color.fromARGB(255, 4, 90, 105)]),
            //color:widget.subject=='maths'?Color.fromARGB(255, 31, 241, 101):widget.subject=='science'?Colors.amberAccent:Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(
              blurRadius: 1,spreadRadius: 3,
              offset: Offset(2, 3)
            )]
          ),
          child: Center(
            child:Text(profileController.userProfile.value!.marks[widget.index][widget.subject].toString()+'XP',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 78, 77, 77)),),
          ),
        )
      ],
    );
  }
}