import 'package:dine_out/model/check_out_provider.dart';
import 'package:dine_out/model/delivery_adress_model.dart';
import 'package:dine_out/model/review_cart_provider.dart';
import 'package:dine_out/pages/bottom_nav_bar.dart';
import 'package:dine_out/pages/menu.dart';
import 'package:dine_out/pages/payment/order_data.dart';
import 'package:dine_out/pages/payment/single_delivery_item.dart';
import 'package:dine_out/pages/ordersummary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../controllers/store_controller.dart';

class PaymentSummary extends StatefulWidget {
  final DeliveryAddressModel? deliverAddressList;
  const PaymentSummary({this.deliverAddressList});

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

enum String {
  CashOnDelievery,
  OnlinePayment,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = String.CashOnDelievery;
  var cartItems = storeController.cartItems;

  @override
  Widget build(BuildContext context) {
    print(cartItems);
    return ChangeNotifierProvider<ReviewCartProvider>(
        create: (_) => ReviewCartProvider(),
        child: Consumer<ReviewCartProvider>(
          builder: (context, model, child) {
            // Here you can use the model variable
            // to read and alter the state

            model.getReviewCartData();
            // ReviewCartProvider reviewCartProvider = Provider.of(context);
            // reviewCartProvider.getReviewCartData();
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Payment Summary",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              bottomNavigationBar: ListTile(
                title: const Text("Total Amount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
                subtitle: Text("₹${storeController.calculateTotal().toString()}",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                trailing: Container(
                  width: 160,
                  child: MaterialButton(
                    onPressed: () {
                      Get.snackbar(
                        "Order Placed",
                        "Your order has been placed Successfully",
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 3),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderSummary( deliverAddressList:widget.deliverAddressList),
                        ),
                      );
                    },
                    child: const Text("Place Order",
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    SingleDeliveryItem(
                      address:
                          "${widget.deliverAddressList!.adressLane1},${widget.deliverAddressList!.adressLane2}\nPincode: ${widget.deliverAddressList!.pinCode}",
                      title:
                          "${widget.deliverAddressList!.firstName} ${widget.deliverAddressList!.lastName}",
                      number: widget.deliverAddressList!.mobileNo,
                    ),
                    //Text("Items: ${cartItems.length}"),
                    Expanded(
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
                    )),
                    const Divider(),
                    ListTile(
                      minVerticalPadding: 5,
                      leading: Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                    const Divider(),
                    const ListTile(
                      leading: Text("Payment Options"),
                    ),
                    RadioListTile(
                      value: String.CashOnDelievery,
                      groupValue: myType,
                      title: const Text("Cash On Delievery"),
                      onChanged: (String? value) {
                        setState(() {
                          myType = value!;
                        });
                      },
                      secondary: const Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                    ),
                    RadioListTile(
                      value: String.OnlinePayment,
                      groupValue: myType,
                      title: const Text("Online Payment"),
                      onChanged: (String? value) {
                        setState(() {
                          myType = value!;
                        });
                      },
                      secondary: const Icon(
                        Icons.payment,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
