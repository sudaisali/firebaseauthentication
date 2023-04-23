import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthentication/screens/post_screen.dart';
import 'package:firebaseauthentication/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class SplashServices{
  void wait(BuildContext context){
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if(user!= null){
      Timer(const Duration(seconds: 5), ()=> {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder:
                    (context)=>const PostScreen()
            )
        )
      });
    }else{
      Timer(const Duration(seconds: 5), ()=> {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder:
                    (context)=>const Signup()
            )
        )
      });
    }

  }
}