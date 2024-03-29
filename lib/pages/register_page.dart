// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_out/auth/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final textFieldFocusNode = FocusNode();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  var password = '';
  var confirmPass = '';

  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;
  bool passwordMatched = false;
  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;

      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;
      print(isHiddenPassword);
      print(textFieldFocusNode.context);
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      isHiddenConfirmPassword = !isHiddenConfirmPassword;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;
      print(isHiddenConfirmPassword);
      print(textFieldFocusNode.context);
    });
  }

  void passwordConfirmMatch() async {
    var pass = _passwordController.text.trim();
    var confPass = _confirmpasswordController.text.trim();
    if (pass != confPass) {
      print("Password does not match. Please re-type again.");
    } else {
      passwordMatched = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
        final auth = Get.put(AuthController());
        bool isRegistered = await auth.register(
            _emailController.text.trim(), _passwordController.text.trim());
        if (isRegistered) {
          addUserDetails(
            _nameController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text.trim(),
            _confirmpasswordController.text.trim(),
          );
          print("Sign up success");
          Get.snackbar(
            "Signing in",
            "Succesful Register",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM,
            titleText: const Text(
              "Register Successful ",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      
    }else{
    Get.snackbar('Password Match', 'message',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Confirm Password and Password does not match",
            style: TextStyle(color: Colors.white),
          ));
   }
  }

  Future addUserDetails(String Name, String Email, String Password,
      String confirmPassword) async {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'name': Name,
      'email': Email,
      'password': Password,
      'confirmpassword': confirmPassword,
    })
    .then((value) => print("User Added"))
    .catchError( (error) => print("Failed to add user")) ;
    
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                   Container(
              height: 350,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -20,
                    height: 180,
                    width: w,
                    child:Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('img/background.png'),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                  ),
                  Positioned(
                    height: 180,
                    width: w+20,
                    child:Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('img/background-2.png'),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                  ),Positioned
                  (
                    left: 50,
                    top: 170,
                    height:200,
                    width:w*0.7,
                    child: Container(
                     width: w*0.5,
                    height: h*0.10,
                    
                  decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('img/DineOut.png'),
                fit: BoxFit.cover
              )),
                                  
                        ),
                  ),

                ],

              ),
            ),
              
               SizedBox(height: h * 0.05),
              // SizedBox(
              //   width: w * 0.5,
              //   height: h * 0.3,
              //   child: CircleAvatar(
              //     backgroundColor: Colors.white70,
              //     radius: 60,
              //     backgroundImage: AssetImage("img/DineOut.png"),
              //   ),
              // ),
              /* Text(
            "Hello There ",
          style: GoogleFonts.bebasNeue(
            fontSize:52
          ),
          /*TextStyle(
            fontWeight:FontWeight.bold,
            fontSize:24,
          ),*/
          ),
          SizedBox(height:10),
          Text(
            "Register below with your details ",
          style:TextStyle(
            fontWeight:FontWeight.bold,
            fontSize:24,
          ),
          ),*/
              
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        hintText: "Name",
                        prefixIcon: Icon(Icons.account_circle_outlined,
                            color: Colors.deepPurple),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ))),
              SizedBox(height: 15),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email_outlined,
                            color: Colors.deepPurple),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ))),
              SizedBox(height: 15),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      //obscureText:true,
                      obscureText: isHiddenPassword,
                      controller: _passwordController,
                      onChanged: (value) {
                        password = value;
                      },
                      focusNode: textFieldFocusNode,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock_outline,
                            color: Colors.deepPurple),
                        suffixIcon: IconButton(
                          icon: isHiddenPassword
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility_outlined),
                          onPressed: () {
                            _togglePasswordView();
                          },
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ))),
              SizedBox(height: 15),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      //obscureText:true,
                      obscureText: isHiddenConfirmPassword,
                      controller: _confirmpasswordController,
                      onChanged: (value) {
                        confirmPass = value;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        hintText: "Confirm Password",
                        fillColor: Colors.grey[200],
                        filled: true,
                        prefixIcon: Icon(Icons.password_outlined,
                            color: Colors.deepPurple),
                        suffixIcon: IconButton(
                          icon: isHiddenConfirmPassword
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility_outlined),
                          onPressed: () {
                            _toggleConfirmPasswordView();
                          },
                        ),
                      ))),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    signUp();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account!  ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(
                      "Login Now",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          )),
    );
  }
}
