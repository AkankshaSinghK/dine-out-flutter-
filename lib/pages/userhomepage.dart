import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  //int _selectedIndex = 2;
  final user = FirebaseAuth.instance.currentUser!;
  bool admin = false;

  void isAdmin() async {
    DocumentSnapshot adminRef = await FirebaseFirestore.instance
        .collection('admin')
        .doc(user.uid)
        .get();
    if (adminRef.exists) {
      setState(() {
        admin = true;
      });
    } else {
      setState(() {
        admin = false;
      });
    }
  } 

   @override
  void initState() {
    isAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "User can logout from here",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 
