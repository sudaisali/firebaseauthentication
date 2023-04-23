import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthentication/screens/login_with_phone_number.dart';
import 'package:firebaseauthentication/screens/post_screen.dart';
import 'package:firebaseauthentication/screens/signup_screen.dart';
import 'package:firebaseauthentication/services/toast_services.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  bool loading =false;
  final email = TextEditingController();
  final password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  void loginaccount(var email , var password){

    _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((value){
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PostScreen()));

    }).onError((error, stackTrace){
      ToastServices().showtoast(error.toString());
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: "Enter Email",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: "Enter password",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    loginaccount(email.text , password.text.toString());
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue
                    ),
                    child: Center(child: loading == true ?
                    CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ):Text("Login")),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(8),
                child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>Signup()));
                    },
                    child: Text("Donot have account Sign up",
                      style: TextStyle(
                          color: Colors.lightBlue
                      ),)),
              ),
              Padding(
                  padding: EdgeInsets.all(2),
                child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context)=>LoginWithPhoneNumber()));
                    },
                    child: Text("Login with mobile number?",
                      style: TextStyle(
                          color: Colors.lightBlue
                      ),)),
              ),
            ],
          ),
        ),

    );
  }
}
