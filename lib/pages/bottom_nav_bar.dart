import 'package:dine_out/pages/home_page.dart';
import 'package:dine_out/pages/menu.dart';
import 'package:dine_out/pages/store/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Menu',
      style: optionStyle,
    ),
    Text(
      'Cart',
      style: optionStyle,
    ),
    Text(
      'Home',
      style: optionStyle,
    ),
    
  ];
final screens = [
 MenuScreen(),
  CartPage(),
   HomePage(),
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        color:Colors.orangeAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:15.0,vertical:15),
          child: GNav (
            backgroundColor: Colors.orangeAccent,
            color:Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap:8,
            
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(icon: Icons.menu,
              text: 'Menu',),
              GButton(icon: Icons.shopping_cart,
              text: 'Cart',),
              GButton(icon: Icons.home,
              text: 'Home',),
            ],
            selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              }
            
          ),
        ),
      ),
    );
  }
}