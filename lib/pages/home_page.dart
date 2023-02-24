import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dine_out/pages/userhomepage.dart';
import 'package:dine_out/read%20data/get_user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
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

  //document IDS
  List<String>docIDs =[];

  //get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('users').get().then(
      (snapshot)=> snapshot.docs.forEach((document){
        print(document.reference);
        docIDs.add(document.reference.id);
      },),
    );
  }

@override
  void initState() {
    getDocId();
    isAdmin();
    super.initState();
  } 

 /*
  @override
  void initState() {
    isAdmin();
    super.initState();
  } */


 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        
            
          title: Text(
            //"Akanksha",
            user.email!,
            style: const TextStyle(fontSize: 16),
          ),
          centerTitle: false,
          actions: [
         
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Icon(Icons.logout),
            ),
          ],
        ),
       
       body:admin? Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: const Text('Users List',
               style: const TextStyle(fontSize: 30, fontStyle:FontStyle.italic, fontWeight: FontWeight.bold),
              ),
            ),
              Expanded(
                child:FutureBuilder(
                  future:getDocId(),
                  builder:(context, snapshot){
                  return ListView.builder(
                    itemCount:docIDs.length,
                    itemBuilder:(context, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: GetUserName(documentId:docIDs[index]),
                          tileColor: Color.fromARGB(255, 233, 173, 244),
                        ),
                      );
                    },
                    );
                  },
                ) ,
                  ),
          ],
        )
        ):UserHomePage(),
      ),
    );
  }
}
