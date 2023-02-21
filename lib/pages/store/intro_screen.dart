import 'package:dine_out/auth/main_page.dart';

import '../../auth/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color(0xFFFFF1E8),
      body: SafeArea(
        child: Column(
          children: [
            // big logo
            const Padding(
              padding: EdgeInsets.only(
                left: 100.0,
                right: 100.0,
                top: 50,
                bottom: 20,
              ),
            ),
            Container(
              width: 300,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('img/food1.png'),
                fit: BoxFit.cover
              )),
            ),

            // we deliver groceries at your doorstep
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'We deliver fresh food at your doorstep',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSerif(
                    fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),

            // groceree gives you fresh vegetables and fruits
            Text(
              'Fresh Food Items everyday',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),

            const SizedBox(height: 24),

            const Spacer(),

            // get started button
            GestureDetector(
              // onTap: () => Get.to(() => const LoginOrRegisterPage()),

              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color.fromARGB(255, 112, 91, 222),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                /*   onPressed: () {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            ); 
                  }*/
              ),
              onTap: () => Get.to(() => const MainPage()),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
