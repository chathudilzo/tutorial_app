

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutorial_app/controllers/user_controller.dart';

class AuthService{


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

        ProfileController().createUserProfile(user!.uid, user.displayName.toString());
      }
     }catch(error){
      print(error.toString());
     }

  }
}