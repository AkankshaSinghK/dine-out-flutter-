import 'package:flutter/material.dart';


class SingleDeliveryItem extends StatelessWidget {
  //const SingleDeliveryItem({super.key});

  final String? title;
  final String? address;
  final String? number;

  SingleDeliveryItem({this.title,  this.address, this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title!),
          leading: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.amber,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address!),
              SizedBox(
                height: 5,
              ),
              Text(number!),
            ],
          ),
        ),
        Divider(
          height: 35,
        ),
      ],
    );
  }
}
