// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }):super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final textFieldFocusNode = FocusNode();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  var password='';
  var confirmPass = '';

   bool isHiddenPassword=true;
  bool isHiddenConfirmPassword = true;
  bool passwordMatched = false;
  void _togglePasswordView() {
    setState(()  {
        isHiddenPassword = !isHiddenPassword;
       
        if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
       textFieldFocusNode.canRequestFocus = false;  
      print(isHiddenPassword);
      print(textFieldFocusNode.context);
 
    });

}
void _toggleConfirmPasswordView() {
    setState(()  {
       
        isHiddenConfirmPassword = !isHiddenConfirmPassword;
        if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
       textFieldFocusNode.canRequestFocus = false;  
      print(isHiddenConfirmPassword);
      print(textFieldFocusNode.context);
 
    });
}
void passwordConfirmMatch()async {

  var pass = _passwordController.text.trim();
  var confPass = _confirmpasswordController.text.trim();
 if(pass!=confPass){
  print("Password does not match. Please re-type again.");
 } else {
 
    passwordMatched = true;
 
  
    }
}
  
  @override
  void dispose(){
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future signUp() async{
    if (passwordConfirmed()) {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    addUserDetails(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _confirmpasswordController.text.trim(),

    );
  }
}

Future addUserDetails(String Name, String Email,String Password,String confirmPassword ) async{
  await FirebaseFirestore.instance.collection('users').add({
    'name':Name,
    'email':Email,
    'password':Password,
    'confirmpassword':confirmPassword,

  });
}

 bool passwordConfirmed(){
  if(_passwordController.text.trim()== _confirmpasswordController.text.trim()){
    return true;
  }else{
    return false;
  }
 }
  
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
     double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
             SizedBox(height: h*0.05),
             SizedBox(
            width: w*0.5,
            height: h*0.3,
            child:CircleAvatar(
                  backgroundColor: Colors.white70,
                  radius:60,
                  backgroundImage: AssetImage(
                     "img/DineOut.png"
                     ),
                ),
      ),
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
           SizedBox(height:30),

            Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            
              child:TextField(
                controller: _nameController,
                decoration:InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                     ),
                     focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.deepPurple),
                       ),
                  
                  hintText: "Name",
                   prefixIcon: Icon(Icons.account_circle_outlined,color:Color.fromARGB(255, 243, 172, 101)),
                  fillColor: Colors.grey[200],
                  filled: true,
                )
              )
            ),

             SizedBox(height:25),

         Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            
              child:TextField(
                controller: _emailController,
                decoration:InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                     ),
                     focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.deepPurple),
                       ),
                  
                  hintText: "Email",
                   prefixIcon: Icon(
                              Icons.email_outlined,color:Color.fromARGB(255, 243, 172, 101)                              
                            ),
                  fillColor: Colors.grey[200],
                  filled: true,
                )
              )
            ),

           SizedBox(height:25),

           Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            
              child:TextField(
                //obscureText:true,
                 obscureText: isHiddenPassword,
                controller: _passwordController,
                 onChanged: (value) {
                          password = value;
                        },
                        focusNode: textFieldFocusNode,
                decoration:InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                     ),
                     focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.deepPurple),
                       ),
                  
                  hintText: "Password",
                   prefixIcon: Icon(
                              Icons.lock_outline,color:Color.fromARGB(255, 243, 172, 101)
                            ),
                            suffixIcon: IconButton(
                              icon : isHiddenPassword ? Icon( Icons.visibility_off_outlined) : Icon(Icons.visibility_outlined),
                              onPressed: () {
                                
                                  _togglePasswordView();
                              }, ),
                  fillColor: Colors.grey[200],
                  filled: true,
                )
              )
            ),
           


           SizedBox(height:20),

             Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            
              child:TextField(
                //obscureText:true,
                 obscureText: isHiddenConfirmPassword,
                controller: _confirmpasswordController,
                 onChanged: (value) {
                          confirmPass = value;
                        },
                decoration:InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                     ),
                     focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.deepPurple),
                       ),
                  
                  hintText: "Confirm Password",
                  fillColor: Colors.grey[200],
                  filled: true,
                   prefixIcon: Icon(Icons.password_outlined,color:Color.fromARGB(255, 243, 172, 101)),
                            suffixIcon: IconButton(
                              icon : isHiddenConfirmPassword ? Icon( Icons.visibility_off_outlined) : Icon(Icons.visibility_outlined),
                              onPressed: () {
                                
                                  _toggleConfirmPasswordView();
                              }, ),
                )
              )
            ),

           SizedBox(height:20),

           Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child:GestureDetector(
              onTap:signUp,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Sign Up",
                   style: TextStyle(color: Colors.white,
                   fontWeight: FontWeight.bold,
                   fontSize: 18,
                   ),
                ),
              ),

            ),
            ),
            ),

               SizedBox(height:20),

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


        ]

        ),
      )
      ),
    );
  }
}