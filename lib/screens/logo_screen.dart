import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_knee_23/screens/signup_screen.dart';

import '../models/constants.dart';
import 'login_Screen.dart';

class LogoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    try {
      FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', scale: 0.85),
                SizedBox(height: 15.h),
                Text(
                  'SAVE\nKnee',
                  style: TextStyle(
                    color: kLogoLit,
                    fontFamily: 'Benson',
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'get better yourself',
                  style: TextStyle(color: kLogoLit, fontSize: 15.sp),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kLogoDrk,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kLogoLit),
                        minimumSize:
                            MaterialStateProperty.all(Size(220.w, 50.h)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0.r),
                            side: BorderSide(color: kLogoLit)))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text('Login', style: kButtonTextStyle),
                  ),
                  SizedBox(height: 15.h),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kLogoDrk),
                        minimumSize:
                            MaterialStateProperty.all(Size(220.w, 50.h)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0.r),
                          side: BorderSide(color: kLogoLit, width: 3.w),
                        ))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text('Sign Up', style: kButtonTextStyle),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
