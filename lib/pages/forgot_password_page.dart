import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email:_emailController.text.trim());
      showDialog(
        context: context,
         builder: (context){
          return const AlertDialog(
            content: Text('Password reset link send! Check your email.'
            ),
          );
         });
    } on FirebaseAuthException catch(e){
      print(e);
      showDialog(
        context: context,
         builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
         });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal:23.0),
            child: Text('Enter your email and we will send you reset password link',
            textAlign:TextAlign.center,
            style:TextStyle(fontSize:20),),
          ),
          const SizedBox(height: 20,),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            
              child:TextField(
                obscureText:true,
                controller: _emailController,
                decoration:InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white),
                     ),
                     focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.deepPurple),
                       ),
                  
                  hintText: "Email",
                   prefixIcon: const Icon(
                              Icons.email_outlined,color:Color.fromARGB(255, 243, 172, 101)                              
                            ),
                  fillColor: Colors.grey[200],
                  filled: true,
                )
              )
            ),
            const SizedBox(height: 10,),
            MaterialButton(onPressed: passwordReset,
            color: Colors.deepPurple[200],
            child:const Text('Reset Password') ,
            ),
        ],
      ),
    );
  }
}