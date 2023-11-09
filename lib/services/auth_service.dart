

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutorial_app/controllers/user_controller.dart';

class AuthService{
final ProfileController profileController=Get.find();


  signInWithGoogle()async{
    final GoogleSignInAccount? gUser=await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth=await gUser!.authentication;

    final credential=GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );

     try{
      final result=await FirebaseAuth.instance.signInWithCredential(credential);

      if(result.user!=null){
        final user=result.user;
        print('USER PROFILE google '+user.toString());

        await profileController.createUserProfile(user!.uid, user.displayName.toString());
        await profileController.loadUserProfile(user.uid);
        //  ProfileController().isLoading.value=false;
      }
     }catch(error){
      Get.snackbar('Something Went Wrong', error.toString());
      profileController.isLoading.value = false;
     }

  }
}