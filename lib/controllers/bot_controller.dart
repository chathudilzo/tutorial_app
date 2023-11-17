
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:tutorial_app/config.dart';



class BotController extends GetxController{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

final GPT_API_KEY=Config.gptApiKey;

RxBool isLoading=false.obs;

Future<CompleteResponse?>? _translateFuture;

RxString selectedCard=''.obs;
RxString botResponse=''.obs;

RxList<String> subjects=<String>[].obs;
RxString selectedSubject='Science'.obs;
RxList<String> titles=<String>[].obs;
RxString selectedTitle='Physics'.obs;
RxList <String> contentList=<String>[].obs;

void onInit(){
  super.onInit();
  fetchSubjects();
  fetchTitles();
  fetchContentList();
  
  
}

void setSelectedCard(String cardText){
  selectedCard.value=cardText;
}


Future<void> fetchSubjects()async{
  try{
    final docSnapshot=await _firestore.collection('GPTlist').doc('lessons').get();

    if(docSnapshot.exists){
      final data=docSnapshot.data() as Map<String,dynamic>;

      subjects.value=data.keys.toList();
      print(subjects.value);
    }
  }catch(error){
    print(error.toString());
  }
}

Future<void>fetchTitles()async{
  try{
    selectedTitle.value='';
    contentList.value=[];
    final docSnapshot=await _firestore.collection('GPTlist').doc('lessons').get();
    if(docSnapshot.exists){
      final data=docSnapshot.data() as Map<String,dynamic>;

      if(selectedSubject.isNotEmpty){
       final lessonsData = data[selectedSubject];

    if (lessonsData is List<dynamic>) {
      titles.value = lessonsData
          .whereType<Map<String, dynamic>>() // Filter only maps
          .map((lesson) => lesson['title'] as String)
          .toList();
    }
    print(titles);
    selectedTitle.value=titles[0];

      }
    }
  }catch(error){
    print(error);
  }
} 

Future<void> fetchContentList()async{
  try{
    final docSnapshot=await _firestore.collection('GPTlist').doc('lessons').get();

    if(docSnapshot.exists){
      final data=docSnapshot.data() as Map<String,dynamic>;

      if(selectedSubject.isNotEmpty && selectedTitle.isNotEmpty){
        final lessondata=data[selectedSubject];
        if(lessondata is List<dynamic>){
          //print(lessondata);
          //print(selectedTitle);
          final selectedLesson=lessondata.firstWhere((lesson) 
          {
            // print(lesson['title']);
            // print(selectedTitle.toString());
            if(lesson['title'].toString()==selectedTitle.toString()){
              return true;
            }else{
              return false;
            }
          }
          
          );
          print(selectedLesson);
          if(selectedLesson!=null){
            contentList.value=(selectedLesson['content']as List<dynamic>).map((content) =>content.toString()).toList();

          }
          
        }

      }
    }
  }catch(error){
    print(error.toString());
  }
}

Future<void> getGPT(String type)async{
  final String res;
try{
  isLoading.value=true;
  botResponse.value='';
  final openAI = OpenAI.instance.build(token: GPT_API_KEY,baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),enableLog: true);
  String? req;
  if(type=='MCQ'){
     req='Generate 10 mcq with answers on $selectedCard';
  }else if(type=='Explain'){
     req='What is $selectedCard';
  }else if(type=='Essay Q'){
     req='Generate Essay questions and answers on $selectedCard';
  }else{
    
     req='Generate New concepts in $selectedCard';

  }
  print(req);
  final request = CompleteText(prompt:req,
                model: TextDavinci3Model(), maxTokens: 200);

 final response = await openAI.onCompletion(request:request);

print(response!.choices[0].toJson().values);
print(response!.choices[0].toJson().values.first);

botResponse.value=response!.choices[0].toJson().values.first;
isLoading.value=false;


}catch(error){
print(error);
isLoading.value=false;
print(isLoading.value);

}
}

  Future<void> uploadLesson()async{
    try{
      final lessonsData = {
        "Mathematics": [
          {"title": "Algebra", "content": ["Introduction to algebraic expressions", "Solving linear equations", "Working with exponents and radicals", "Graphing linear equations", "Systems of linear equations"]},
          {"title": "Geometry", "content": ["Basics of shapes and angles", "Properties of triangles, quadrilaterals, and circles", "Measurement of area and perimeter", "Transformations and symmetry", "Trigonometry and applications"]},
          {"title": "Calculus", "content": ["Introduction to limits and derivatives", "Differentiation of algebraic functions", "Applications of derivatives", "Integration and its applications", "Series and sequences"]},
          {"title": "Probability and Statistics", "content": ["Basic concepts of probability and statistics", "Descriptive statistics and data analysis", "Probability distributions", "Hypothesis testing and statistical inference", "Applications of probability and statistics"]},
          {"title": "Discrete Mathematics", "content": ["Sets, logic, and counting principles", "Graph theory and combinatorics", "Boolean algebra and applications to computer science", "Number theory and cryptography", "Discrete probability and Markov chains"]}
        ],
        "Science": [
          {"title": "Physics", "content": ["Introduction to motion and forces", "Newton's laws of motion", "Work, energy, and power", "Momentum and collisions", "Circular motion and gravitation"]},
          {"title": "Chemistry", "content": ["The structure of matter and the periodic table", "Chemical reactions and stoichiometry", "States of matter and phase changes", "Chemical bonding and molecular structure", "Thermochemistry and kinetics"]},
          {"title": "Biology", "content": ["Basic concepts of life sciences", "Cellular biology and biochemistry", "Genetics and evolution", "Organismal biology and ecology", "Biodiversity and conservation"]},
          {"title": "Earth Science", "content": ["Geology and the Earth's structure", "Plate tectonics and geologic time", "Weather and climate", "Earth's resources and environmental issues", "Astronomy and the universe"]},
          {"title": "Computer Science", "content": ["Introduction to computer science and programming", "Data structures and algorithms", "Computer architecture and organization", "Operating systems and networks", "Artificial intelligence and machine learning"]}
        ],
        "History": [
          {"title": "Ancient Civilizations", "content": ["Exploring ancient cultures", "Mesopotamia and the development of writing", "Ancient Egypt and its pharaohs", "Ancient Greece and its democracy", "Ancient Rome and its empire"]},
          {"title": "World Wars", "content": ["Understanding major global conflicts", "Causes and consequences of World War I", "Rise of Nazi Germany and World War II", "Cold War and its impact on the world", "Contemporary conflicts and global challenges"]},
          {"title": "American History", "content": ["Exploration, colonization, and the American Revolution", "The founding of the United States and its Constitution", "Westward expansion and the Civil War", "Industrialization and the Progressive Era", "Recent American history and contemporary issues"]},
          {"title": "European History", "content": ["Ancient Greece and Rome", "Medieval Europe and the Renaissance", "Age of Exploration and Enlightenment", "French Revolution and Napoleonic Wars", "Industrial Revolution and modern European history"]}
        ]
      };

      await _firestore.collection('GPTlist').doc('lessons').set(lessonsData);

    }catch(error){
      print(error.toString());
    }
  }



}