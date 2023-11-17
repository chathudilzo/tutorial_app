import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StoryController extends GetxController{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  RxList<Map<String,dynamic>> stories=<Map<String,dynamic>>[].obs;
  RxBool isLoading=true.obs;
  RxBool isEmpty=false.obs;




  




  Future<void> fetchStories(String name)async{
    try{
      stories.clear();
      isLoading.value=true;
      isEmpty.value=false;

      final docRef=await _firestore.collection('stories').doc(name);
      final docSnapshot=await docRef.get();

      if(docSnapshot.exists){
        stories.value=(docSnapshot.data()?['stories'] as List<dynamic>).map((item)=>Map<String,dynamic>.from(item)).toList();
        isEmpty.value=false;
        isLoading.value=false;
      }else{
        isEmpty.value=true;
        isLoading.value=false;
      }
    }catch(error){
      isEmpty.value=true;
      isLoading.value=false;
      print(error);
    }
  }


  Future<bool> uploadStory(String storyType,String title,String story)async{
    try{
      final collectionRef=_firestore.collection('stories');
      final docRef=collectionRef.doc(storyType);

      final storyDoc=await docRef.get();
      print(storyDoc);
      if(!storyDoc.exists){
        await docRef.set({});
      }

      await docRef.update({'stories':FieldValue.arrayUnion([{'title':title,'story':story}])});
      return true;
    }catch(error){
      print(error.toString());
      Get.snackbar('Error', error.toString());
      return false;
    }
  }
}