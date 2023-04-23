import 'package:firebaseauthentication/services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.wait(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:Center(
        child: Text("SplashScreen",
        style: TextStyle(
          color: Colors.black26,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
