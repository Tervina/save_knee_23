import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_knee_23/screens/logo_screen.dart';

import '../models/constants.dart';

class StartingScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            decoration: kGradientDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogoScreen()));
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(color: kPrimaryColor),
                        textAlign: TextAlign.right,
                      ),
                    )),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 90.r,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/starting_screen_3.jpg',
                    ),
                    radius: 85.r,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 315.h,
                    // width: 1200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r)),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: '',
                              style: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\nEasy',
                                    style: TextStyle(
                                        fontSize: 35.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                                TextSpan(
                                  text: ' Appointments',
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "A program that provides you with the appropiate appointment for you and what you have booked . if you need to book an appointment.",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogoScreen()));
                            },
                            child: Text(
                              "Next",
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 55.w, vertical: 17.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
