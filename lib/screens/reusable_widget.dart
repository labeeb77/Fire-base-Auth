
import 'package:firebase_auth_sample/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

LottieBuilder signUpLotti(String path){
    return Lottie.asset(path,
    fit: BoxFit.fitWidth,
    width: 180,
    height: 240
    );
  }


  TextField reusableTextField(String text, IconData icon,bool isPasswordType,TextEditingController controller){
    return TextField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions:! isPasswordType,
      autocorrect:! isPasswordType,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(icon,color: Colors.white70,),
        labelText: text,
        labelStyle: TextStyle(color:  Colors.white.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0,style: BorderStyle.none)
        )
      ),
      keyboardType: isPasswordType
         ? TextInputType.visiblePassword
         : TextInputType.emailAddress,
    );
  }

  Container signUpButton(BuildContext context,bool isLogin,Function onTap){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90)
      ),
      child: ElevatedButton(
        onPressed: (){
          onTap();
        },
           style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if(states.contains(MaterialState.pressed)){
                return Colors.black26;
              }
              return Colors.white;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
            )
          ),
         child: Text(
          isLogin? 'LOG IN':'SIGN IN',
          style: const TextStyle(
            color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 16
          ),
        
         ),),
         
    );
  }

  Row signUpOption(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",style: TextStyle(color: Colors.white70),),
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen(),));
          },
          child:  const Text(" Sign Up",style: TextStyle(
            color: Colors.white,fontWeight: FontWeight.bold
          ),),
        )
      ],
    );
  }