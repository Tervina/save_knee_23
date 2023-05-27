import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_knee_23/screens/logo_screen.dart';
import 'package:save_knee_23/screens/starting_screen_2.dart';

import '../models/constants.dart';
import '../widgets/custom_button.dart';

class StartingScreen1 extends StatelessWidget {
  const StartingScreen1({Key? key}) : super(key: key);

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
                      'assets/images/bg_circle.png',
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
                              text: 'What is',
                              style: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\nKnee',
                                    style: TextStyle(
                                        fontSize: 35.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                                TextSpan(
                                  text: ' Osteoarthritis?',
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
                              "Osteoarthritis of the knee happens when cartilage in your knee joint breaks down. when this happens, the bones in your knee joint rub together, causing friction that makes your knees hurt, become stiff or swell. Osteoarthritis in the knee can't be cured but there are treatments that can relieve symptoms and slow your condition 's progress.",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          CustomButton(
                            text: 'Next',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StartingScreen2()));
                            },
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
