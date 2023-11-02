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
}