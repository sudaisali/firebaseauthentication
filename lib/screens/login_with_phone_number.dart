import 'package:firebaseauthentication/screens/otp.dart';
import 'package:firebaseauthentication/services/toast_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {


  bool loading = false;
  final phoneNumberController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  signinuser() {

      setState(() {
        loading = true;
      });
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumberController.text,
        verificationCompleted: (context){
           setState(() {
             loading = false;
           });
        },
        verificationFailed: (e){
        setState(() {
          loading = false;
        });
           ToastServices().showtoast(e.toString());
        },
        codeSent: (String verificationId , int? token){
          setState(() {
            loading = false;
          });
             Navigator.push(context, MaterialPageRoute(
                 builder:
                 (context)=>OTP(verificationId: verificationId,)));
        },
        codeAutoRetrievalTimeout: (e){
          setState(() {
            loading = false;
          });
          ToastServices().showtoast(e.toString());

        }

    );

          }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With phone number"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "+92318509377",
                    contentPadding: EdgeInsets.only(left: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),


              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  signinuser();
                },
                child: Container(
                  height: 40,
                  child: Center(child: loading == true?
                  CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ):Text("Sign in", style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),)),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

