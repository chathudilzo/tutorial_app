import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserProfile{
  String role;
  String uid;
  String displayName;
  List <Map<String,int>> marks;
  List<Map<String,int>> lcqNumber;

  UserProfile({required this.role, required this.uid,required this.displayName,required this.marks,required this.lcqNumber});

  factory UserProfile.fromMap(Map<String,dynamic>map, String uid){
    final role=map['role'] as String;
    final displayName=map['displayName'] as String;
    final marks=(map['marks'] as List<dynamic>)
        .map((item) => (item as Map<String, dynamic>).cast<String, int>())
        .toList();
    final lcqNumber = (map['lcqNumber'] as List<dynamic>)
        .map((item) => (item as Map<String, dynamic>).cast<String, int>())
        .toList();

    return UserProfile(role: role, uid: uid, displayName: displayName, marks: marks, lcqNumber: lcqNumber);
  }

}

class ProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool isLoading = true.obs;

  Rx<UserProfile?> userProfile = UserProfile(
    role: '',
    uid: '',
    displayName: '',
    marks: [],
    lcqNumber: [],
  ).obs;

void onInit(){
  super.onInit();
  final user=FirebaseAuth.instance.currentUser;
  if(user!=null){
    loadUserProfile(user.uid);
  }
}

void resetUserProfile() {
    userProfile.value = UserProfile(
      role: '',
      uid: '',
      displayName: '',
      marks: [],
      lcqNumber: [],
    );
  }

void updateSubject(String subject)async {
  print('USER PROFILE MARKS: '+userProfile.value!.marks.toString());
  userProfile.value!.marks.forEach((map) {
    print(map);
    if (map.containsKey(subject)) {
      print('contained');
      map[subject] =(map[subject]??0)+ 5;
      print(map[subject]);
    }
  });

  userProfile.value!.lcqNumber.forEach((map) {
    if (map.containsKey(subject)) {
      map[subject] =(map[subject]??0)+ 1;
      print(map[subject]);
    }
  });

  final userDocRef = _firestore.collection('profiles').doc(userProfile.value!.uid);
  await userDocRef.update({
    'marks': userProfile.value!.marks,
    'lcqNumber': userProfile.value!.lcqNumber,
  });
}

  Future<void> loadUserProfile(String uid) async {
    isLoading.value = true;
    resetUserProfile();

    try {
      final profileDoc = await _firestore.collection('profiles').doc(uid).get();
      if (profileDoc.exists) {
        userProfile.value = UserProfile.fromMap(profileDoc.data() as Map<String, dynamic>, uid);
      } else {
        print('User does not exist');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createUserProfile(String uid, String displayName) async {
    isLoading.value = true;
    resetUserProfile();

    try {
      final userDocRef = _firestore.collection('profiles').doc(uid);
      final userDoc = await userDocRef.get();

      if (userDoc.exists) {
        loadUserProfile(uid);
      } else {
        final initialUserProfile = {
          'role':'user',
          'displayName': displayName.isNotEmpty ? displayName : 'User',
          'marks': [
            {'maths': 0},
            {'science': 0},
            {'english': 0},
            {'history':0},
            {'ict':0},
            {'geography':0}
          ],
          'lcqNumber': [
            {'maths': 0},
            {'science': 0},
            {'english': 0},
            {'history':0},
            {'ict':0},
            {'geography':0}
          ],
        };
        await userDocRef.set(initialUserProfile);
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      isLoading.value = false;
    }
  }





  void printUser() {
    print(userProfile.value!.displayName);
  }
}
