import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TutorialController extends GetxController{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  RxList<Map<String,dynamic>> Data=<Map<String,dynamic>>[].obs;
  RxBool isLoading=true.obs;

  Future<void> fetchData(String name)async{
    try{
      isLoading.value=true;
      final quarySnapshot=await _firestore.collection('tutorials').get();
      final docs=quarySnapshot.docs.where((doc)=>doc.data()['subject']==name).toList();

      if(docs.isNotEmpty){
        
        Data.value=(docs.first.data()['q&a'] as List<dynamic>).map((item){
          return Map<String,dynamic>.from(item);
        }).toList();
        isLoading.value=false;
        print(Data);

      }
    }catch(error){
      isLoading.value=false;
      print(error);
    }
  }


  Future<bool> addNewQuestion(String question,String answer,List<String> answers,String name)async{
    try{
      
      final quarySnapshot=await _firestore.collection('tutorials').get();
      final matchingDoc=quarySnapshot.docs.firstWhere((doc)=>doc.data()['subject']==name);

      if(matchingDoc.exists){
        final qAndaList=matchingDoc.data()['q&a'] as List<dynamic>;
        final questionNumber=qAndaList.length;

        final newQandA={
        'question':question,
        'answer':answer,
        'answers':answers,
        'questionNumber':questionNumber
      };
      await _firestore.collection('tutorials').doc(matchingDoc.id).update({'q&a':FieldValue.arrayUnion([newQandA])});
      Get.snackbar('Success', 'Question Successfully Added!');
      return true;
      }else{
        Get.snackbar('Error', 'Document not found!');
        return false;
      }
      
      //await _firestore.collection('tutorials').get();
    }catch(error){
      Get.snackbar('Error', error.toString());
      return false;
    }
  }
}