import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/controllers/bot_controller.dart';

class TryMe extends StatefulWidget {
  const TryMe({super.key});

  @override
  State<TryMe> createState() => _TryMeState();
}

class _TryMeState extends State<TryMe> {

final BotController botController=Get.find();

String? selectedType;
String? botResponse;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx((){
              if(botController.subjects.isEmpty){
                return Container();
              }else{
                Set<String> uniqueSubjects=botController.subjects.toSet();
                            
                return DropdownButton<String>(
                  
                  borderRadius: BorderRadius.circular(10),
                  focusColor: Colors.yellow,
                  dropdownColor: Color.fromARGB(174, 4, 24, 114),
                  hint: Text('Select a subject'),
                  value: botController.selectedSubject.value,
                  items: uniqueSubjects.map((subject) {
                    print(subject);
                    return DropdownMenuItem<String>(
                      child: Text(subject,style: TextStyle(color: Colors.white),),
                      value: subject,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      botController.selectedSubject.value = value!;
                      botController.fetchTitles();
                      botController.fetchContentList();
                    });
                    },
                );
              }
            }
            ),
      
            Obx((){
              if(botController.titles.isNotEmpty && botController.selectedTitle.value!='' ){
                Set<String> uniqueTitles=botController.titles.toSet();
                print(uniqueTitles);
                return DropdownButton<String>(
                  focusColor: Color.fromARGB(255, 6, 196, 53),
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Color.fromARGB(146, 178, 8, 184),
                  hint: Text('Select a title'),
                  value: botController.selectedTitle.value,
                  items:uniqueTitles.map((title){
                    return DropdownMenuItem(
                      child: Text(title,style: TextStyle(color: Colors.white),),
                      value: title,);
                  }).toList() , 
                  onChanged:(value){
                    setState(() {
                      botController.selectedTitle.value=value!;
                      botController.fetchContentList();
                    });
                  });
              }else{
                return Container();
              }
            }),
              ],
            ),
            SizedBox(height: 5,),
            SizedBox(height: 5,),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(textAlign:TextAlign.start,'Select a lesson',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
              ],
            ),
            Container(
              
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 33, 33, 34),
                borderRadius: BorderRadius.circular(10)
              ),
              
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx((){
                  if(botController.contentList.isNotEmpty){
                    print(botController.contentList);
                    return ListView.builder(
                      itemCount: botController.contentList.length,
                      itemBuilder:(context,index){
                        String cardText=botController.contentList[index];
                        
                        return Obx((){
                          if(botController.selectedCard.value==cardText){
                            return InkWell(
                            onTap: () {
                              botController.setSelectedCard(cardText);
                            },
                            child: Card(
                              color:Colors.blue,
                              child: Padding(padding: const EdgeInsets.all(8),
                              child: Text(botController.contentList[index]),),
                            ),
                          );
                          }else{
                            return InkWell(
                            onTap: () {
                              botController.setSelectedCard(cardText);
                            },
                            child: Card(
                         
                              child: Padding(padding: const EdgeInsets.all(8),
                              child: Text(botController.contentList[index]),),
                            ),
                          );
                          }
                        }
                           
                        );
                      });
                  }else{
                    return Container();
                  }
                }),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Select option to generate',style: TextStyle(color: Colors.white,fontSize: 16),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildContainer('MCQ', Color.fromARGB(249, 106, 152, 231)),
                buildContainer('Explain',Colors.greenAccent),
                buildContainer('Essay Q',Colors.yellowAccent)
              ],
            ),
            SizedBox(height: 10,),
            
            Obx(
             (){
              if(botController.botResponse.value!=''){
                return Expanded(child: SingleChildScrollView(
                  child: Column(
                  children: [
                    Container(
                      child: Text(botController.botResponse.value,style: TextStyle(color: Colors.white),),
                    )
                  ],
                              ),
                ));
              }else{
                return Container();
              }
             }
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  botController.getGPT(selectedType.toString());
                });
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Color.fromARGB(143, 13, 158, 202),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(child: Text('Go',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
              ),
            ),
          ],
        ),
        
      ),
    );
  }

  Widget buildContainer(String questionType,Color color){
    return GestureDetector(
            onTap: () {
              setState(() {
                selectedType=questionType;
              });
            },
            child: Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Color.fromARGB(255, 77, 136, 184),
                  offset: Offset(1, 3)
                )],
                borderRadius: BorderRadius.circular(10),
              color:selectedType==questionType?color: Colors.grey
              ),
              child: Center(
                child: Text(questionType),
              ),
            ),
          );
  }
}