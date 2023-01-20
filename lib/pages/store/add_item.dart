// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_out/model/store_item.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class AddMenuItem extends StatefulWidget {
  const AddMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  State<AddMenuItem> createState() => _AddMenuItemState();
}

class _AddMenuItemState extends State<AddMenuItem> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  late String name;
  late int price;
  String imagePath = "";

  late ItemCategory category = ItemCategory.food;
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();

  String errorMessage = "";
  bool _validate = false;

  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  XFile? xImageTemp;

  Future pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      xImageTemp = XFile(pickedFile.path);
      setState(() {
        imagePath = pickedFile.name;
      });
    }
  }

  Future addItem() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      _storage.ref("menus/$name.jpg").putData(await xImageTemp!.readAsBytes()).then((snapshot) {
        snapshot.ref.getDownloadURL().then((url) {
          _firestore
              .collection("storeItems")
              .withConverter(
                fromFirestore: StoreItem.fromFirestore,
                toFirestore: (StoreItem item, value) => item.toFirestore(),
              )
              .add(
                StoreItem(
                  name: name,
                  category: category,
                  itemImage: url,
                  price: price,
                ),
              )
              .then((value) {
            _nameController.clear();
            _priceController.clear();
            setState(() {
              imagePath = "";
            });

            SnackBar snackBar = const SnackBar(content: Text("Item added"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }, onError: (error) {
            SnackBar snackBar = const SnackBar(content: Text("Error writing to database."));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        });
      });
    } else {
      SnackBar snackBar = const SnackBar(content: Text("Error occurred. Try again."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Add store item")),
        body: Center(
          child: Form(
            key: _key,
            autovalidateMode: _validate ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 40.0),
                    const Text("Item name"),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {},
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_nameFocusNode);
                      },
                      onSaved: (str) {
                        name = str!;
                      },
                      validator: (str) => validateName(str!),
                      focusNode: _nameFocusNode,
                    ),
                    const SizedBox(height: 30),
                    const Text("Item price"),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      onChanged: (val) {},
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        price = int.parse(value!);
                      },
                      validator: (value) => validatePrice(value!),
                      focusNode: _priceFocusNode,
                    ),
                    const SizedBox(height: 30),
                    const Text("Item Category"),
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('Food'),
                          leading: Radio<ItemCategory>(
                            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
                            focusColor: MaterialStateColor.resolveWith((states) => Colors.green),
                            value: ItemCategory.food,
                            groupValue: category,
                            onChanged: (value) {
                              setState(() {
                                category = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Drinks'),
                          leading: Radio<ItemCategory>(
                            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
                            value: ItemCategory.drink,
                            groupValue: category,
                            onChanged: (value) {
                              setState(() {
                                category = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(imagePath.isEmpty ? "Select Image" : imagePath),
                        IconButton(
                            onPressed: () async {
                              await pickImage();
                            },
                            icon: const Icon(Icons.image)),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    ElevatedButton(
                      onPressed: () async {
                        await addItem();
                      },/* => Get.showOverlay(
                        asyncFunction: addItem,
                        loadingWidget: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ), */
                      child: const Text("Add Item"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Name is Required...";
    } else if (value.length <= 1) {
      return 'Invalid Name!';
    }
    return null;
  }

  String? validateDescription(String value) {
    if (value.isEmpty) {
      return "Description is Required...";
    } else if (value.length <= 1) {
      return 'Invalid Description...';
    }
    return null;
  }

  String? validatePrice(String value) {
    if (value.isEmpty) {
      return "Price is Required...";
    } else if (int.parse(value) <= 1) {
      return 'Price must be greater than 1!';
    }
    return null;
  }
}
