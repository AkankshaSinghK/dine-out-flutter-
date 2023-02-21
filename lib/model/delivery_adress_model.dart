class DeliveryAddressModel {
  String? firstName;
  String? lastName;
  String? mobileNo;
 
  String? adressLane1;
  String? adressLane2;
  String? landMark;

  String? pinCode;
 

  DeliveryAddressModel({
 
    this.firstName,
    this.landMark,
    this.lastName,
    this.mobileNo,
    this.pinCode,
    this.adressLane1,
    this.adressLane2,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "$firstName $lastName -- $adressLane1";
  }
}