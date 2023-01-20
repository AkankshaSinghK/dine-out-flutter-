import '../pages/menu.dart';
import '../pages/store/intro_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<User?>(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot){
          if(snapshot.hasData){
          return const MenuScreen();
        }else{
          return const IntroScreen();
        }
        },
     ),
    );
    
  }
}

  