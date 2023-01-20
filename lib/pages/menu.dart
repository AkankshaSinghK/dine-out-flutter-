import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/store_item.dart';
import 'beveragescreen.dart';
import 'dessertscreen.dart';
import 'food_screen.dart';
import 'store/add_item.dart';
import '../utils/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

    final Stream<QuerySnapshot<StoreItem>> _menuStream = FirebaseFirestore.instance
      .collection('storeItems')
      .withConverter(
        fromFirestore: StoreItem.fromFirestore,
        toFirestore: (StoreItem city, _) => city.toFirestore(),
      )
      .orderBy("name")
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
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Menu",
                        style: Helper.getTheme(context).headlineLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: Helper.getScreenHeight(context) * 0.6,
                  width: Helper.getScreenWidth(context),
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: 100,
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          color: Colors.orangeAccent,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FoodScreen()));
                              },
                              child: MenuCard(
                                imageShape: ClipOval(
                                  child: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: Image.asset(
                                        Helper.getAssetName(
                                            "western2.jpg", "real"),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                name: "Food",
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BeverageScreen()));
                              },
                              child: MenuCard(
                                imageShape: ClipOval(
                                  child: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: Image.asset(
                                        Helper.getAssetName(
                                            "coffee2.jpg", "real"),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                name: "Beverages",
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DessertScreen()));
                              },
                              child: MenuCard(
                                imageShape: ClipOval(
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.asset(
                                      Helper.getAssetName(
                                          "dessert.jpg", "real"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                name: "Desserts",
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
              
            ),
           
          ],
          
        ),
        floatingActionButton: admin
            ? FloatingActionButton.extended(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const AddMenuItem()),
                ),
                label: const Text("Add items"),
                icon: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key? key,
    required String name,
    required Widget imageShape,
  })  : _name = name,
        _imageShape = imageShape,
        super(key: key);

  final String _name;
  final Widget _imageShape;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 60,
          ),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.placeholder,
                  offset: Offset(0, 5),
                  blurRadius: 10,
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _name,
                style: Helper.getTheme(context).headline4,
                //copyWith(
                //color: AppColor.primary,
                //),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: Align(
            alignment: Alignment.centerLeft,
            child:
                _imageShape, /* ClipOval(
            child: Container(
              height:60,
              width: 60,
              child:Image.asset(
                Helper.getAssetName(
                "4.jpg", "real"),
                fit: BoxFit.cover,
                )
              ),
          ),*/
          ),
        ),
        SizedBox(
          height: 80,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
                height: 40,
                width: 40,
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                      color: AppColor.placeholder,
                      offset: Offset(0, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Image.asset(
                  Helper.getAssetName("next_filled.png", "virtual"),
                  // fit: BoxFit.cover,
                )),
          ),
        )
      ],
    );
  }
}
