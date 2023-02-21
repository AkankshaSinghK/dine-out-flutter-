import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body:
    //   Container(
    //    // height: 50,
    //     color: Colors.blue,
    //    child: Row(
    //       children: [
    //         Text("Order Summary",
    //         style: TextStyle(fontWeight: FontWeight.bold,),
    //         ),
    //       ],
    //     ),
    //   ),

    // );
    return  Container(
      height: 60,
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10,bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          
            Text("Order Summary",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
          ],
        ),
      ),
    );
  
 
  
  }
}