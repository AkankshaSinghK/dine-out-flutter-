import 'package:dine_out/model/check_out_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_textfield.dart';

class AddDeliverAddress extends StatefulWidget {
  const AddDeliverAddress({super.key});

  @override
  State<AddDeliverAddress> createState() => _AddDeliverAddressState();
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  @override
  Widget build(BuildContext context) {
     CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Add Delivery Address"),),
      bottomNavigationBar: Container(
         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child:CheckoutProvider.isloading == false
            ? MaterialButton(
                onPressed: () {
                  checkoutProvider.validator(context);
                },
                child: Text(
                  "Add Address",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(

          horizontal: 20,
        ),
        child: ListView(
          children: [
            CustomTextField(
              labText: "First name",
              controller: checkoutProvider.firstName,
            ),
             CustomTextField(
              labText: "Last name",
               controller: checkoutProvider.lastName,
            ),
             CustomTextField(
              labText: "Mobile Number",
               controller: checkoutProvider.mobileNo,
            ),
             CustomTextField(
              labText: "Address Lane 1",
               controller: checkoutProvider.adressLane1,
            ),
             CustomTextField(
              labText: "Address Lane 2",
               controller: checkoutProvider.adressLane2,
            ),
             CustomTextField(
              labText: "Landmark",
               controller: checkoutProvider.landmark,
            ),
             CustomTextField(
              labText: "Pincode",
               controller: checkoutProvider.pincode,
            ),
            //  InkWell(
            //   onTap: (){},
            //   child: Container(
            //     height: 47,
            //     width: double.infinity,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text("Set Loaction"),
                    
            //       ],
            //     ),
            //   ),

            //  )
          ],
        ),
      ),
    );
  }
}