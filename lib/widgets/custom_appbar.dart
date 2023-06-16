import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Function onPressed;

  CustomAppBar({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: const Color(0xffE2E2E2),
        elevation: 0.0,
        leadingWidth: 70.w,
        leading: Center(
          child: Ink(
            height: 100.h,
            width: 100.w,
            decoration:
                ShapeDecoration(shape: CircleBorder(), color: kHomeScreenColor),
            child: IconButton(
              onPressed: () {
                onPressed();
              },
              icon: Icon(Icons.arrow_back_outlined,
                  size: 40.sp, color: Colors.white),
            ),
          ),
        ),
        toolbarHeight: 160.h,
        title: Center(
          child: Container(
            decoration: BoxDecoration(
                color: kHomeScreenColor,
                borderRadius: BorderRadius.circular(35.r)),
            height: 45.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 22.sp)),
              ],
            ),
          ),
        ));
  }
}
