import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_out/model/store_item.dart';
import 'package:dine_out/pages/store/add_item.dart';
import 'package:dine_out/pages/store/cart_page.dart';
import 'package:dine_out/pages/store/grocery_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../controllers/store_controller.dart';
import '../utils/colors.dart';
import '../utils/helper.dart';
import 'package:flutter/material.dart';

class BeverageScreen extends StatefulWidget {
  const BeverageScreen({super.key});

  @override
  State<BeverageScreen> createState() => _BeverageScreenState();
}

class _BeverageScreenState extends State<BeverageScreen> {
  final Stream<QuerySnapshot<StoreItem>> _usersStream = FirebaseFirestore.instance
      .collection('storeItems')
      .where('category', isEqualTo: 'beverages').withConverter(fromFirestore: 
      StoreItem.fromFirestore, toFirestore: (StoreItem item, _) => item.toFirestore(),)
      .snapshots();

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
        print("ADMIN");
      });
    } else {
      setState(() {
        admin = false;
        print("USER");
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
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<StoreItem>>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot<StoreItem>> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppColor.primary,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            "Beverages",
                            style: Helper.getTheme(context).headline5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(12),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.2,
                    ),
                    itemBuilder: (context, index) {
                      StoreItem storeItem = snapshot.data!.docs[index].data();

                      // Widget widget = admin ?
                      return GroceryItemTile(
                        itemName: storeItem.name,
                        itemPrice: storeItem.price.toString(),
                        imagePath: storeItem.itemImage,
                        color: Colors.green,
                        onPressed: () {
                          print(storeItem.category);
                          storeController.addItemToCart(storeItem);
                        }, //print("Tile was clicked"),
                      );
                    },
                  ),
                ],
              );
            }
            return const Text('Something went wrong');
          },
        ),
      ),
       floatingActionButton:!admin? FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            admin ? Get.to(() => const AddMenuItem()) : Get.to(() => const CartPage());
          },
          child: const Icon(Icons.shopping_bag),
        )
        :null,
    );
  }
}

/* @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppColor.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Beverages",
                                style: Helper.getTheme(context).headline5,
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          Helper.getAssetName("cart.png", "virtual"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                 //SearchBar(
                 //   title: "Search Food",
                //  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DessertCard(
                    image: Image.asset(
                      Helper.getAssetName("apple_pie.jpg", "real"),
                      fit: BoxFit.cover,
                    ),
                    name: "French Apple Pie",
                   
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DessertCard(
                    image: Image.asset(
                      Helper.getAssetName("dessert2.jpg", "real"),
                      fit: BoxFit.cover,
                    ),
                    name: "Dark Chocolate Cake",
                    
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DessertCard(
                    image: Image.asset(
                      Helper.getAssetName("dessert4.jpg", "real"),
                      fit: BoxFit.cover,
                    ),
                    name: "Street Shake",
                   
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DessertCard(
                    image: Image.asset(
                      Helper.getAssetName("dessert5.jpg", "real"),
                      fit: BoxFit.cover,
                    ),
                    name: "Fudgy Chewy Brownies",
                   
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
         /* Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              menu: true,
            ),
          ),*/
        ],
      ),
    );
  }
}


class DessertCard extends StatelessWidget {
  const DessertCard({
    Key? key,
    required String name,
    required Image image, 
  })  : _name = name,
        _image = image,
        super(key: key);

  final String _name;
  final Image _image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: _image,
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.2),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 70,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    
                   /* style: Helper.getTheme(context).headline4,/*copyWith(*/
                          color: Colors.white,
                       // ),*/
                    style:const TextStyle(
                      color:Colors.white,
                      fontSize: 25,
                      
                    ),
                        
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Helper.getAssetName("star_filled.png", "virtual"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Desserts",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}*/
