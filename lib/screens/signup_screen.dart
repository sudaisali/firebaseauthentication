import 'package:firebaseauthentication/services/toast_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();

  void createaccount(var email, var password) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setState(() {
          loading = false;
        });
        ToastServices().showtoast("Account Ceated Successfully");
      }).onError((error, stackTrace) {
        ToastServices().showtoast(error.toString());
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Signup"),
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
                onTap: () {
                  createaccount(email.text, password.text.toString());
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Center(
                      child: loading == true
                          ? CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            )
                          : Text("Signup")),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    "Already have Account Go TO Login",
                    style: TextStyle(color: Colors.lightBlue),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
