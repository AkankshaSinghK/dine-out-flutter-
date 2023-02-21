import 'package:dine_out/auth/auth_page.dart';
import 'package:dine_out/pages/bottom_nav_bar.dart';
import 'package:dine_out/pages/home_page.dart';

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
          return const BottomNavigationBarScreen();
        }else{
          return const AuthPage();
        }
        },
     ),
    );
    
  }
}

  