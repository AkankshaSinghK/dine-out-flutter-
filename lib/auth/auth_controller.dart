import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {

  static AuthController instance = Get.find();
  // email,password,name etc in user
  FirebaseAuth auth = FirebaseAuth.instance;

  // helper function that will be called from sign up
  void register(String email, password) async {
    //  await auth.createUserWithEmailAndPassword(email: email, password: password);
    //   print("Successful sign up");
    try {
      
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      print("Successful sign up");
    } catch (e) {
      Get.snackbar("About user", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Account creation failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
          print("Failed signup");
    }
  }

   void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Logging in", "Succesful login",
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Success",
            style: TextStyle(color: Colors.white),
          ),);
          print("Login success");
    } catch (e) {
      Get.snackbar("About login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Log in failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
          print("login failed");
    }
  }

  void logOut() async{
    await auth.signOut();
    print("Logged out successfully");
  }
}
