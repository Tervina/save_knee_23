import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbar2 extends StatelessWidget {
  final String text;
  final Function onPressed;

  CustomAppbar2({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
            padding: EdgeInsets.zero,
            minWidth: 30.w,
            height: 30.h,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            color: Colors.white,
            onPressed: () {
              onPressed();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 15.sp,
            )),
        Text(
          text,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
