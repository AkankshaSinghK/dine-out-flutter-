 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage; 
  const LoginPage({Key? key,required this.showRegisterPage}):super(key:key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final textFieldFocusNode = FocusNode();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

   bool isHiddenPassword=true;
   void _togglePasswordView() {
    setState(()  {
        isHiddenPassword = !isHiddenPassword;
       
        if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
       textFieldFocusNode.canRequestFocus = false;  
      print(isHiddenPassword);
      print(textFieldFocusNode.context);
 
    });
   }
  
  

  Future signIn() async{
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    Get.snackbar("Logging in", "Succesful login",
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Success",
            style: TextStyle(color: Colors.white),
          ),)  ;
    }catch(e){
       Get.snackbar("About login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Log in failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));


    }
    
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

     double w = MediaQuery.of(context).size.width;
     double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 223, 195),
     // body: SafeArea(
       body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
             const SizedBox(height: 75),

              SizedBox(
            width: w*0.5,
            height: h*0.3,
            child:const CircleAvatar(
                  backgroundColor: Colors.white70,
                  radius:60,
                  backgroundImage: AssetImage(
                     "img/DineOut.png"
                     ),
                ),
      ),
         /* Text(
            "Hello Again!",
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
            "Welcome back, you\'ve been missed!",
          style:TextStyle(
            fontWeight:FontWeight.bold,
            fontSize:24,
          ),
          ),*/
           const SizedBox(height:50),

           Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: Container(
              decoration: BoxDecoration(
                color:Colors.grey[200],
                border: Border.all(color:Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child:Padding(
                padding:const EdgeInsets.only(left:20.0),
              child:TextField(
                controller:_emailController,
                decoration:const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                   prefixIcon: Icon(Icons.email_outlined,color:Color(0xFFF58434)),
                )
              )  
            ),
           ),
           ),

           const SizedBox(height:25),

           Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: Container(
              decoration: BoxDecoration(
                color:Colors.grey[200],
                border: Border.all(color:Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child:Padding(
                padding:const EdgeInsets.only(left:20.0),
              child:TextField(
               // obscureText:true,
                controller: _passwordController,
                obscureText: isHiddenPassword,
                focusNode: textFieldFocusNode,
                
                decoration:InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                   prefixIcon: const Icon(
                              Icons.lock_outline,color:Color.fromARGB(255, 243, 172, 101)
                            ),
                            suffixIcon: IconButton(
                              icon : isHiddenPassword ? const Icon( Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined),
                              onPressed: () {
                                
                                  _togglePasswordView();
                              }, ),
                )

              )
            ),
           ),
           ),

            const SizedBox(height:20),

           Padding(
             padding: const EdgeInsets.symmetric(horizontal:25.0),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return const ForgotPasswordPage();
                    },));
                  },
                   child: 
                     const Text('Forgot Password?',
                     style:TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                     )),
                   
                 ),
               ],
             ),
           ), 

           const SizedBox(height:20),

           Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child:GestureDetector(
              onTap:signIn,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  "Sign In",
                   style: TextStyle(color: Colors.white,
                   fontWeight: FontWeight.bold,
                   fontSize: 18,
                   ),
                ),
              ),

            ),
            ),
            ),

               const SizedBox(height:20),

               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not a member? ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: const Text(
                      "Register Now",
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