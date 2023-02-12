import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum ItemCategory { food, beverages, desserts }

extension SizeExtension on ItemCategory {
  String get name => describeEnum(this);
}

ItemCategory parseCategory(final String categoryName) {
  switch (categoryName) {
    case 'food':
      return ItemCategory.food;
    case 'beverages':
      return ItemCategory.beverages;
    case 'desserts':
      return ItemCategory.desserts;
    default:
      throw Exception('$categoryName is not a valid ItemCategory');
  }
}

class StoreItem {
  String name;
  String itemImage;
  num price;
  ItemCategory category;

  StoreItem({
    required this.name,
    required this.category,
    required this.itemImage,
    required this.price,
  });

  factory StoreItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return StoreItem(
      name: data?['name'],
      itemImage: data?['itemImage'],
      price: data?['price'],
      category: parseCategory(data?['category']),
    );
  }

  Map<String, dynamic> toFirestore() => {
        "name": name,
        "itemImage": itemImage,
        "price": price,
        "category": category.name,
      };

  @override
  String toString() {
    return "$name -> $price | $category";
  }
}
