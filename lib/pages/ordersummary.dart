import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_out/pages/bottom_nav_bar.dart';
import 'package:dine_out/pages/payment/single_delivery_item.dart';
import 'package:dine_out/utils/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/store_controller.dart';
import '../model/delivery_adress_model.dart';
import 'home_page.dart';

class OrderSummary extends StatefulWidget {
  final DeliveryAddressModel? deliverAddressList;
  const OrderSummary({this.deliverAddressList});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
 // int _selectedIndex = 2;
  var cartItems = storeController.cartItems;

//   final user = FirebaseAuth.instance.currentUser!;
  

//  bool admin = false;

//   void isAdmin() async {
//     DocumentSnapshot adminRef = await FirebaseFirestore.instance
//         .collection('admin')
//         .doc(user.uid)
//         .get();
//     if (adminRef.exists) {
//       setState(() {
//         admin = true;
//       });
//     } else {
//       setState(() {
//         admin = false;
//       });
//     }
//   } 

//   @override
//   void initState() {
    
//     isAdmin();
//     super.initState();
//   } 
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      //  appBar: AppBar(
        
            
      //     title: Text(
      //       //"Akanksha",
      //       "Order Summary",
      //       style: const TextStyle(fontSize: 16),
      //     ),
      //     centerTitle: false,
      //     actions: [
         
      //       GestureDetector(
      //         onTap: () {
      //           FirebaseAuth.instance.signOut();
      //         },
      //         child: const Icon(Icons.logout),
      //       ),
      //     ],
      //   ),
      

      body: 
      Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
        [
         // SizedBox(height: 10,),
          CustomAppBar(),
          SizedBox(height: 40,),
          Text("Your Recent Order",
          style: TextStyle(fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,),
           Expanded(
            //height: 150,
                        child: ListView.separated(
                      // <-- SEE HERE
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          cartItems[index].itemImage),
                                      fit: BoxFit.contain))),
                          title: Text('${cartItems[index].name}'),
                          // subtitle: Text('Item description'),
                          trailing: Text('₹${cartItems[index].price}'),
                        );
                      },
                      separatorBuilder: (context, index) {
                        // <-- SEE HERE
                        return Divider();
                      },
                    )
                    ),
                     
                    ListTile(
                      //minVerticalPadding: 5,
                      leading: Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 20,
                        ),
                      ),
                      trailing: Text(
                         "₹${storeController.calculateTotal().toString()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    
                    Text("Your order will be Delivered to:",style: TextStyle(fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
                    ),

                     SizedBox(height: 30,),

               /*  widget.deliverAddressList == null ? Container()  : */  SingleDeliveryItem(
                      address:
                          "${widget.deliverAddressList!.adressLane1},${widget.deliverAddressList!.adressLane2}\nPincode: ${widget.deliverAddressList!.pinCode}",
                      title:
                          "${widget.deliverAddressList!.firstName} ${widget.deliverAddressList!.lastName}",
                      number: widget.deliverAddressList!.mobileNo,
                    ),
        ],
  
      ),
       floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
              Get.to(() => const BottomNavigationBarScreen());
          },
          child: const Icon(Icons.home),
        ),
      
       )
       );
  }
}