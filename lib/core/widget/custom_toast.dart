import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

customToast({required String title, Color? color}) {
  Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color ?? Colors.black,
      textColor: Colors.white,
      fontSize: 18);
}
