import 'package:flutter/material.dart';
import 'package:speetch_to_text_use/res/res.dart';

class AppStyles {
  static final inputStyle = TextStyle(
    fontSize: 32.0,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );
  static final inputCommandStyle = TextStyle(
    fontSize: 32.0,
    color: AppColors.green,
    fontWeight: FontWeight.w400,
  );

  static final buttonStyle = ElevatedButton.styleFrom(
    primary: Colors.blueAccent,
  );
}
