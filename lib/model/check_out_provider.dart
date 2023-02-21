import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_out/model/delivery_adress_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckoutProvider with ChangeNotifier {
  static bool isloading = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController adressLane1 = TextEditingController();
  TextEditingController adressLane2 = TextEditingController();

  TextEditingController landmark = TextEditingController();

  TextEditingController pincode = TextEditingController();


  void validator(context) async {
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "firstname is empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "lastname is empty");
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "mobileNo is empty");
    } else if (adressLane1.text.isEmpty) {
      Fluttertoast.showToast(msg: "adressLane1 is empty");
    } else if (adressLane2.text.isEmpty) {
      Fluttertoast.showToast(msg: "adressLane2 is empty");
    }else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "landmark is empty");
    } else if (pincode.text.isEmpty) {
      Fluttertoast.showToast(msg: "pincode is empty");
    }  else {
      isloading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mobileNo": mobileNo.text,
        "adressLane1": adressLane1.text,
        "adressLane2": adressLane2.text,
        
        "landmark": landmark.text,
       
        "pincode": pincode.text,
       
      }).then((value) async {
        isloading = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  
  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    print("GET DELIVERY DAtA ");
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
        print("db exists ${_db.exists} ${_db.get('firstname')}");
    if (_db.exists) {
      print("db exist ${_db.exists}");
      deliveryAddressModel = DeliveryAddressModel(
        firstName: _db.get("firstname"),
        lastName: _db.get("lastname"),
       
        landMark: _db.get("landmark"),
        mobileNo: _db.get("mobileNo"),
        pinCode: _db.get("pincode"),
        adressLane1: _db.get("adressLane1"),
        adressLane2: _db.get("adressLane2"),
      );
      newList.add(deliveryAddressModel);
      print("NEW LIST ${newList}");
      // notifyListeners();
    }

    deliveryAdressList = newList;
    notifyListeners();
  }


  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }

}
