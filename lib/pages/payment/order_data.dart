import 'package:dine_out/model/review_cart_model.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel?e;
  OrderItem({this.e});
  // OrderItem({super.key});
 // bool ? isTrue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:Image.network(e!.cartImage!,
      width: 60,
      ), 
      title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Text(e!.cartName!,
          style: TextStyle(
            color: Colors.grey,
          ),
          ),
          Text("\$${e!.cartPrice!}",
          
          ),
        ],
      ),
      
       
    );
  }
}