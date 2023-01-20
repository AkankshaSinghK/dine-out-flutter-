import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../read data/get_user_details.dart';

class AppUserList extends StatefulWidget {
  const AppUserList({super.key});

  @override
  State<AppUserList> createState() => _AppUserListState();
}

class _AppUserListState extends State<AppUserList> {

  List<String> docIDs = [];

  //get docIDs
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('users').get().then(
      (snapshot)=>snapshot.docs.forEach((document){
        print(document.reference);
        docIDs.add(document.reference.id);
      }),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         /* Text('signed in as:' + user.email!),
          MaterialButton(
            onPressed:(){
              FirebaseAuth.instance.signOut();
            } ,
            color: Colors.deepPurple[200],
            child: Text('Sign Out'),
            ),*/
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder:(context,snapshot){
                  return ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: GetUserName(documentId:docIDs[index]),
                      tileColor: Colors.deepPurple[100],
                    ),
                  );
                },
                );
                } ,)
              ),

        ],
      )
      );
  }
}