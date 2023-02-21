import 'package:dine_out/model/check_out_provider.dart';
import 'package:dine_out/model/review_cart_provider.dart';
import 'package:dine_out/pages/bottom_nav_bar.dart';
import 'package:dine_out/pages/store/intro_screen.dart';
import 'package:provider/provider.dart';

import 'auth/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CheckoutProvider>( create: (context) => CheckoutProvider()),
        ChangeNotifierProvider<ReviewCartProvider>( create: (context) => ReviewCartProvider()),
      ],
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroScreen(),
      ),
    );
  }
}
