import 'package:cloud_firestore/cloud_firestore.dart';
import 'menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   //User? user = FirebaseAuth.instance.currentUser;
  //var db = FirebaseFirestore.instance;

   final user = FirebaseAuth.instance.currentUser!;

  /* final Stream<QuerySnapshot<StoreItem>> _menuStream = FirebaseFirestore.instance
      .collection('storeItems')
      .withConverter(
        fromFirestore: StoreItem.fromFirestore,
        toFirestore: (StoreItem city, _) => city.toFirestore(),
      )
      .orderBy("name")
      .snapshots(); */

  /* bool admin = false;
  void isAdmin() async {
    DocumentSnapshot adminRef = await db.collection('admin').doc(user!.uid).get();
    if (adminRef.exists) {
      setState(() {
        admin = true;
      });
    } else {
      setState(() {
        admin = false;
      });
    }
  } */
 

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
 
  @override
  void initState() {
    isAdmin();
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.transparent,
           /*  elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Icon(
                Icons.location_on,
                color: Colors.grey[700],
              ),
            ), */
            
          title: Text(
            //"Akanksha",
            user.email!,
            style: const TextStyle(fontSize: 16),
          ),
          centerTitle: false,
          actions: [
           /*  GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                ),
                onTap: () => Get.to(() => ProfilePage()),
              ), */
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Icon(Icons.logout),
            ),
          ],
        ),
        /*  floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              admin ? Get.to(() => const AddMenuItem()) : Get.to(() => const CartPage());
            },
            child: const Icon(Icons.shopping_bag),
          ), */
         /*  body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
    
              // good morning bro
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('Good morning,'),
              ),
    
              const SizedBox(height: 4),
    
              // Let's order fresh items for you
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Let's order fresh items for you",
                  style: GoogleFonts.notoSerif(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
    
              const SizedBox(height: 24),
    
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Divider(),
              ),
    
              const SizedBox(height: 24),
    
              // categories -> horizontal listview
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Fresh Items",
                  style: GoogleFonts.notoSerif(
                    //fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
    
              // recent orders -> show last 3
              Expanded(
                child: StreamBuilder<QuerySnapshot<StoreItem>>(
                  stream: _menuStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot<StoreItem>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(12),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.2,
                        ),
                         itemBuilder: (context, index) {
                          StoreItem storeItem = snapshot.data!.docs[index].data();
    
                          return GroceryItemTile(
                            itemName: storeItem.name,
                            itemPrice: storeItem.price.toString(),
                            imagePath: storeItem.itemImage,
                            color: Colors.green,
                            onPressed: () => storeController.addItemToCart(index),
                          ); 
                        }, 
                      );
                    } else {
                      return const Center(child: Text("Something went wrong"));
                    }
                  },
                ),
              ), 
            ],
          ), */
       body: const MenuScreen(),
      ),
    );
  }
}
