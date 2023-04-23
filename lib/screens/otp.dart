import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthentication/screens/post_screen.dart';
import 'package:firebaseauthentication/services/toast_services.dart';
import 'package:flutter/material.dart';

class OTP extends StatefulWidget {
  final verificationId;
  const OTP({Key? key , required this.verificationId}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  bool loading  = false;
  final otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  verifyuser()async{
    setState(() {
      loading = true;
    });
    final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text.toString());
    try{
      await _auth.signInWithCredential(credential);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));

    }catch(e){
      setState(() {
        loading = false;
      });
      ToastServices().showtoast(e.toString());

    }

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
                controller: otpController,
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
                 verifyuser();
                },
                child: Container(
                  height: 40,
                  child: Center(child: loading == true?
                  CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 5,
                  ):Text("Verify", style: TextStyle(
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
