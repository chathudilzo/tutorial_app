import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/pages/add_lessons_page.dart';
import 'package:tutorial_app/pages/add_story_page.dart';
import 'package:tutorial_app/pages/admin_page.dart';
import 'package:tutorial_app/pages/view_questio_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black12,
      ),
      body: Container(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
          
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(image: AssetImage('assets/logo.jpeg'),fit: BoxFit.cover)
                  ),
                ),
                const SizedBox(height: 20,),
                              const Text('Admin Panel',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(
                      color: Colors.white10,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(2, 2)
                    )],
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(colors: [Color.fromARGB(255, 8, 45, 110),Color.fromARGB(255, 118, 11, 189),]),
                    color: const Color.fromARGB(255, 102, 102, 101)
                  ),
                  width: width,
                  child:
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                            children: [ Text('Add Questions',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),],
                      
                          ),
                      ),
                    
                  
                ),
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(
                      color: Colors.white10,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(2, 2)
                    )],
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(colors: [Color.fromARGB(255, 118, 11, 189),Color.fromARGB(255, 8, 45, 110)]),
                    color: const Color.fromARGB(255, 102, 102, 101)
                  ),
                  width: width,
                  
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                           
                            
                            SizedBox(height: 10,),
                            MyButton(name: 'Science'),
                            SizedBox(height: 10,),
                            MyButton(name: 'Maths'),
                            SizedBox(height: 10,),
                            MyButton(name: 'English')
                  
                          ],
                        ),
                        Column(
                          children: [
                           
                            
                            SizedBox(height: 10,),
                            MyButton(name: 'History'),
                            SizedBox(height: 10,),
                            MyButton(name: 'ICT'),
                            SizedBox(height: 10,),
                            MyButton(name: 'Geography')
                  
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(
                      color: Colors.white10,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(2, 2)
                    )],
                    borderRadius: BorderRadius.circular(10),
                    gradient:const LinearGradient(colors: [Color.fromARGB(255, 182, 126, 5),Color.fromARGB(255, 189, 11, 109),]),
                    color: const Color.fromARGB(255, 102, 102, 101)
                  ),
                  width: width,
                  child: 
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                            children: [ Text('View Questions',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),],
                      
                          ),
                      ),
                    
                  
                ),
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(
                      color: Colors.white10,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(2, 2)
                    )],
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(colors: [Color.fromARGB(255, 189, 11, 109),Color.fromARGB(255, 182, 126, 5)]),
                    color: const Color.fromARGB(255, 102, 102, 101)
                  ),
                  width: width,
                  
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                           
                            
                            SizedBox(height: 10,),
                            ViewButton(name: 'Science'),
                            SizedBox(height: 10,),
                            ViewButton(name: 'Maths'),
                            SizedBox(height: 10,),
                            ViewButton(name: 'English')
                  
                          ],
                        ), Column(
                          children: [
                           
                            
                            SizedBox(height: 10,),
                            ViewButton(name: 'History'),
                            SizedBox(height: 10,),
                            ViewButton(name: 'ICT'),
                            SizedBox(height: 10,),
                            ViewButton(name: 'Geography')
                  
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(
                      color: Colors.white10,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(2, 2)
                    )],
                    borderRadius: BorderRadius.circular(10),
                    gradient:const LinearGradient(colors: [Color.fromARGB(255, 119, 3, 94),Color.fromARGB(255, 9, 3, 95),]),
                    color: const Color.fromARGB(255, 102, 102, 101)
                  ),
                  width: width,
                  child: 
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                            children: [ Text('Add Stories',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),],
                      
                          ),
                      ),
                    
                  
                ),
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(
                      color: Colors.white10,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(2, 2)
                    )],
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(colors:  [Color.fromARGB(255, 9, 3, 95),Color.fromARGB(255, 119, 3, 94),]),
                    color: const Color.fromARGB(255, 102, 102, 101)
                  ),
                  width: width,
                  
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                       
                        
                        SizedBox(height: 10,),
                        StoryButton(name: 'Fiction',icon: Icon(Icons.sunny_snowing,color: Colors.white,),),
                        SizedBox(height: 10,),
                        StoryButton(name: 'Children',icon: Icon(Icons.baby_changing_station,color: Colors.white,),),
                        SizedBox(height: 10,),
                        StoryButton(name: 'Historical',icon: Icon(Icons.history,color: Colors.white,),)
                  
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(
                      color: Colors.white10,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(2, 2)
                    )],
                    borderRadius: BorderRadius.circular(10),
                    gradient:const LinearGradient(colors: [Color.fromARGB(255, 42, 43, 42),Color.fromARGB(255, 20, 20, 17),]),
                    color: const Color.fromARGB(255, 102, 102, 101)
                  ),
                  width: width,
                  child: 
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                            children: [ Text('Add Lessons',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),],
                      
                          ),
                      ),
                    
                  
                ),
                
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(
                      color: Colors.white10,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(2, 2)
                    )],
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(colors: [Color.fromARGB(255, 20, 20, 17),Color.fromARGB(255, 42, 43, 42),]),
                    color: const Color.fromARGB(255, 102, 102, 101)
                  ),
                  width: width,
                  
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                           
                            
                            SizedBox(height: 10,),
                            AddLesson(subject: 'Science'),
                            SizedBox(height: 10,),
                            AddLesson(subject: 'Maths'),
                            SizedBox(height: 10,),
                            AddLesson(subject: 'English')
                  
                          ],
                        ), Column(
                          children: [
                           
                            
                            SizedBox(height: 10,),
                            AddLesson(subject: 'History'),
                            SizedBox(height: 10,),
                            AddLesson(subject: 'ICT'),
                            SizedBox(height: 10,),
                            AddLesson(subject: 'Geography')
                  
                          ],
                        ),
                        Column(
                          children: [
                           
                            
                            SizedBox(height: 10,),
                            AddLesson(subject: 'Health'),
                            SizedBox(height: 10,),
                            AddLesson(subject: 'Music'),
                            SizedBox(height: 10,),
                            AddLesson(subject: 'Dancing')
                  
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key,required this.name});

