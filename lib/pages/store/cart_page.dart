

import 'package:dine_out/model/review_cart_provider.dart';
import 'package:dine_out/pages/payment/address_delivery_details.dart';
import 'package:dine_out/pages/payment/count.dart';
import 'package:dine_out/pages/payment/delivery_details.dart';
import 'package:provider/provider.dart';

import '../../model/store_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/store_controller.dart';

class CartPage extends StatefulWidget {
  
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    var cartItems = storeController.cartItems;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   iconTheme: IconThemeData(
      //     color: Colors.grey[800],
      //   ),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Let's order fresh items for you
          SizedBox(height: 60.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "My Cart",
              style: GoogleFonts.notoSerif(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // list view of cart
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Obx(
                ()=> ListView.builder(
                  itemCount: cartItems.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    StoreItem item = cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          leading: Image.network(
                            item.itemImage,
                            height: 36,
                          ),
                          title: Text(
                            item.name,
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            '₹ ${item.price}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () => cartItems.remove(item),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // total amount + pay now

          Padding(
            padding: const EdgeInsets.all(36.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.green,
              ),
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(color: Colors.green[200]),
                      ),

                      const SizedBox(height: 8),
                      // total price
                      Text(
                        '₹${storeController.calculateTotal()}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // pay now
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green.shade200),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: GestureDetector(
                      onTap: () => {
                        // reviewCartProvider.addReviewCartData( ),
                        
                        Navigator.push(context,MaterialPageRoute(builder: ((context) => DeliveryDetails()))),
                        print("Redirecting to delivery details ....")

                      },
                      child: Row(
                        children: const [
                          Text(
                            'Buy Now',
                            style: TextStyle(color: Colors.white),
                            
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.white,
                          ),
                          
                          
                       ],
                       
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
