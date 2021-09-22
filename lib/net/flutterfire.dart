
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return true;
  }catch(e){
    // ignore: avoid_print
    print(e.toString());
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch(e){
    if(e.code == "weak-password"){
      // ignore: avoid_print
      print("Le mot de passe entré est trop faible");
    }else if(e.code == "email-already-in-use"){
      // ignore: avoid_print
      print("Un compte est déjà associé à cet e-mail");
    }
    return false;
  }catch(e){
    // ignore: avoid_print
    print(e.toString());
    return false;
  }
}