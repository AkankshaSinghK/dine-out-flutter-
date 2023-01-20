import 'store_item.dart';
import 'package:get/get.dart';


class CartModel extends GetxController {
  // list of items on sale

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
    for (var element in cartItems) {
      totalPrice += element.price;
    }
    return totalPrice.toStringAsFixed(2);
  }
}
