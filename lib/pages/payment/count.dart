import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_out/model/review_cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Count extends StatefulWidget {
 String? productName;
  String? productImage;
  String? productId;
  int? productPrice;


  Count({
    this.productName,
   
    this.productId,
    this.productImage,
    this.productPrice,
  });


  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {

  int count = 1;
  bool isTrue = false;

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      count = value.get("cartQuantity");
                      isTrue = value.get("isAdd");
                    })
                  }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
     getAddAndQuantity();

    ReviewCartProvider reviewCartProvider = Provider.of(context);
    
  
    return Container(
     child: Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isTrue = true;
                  });
                  reviewCartProvider.addReviewCartData(
                    cartId: widget.productId,
                    cartImage: widget.productImage,
                    cartName: widget.productName,
                    cartPrice: widget.productPrice,
                    
                  );
                },
                child: Text(
                  "ADD",
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ),
    );
  }
}