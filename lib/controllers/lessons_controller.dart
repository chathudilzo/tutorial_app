import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LessonController extends GetxController{
final FirebaseFirestore _firestore=FirebaseFirestore.instance;
RxBool isLoading=true.obs;
RxBool isEmpty=false.obs;

RxList<Map<String,dynamic>> lessons=<Map<String,dynamic>>[].obs;


  Future<bool> uploadLessons(String subject,String lesson,String title,String obj,String intro,String activity,File? imageFile)async{

    try{
      final collectionRef=await _firestore.collection('Lessons');
    final docRef=collectionRef.doc(subject);

    final lessonDoc=await docRef.get();

    if(!lessonDoc.exists){
      await docRef.set({});
    }
    
    String imageUrl=await uploadImage(imageFile);
    

    await docRef.update({'lessons':FieldValue.arrayUnion([{'title':title,'objective':obj,'intro':intro,'lesson':lesson,'activity':activity,'imageUrl':imageUrl}])});

    return true;
    }catch(error){

      Get.snackbar('Error', error.toString());
      return false;
    }
  }



Future<String> uploadImage(File? imageFile)async{
  String imageUrl='';
  try{

    if(imageFile!=null){
      Reference ref=FirebaseStorage.instance.ref().child('images').child(imageFile.path);
      UploadTask uploadTask=ref.putFile(imageFile);
      

      await uploadTask.whenComplete(()async{
        imageUrl=await ref.getDownloadURL();
      });
    }else{
      //ByteData byteData=await rootBundle.load('assets/lesson_placehold.jpeg');
      //List<int> imageData=byteData.buffer.asUint8List();
      Reference defaultImageRef=FirebaseStorage.instance.ref().child('images').child('default+image.jpg');
      imageUrl=await defaultImageRef.getDownloadURL();

    }
  }catch(error){
    Get.snackbar('Error', error.toString());
  }
  return imageUrl;
  
}

  Future<void> fetchLessons(String subject)async{
    try{
      lessons.clear();
      isEmpty.value=false;
      isLoading.value=true;

      final docRef=await _firestore.collection('Lessons').doc(subject);
      final snapShot=await docRef.get();

      if(snapShot.exists){
        lessons.value=(snapShot.data()?['lessons'] as List<dynamic>).map((item)=>Map<String,dynamic>.from(item)).toList();
        isEmpty.value=false;
        isLoading.value=false;
      }else{
        isEmpty.value=true;
        isLoading.value=false;
      }
    }catch(error){
      print(error);
      isEmpty.value=true;
      isLoading.value=false;
    }
    print(lessons);
  }
}