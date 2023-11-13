import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TutorialController extends GetxController{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  RxList<Map<String,dynamic>> Data=<Map<String,dynamic>>[].obs;
  RxBool isLoading=true.obs;
  RxBool isEmpty=false.obs;

  Future<void> fetchData(String name)async{
    try{

      Data.clear();
      isLoading.value=true;
      isEmpty.value=false;
      final docRef=await _firestore.collection('tutorials').doc(name);

      final docSnapshot=await docRef.get();

      if(docSnapshot.exists){
        
         Data.value = (docSnapshot.data()?['q&a'] as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
        isLoading.value=false;
        print(Data);
        isEmpty.value=false;

      }else{
        isEmpty.value=true;
        isLoading.value=false;
      }
        
        
      
      
    }catch(error){
       print(error);
      isLoading.value=false;
      isEmpty.value=true;
     
    }
  }


  Future<bool> addNewQuestion(String question,String answer,List<String> answers,String name)async{
    try{
      
      final collectionRef=_firestore.collection('tutorials');
      final docRef=collectionRef.doc(name);

      final quizDoc=await docRef.get();
      int questionNumber=1;
       
      if(!quizDoc.exists){
        await docRef.set({});
       
      }else{
        final qAndalist=quizDoc.data()?['q&a'] as List<dynamic>;
        questionNumber=qAndalist.length+1;
      }

      await docRef.update({'q&a':FieldValue.arrayUnion([{'question':question,
        'answer':answer,
        'answers':answers,
        'questionNumber':questionNumber}])});

      Get.snackbar('Success','Successfully added the question');
      return true;

      //await _firestore.collection('tutorials').get();
    }catch(error){
      
      Get.snackbar('Error', error.toString());
      return false;
    }
  }
}