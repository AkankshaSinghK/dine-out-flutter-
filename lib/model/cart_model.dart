import 'package:dine_out/model/store_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CartModel extends GetxController {
  // list of items on sale
  final List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Avocado", "4.00", "lib/images/avocado.png", Colors.green],
    ["Banana", "2.50", "lib/images/banana.png", Colors.yellow],
    ["Chicken", "12.80", "lib/images/chicken.png", Colors.brown],
    ["Water", "1.00", "lib/images/water.png", Colors.blue],
  ];

  // list of cart items
  RxList<StoreItem> cartItems = <StoreItem>[].obs;
  

  // add item to cart
  void addItemToCart(StoreItem item) {
    cartItems.add(item);
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    cartItems.removeAt(index);
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    cartItems.forEach((element) => totalPrice += element.price);
    return totalPrice.toStringAsFixed(2);
  }
}
