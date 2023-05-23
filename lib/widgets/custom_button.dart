import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: kButtonTextStyle,
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 17.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          )),
    );
  }
}
