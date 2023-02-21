import 'package:dine_out/model/check_out_provider.dart';
import 'package:dine_out/model/delivery_adress_model.dart';
import 'package:dine_out/pages/payment/address_delivery_details.dart';
import 'package:dine_out/pages/payment/payment_summary.dart';
import 'package:dine_out/pages/payment/single_delivery_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({super.key});

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  DeliveryAddressModel? value;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   CheckoutProvider cop = Provider.of(context);
  //   cop.getDeliveryAddressData();
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckoutProvider>(
        create: (_) => CheckoutProvider(),
        child: Consumer<CheckoutProvider>(
          builder: (context, model, child) {
            // Here you can use the model variable
            // to read and alter the state

            model.getDeliveryAddressData(); // leads to infinite loop
            print(model.getDeliveryAddressList.isEmpty);
            return Scaffold(
              appBar: AppBar(
                title: const Text('Delivery Details'),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.amber,
                child: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddDeliverAddress(),
                  ));
                },
              ),
              bottomNavigationBar: Container(
                height: 40,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: MaterialButton(
                  onPressed: () {
                    model.getDeliveryAddressList.isEmpty
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddDeliverAddress()))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentSummary(
                                deliverAddressList: value,
                              ),
                            ),
                          );
                  },
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: model.getDeliveryAddressList.isEmpty
                      ? const Text("Add new Address")
                      : const Text("Payment Summary"),
                ),
              ),
              body: ListView(
                children: [
                  const ListTile(
                    title: Text("Deliver To"),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  model.getDeliveryAddressList.isEmpty
                      ? const Center(
                          child: Center(
                            child: Text("No Data"),
                          ),
                        )
                      : Column(
                          children:
                              model.getDeliveryAddressList.map<Widget>((e) {
                            // setState(() {
                            value = e;
                            //  });

                            return SingleDeliveryItem(
                              address:
                                  "${e.adressLane1},${e.adressLane2},\nPincode: ${e.pinCode}",
                              title: "${e.firstName} ${e.lastName}",
                              number: e.mobileNo,
                            );
                          }).toList(),
                        )
                ],
              ),
            );
          },
        ));
  }
}
