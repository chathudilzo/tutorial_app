import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserProfile{
  String uid;
  String displayName;
  List <Map<String,int>> marks;
  List<Map<String,int>> lcqNumber;

  UserProfile({required this.uid,required this.displayName,required this.marks,required this.lcqNumber});

  factory UserProfile.fromMap(Map<String,dynamic>map, String uid){
    final displayName=map['displayName'] as String;
    final marks=(map['marks'] as List<dynamic>)
        .map((item) => (item as Map<String, dynamic>).cast<String, int>())
        .toList();
    final lcqNumber = (map['lcqNumber'] as List<dynamic>)
        .map((item) => (item as Map<String, dynamic>).cast<String, int>())
        .toList();

    return UserProfile(uid: uid, displayName: displayName, marks: marks, lcqNumber: lcqNumber);
  }

}


class ProfileController extends GetxController{
final FirebaseFirestore _firestore=FirebaseFirestore.instance;

Rx<UserProfile?> userProfile=UserProfile(
  uid: '',
   displayName: '',
    marks:[],
     lcqNumber: []
     ).obs;

Future<void> loadUserProfile(String uid)async{
  final profileDoc=await _firestore.collection('profiles').doc(uid).get();
  if (profileDoc.exists){
    userProfile.value=UserProfile.fromMap(profileDoc.data() as Map<String,dynamic>, uid);
  }
}

Future<void> createUserProfile(String uid,String displayName)async{
  try{
    final userDocRef=_firestore.collection('profiles').doc(uid);

    final userDoc=await userDocRef.get();

    if(userDoc.exists){
      loadUserProfile(uid);
    }else{
      final initialUserProfile={
        'displayName': displayName,
        'marks': [
          {'maths': 0},
          {'science': 0},
          {'english': 0},
        ],
        'lcqNumber': [
          {'maths': 0},
          {'science': 0},
          {'english': 0},
        ],
      };
      await userDocRef.set(initialUserProfile);

      userProfile.value=UserProfile(uid: uid, displayName: displayName, marks: [
          {'maths': 0},
          {'science': 0},
          {'english': 0},
        ], lcqNumber:  [
          {'maths': 0},
          {'science': 0},
          {'english': 0},
        ],);
    }
  }catch(error){
    print('Error'+error.toString());
  }
}


}