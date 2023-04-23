import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ToastServices{
  void showtoast(var message){
    Fluttertoast.showToast(msg: message);
  }
}