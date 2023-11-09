import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(image: AssetImage('assets/logo.jpeg'),fit: BoxFit.cover)
                ),
              ),
              SizedBox(height: 20,),
                            Text('Admin Panel',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                    color: Colors.white10,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(2, 2)
                  )],
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [const Color.fromARGB(255, 8, 45, 110),Color.fromARGB(255, 118, 11, 189),]),
                  color: const Color.fromARGB(255, 102, 102, 101)
                ),
                width: width,
                child:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          children: [ Text('Add Questions',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),],
                    
                        ),
                    ),
                  
                
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                    color: Colors.white10,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(2, 2)
                  )],
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [Color.fromARGB(255, 118, 11, 189),const Color.fromARGB(255, 8, 45, 110)]),
                  color: const Color.fromARGB(255, 102, 102, 101)
                ),
                width: width,
                
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                     
                      
                      SizedBox(height: 10,),
                      MyButton(name: 'Science'),
                      SizedBox(height: 10,),
                      MyButton(name: 'Maths'),
                      SizedBox(height: 10,),
                      MyButton(name: 'English')
                
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                    color: Colors.white10,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(2, 2)
                  )],
                  borderRadius: BorderRadius.circular(10),
                  gradient:LinearGradient(colors: [Color.fromARGB(255, 182, 126, 5),Color.fromARGB(255, 189, 11, 109),]),
                  color: const Color.fromARGB(255, 102, 102, 101)
                ),
                width: width,
                child: 
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          children: [ Text('View Questions',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),],
                    
                        ),
                    ),
                  
                
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                    color: Colors.white10,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(2, 2)
                  )],
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [Color.fromARGB(255, 189, 11, 109),Color.fromARGB(255, 182, 126, 5)]),
                  color: const Color.fromARGB(255, 102, 102, 101)
                ),
                width: width,
                
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                     
                      
                      SizedBox(height: 10,),
                      ViewButton(name: 'Science'),
                      SizedBox(height: 10,),
                      ViewButton(name: 'Maths'),
                      SizedBox(height: 10,),
                      ViewButton(name: 'English')
                
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
                        width: 200,
                        height: 50,
                        
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(
                            color: const Color.fromARGB(255, 108, 108, 109),
                            blurRadius: 1,
                            spreadRadius: 1,offset: Offset(2, 1)
                          )],
                          gradient: LinearGradient(colors: [Color.fromARGB(255, 15, 167, 194),Color.fromARGB(255, 4, 48, 88)]),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text('Add '+name,style: TextStyle(color: Colors.white,fontSize: 20),),
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
                        width: 200,
                        height: 50,
                        
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(
                            color: const Color.fromARGB(255, 108, 108, 109),
                            blurRadius: 1,
                            spreadRadius: 1,offset: Offset(2, 1)
                          )],
                          gradient: LinearGradient(colors: [Color.fromARGB(255, 15, 194, 60),Color.fromARGB(255, 25, 75, 3)]),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text('View '+name,style: TextStyle(color: Colors.white,fontSize: 20),),
                        ),
                      ),
    );
  }
}