final String name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(AddQuestionPage(name:name));
      },
      child: Container(
                        width: 110,
                        height: 40,
                        
                        decoration: BoxDecoration(
                          boxShadow: const [BoxShadow(
                            color: Color.fromARGB(255, 42, 42, 43),
                            blurRadius: 1,
                            
                            spreadRadius: 3,offset: Offset(1, 4)
                          )],
                          gradient: const LinearGradient(colors: [Color.fromARGB(255, 15, 167, 194),Color.fromARGB(255, 4, 48, 88)]),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text('$name',style: const TextStyle(color: Colors.white,fontSize: 16),),
                        ),
                      ),
    );
  }
}

class ViewButton extends StatelessWidget {
  const ViewButton({super.key,required this.name});

final String name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ViewQuestionPage(name:name));
      },
      child: Container(
                        width: 110,
                        height: 40,
                        
                        decoration: BoxDecoration(
                          boxShadow: const [BoxShadow(
                            color: Color.fromARGB(255, 38, 38, 39),
                            blurRadius: 3,
                            spreadRadius: 3,offset: Offset(1, 4)
                          )],
                          gradient: const LinearGradient(colors: [Color.fromARGB(255, 126, 8, 126),Color.fromARGB(255, 7, 148, 167)]),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text('$name',style: const TextStyle(color: Colors.white,fontSize: 16),),
                        ),
                      ),
    );
  }
}


class StoryButton extends StatelessWidget {
  const StoryButton({super.key,required this.name,required this.icon});
  final String name;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(AddStoryPage(name:name));
      },
      child: Container(
        width: 130,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(2, 5)
          )],
          gradient: LinearGradient(colors: [Colors.black,Color.fromARGB(255, 23, 4, 110)])
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              icon,
              SizedBox(width: 10,),
              Text(name,style: TextStyle(color: Colors.white,fontSize: 18),)
            ],
          ),
        ),
      ),
    );
  }
}


class AddLesson extends StatelessWidget {
  const AddLesson({super.key,required this.subject});
  final String subject;

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
      onTap: () {
        Get.to(AddLessonsPage(subject:subject));
      },
      child: Container(
                        width: 110,
                        height: 40,
                        
                        decoration: BoxDecoration(
                          boxShadow: const [BoxShadow(
                            color: Color.fromARGB(255, 38, 38, 39),
                            blurRadius: 3,
                            spreadRadius: 3,offset: Offset(1, 4)
                          )],
                          gradient: const LinearGradient(colors: [Color.fromARGB(255, 3, 0, 3),Color.fromARGB(255, 7, 148, 167)]),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text('$subject',style: const TextStyle(color: Colors.white,fontSize: 16),),
                        ),
                      ),
    );
  }
}