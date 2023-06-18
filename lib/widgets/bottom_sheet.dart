import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/constants.dart';

class CustomBottomSheet extends StatelessWidget {
  BuildContext context;
  final Function galleryFunction;
  final Function cameraFunction;

  CustomBottomSheet(this.context,
      {required this.galleryFunction, required this.cameraFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff101010), kHomeScreenColor, Colors.black])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Container(
                height: 30.h,
                width: 180.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    gradient: LinearGradient(colors: [
                      Colors.black,
                      Color(0xff0D235C),
                      Colors.black87
                    ])),
                child: Center(
                    child: Text(
                  'Please Choose Image',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ))),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    InkWell(
                        onTap: () {
                          galleryFunction();
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image(
                              image: AssetImage('assets/images/gallery.png'),
                              height: 70.h),
                        )),
                    Text(
                      "Gallery",
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                        onTap: () {
                          cameraFunction();
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0).w,
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image(
                              image: AssetImage('assets/images/camera.png'),
                              height: 70.h),
                        )),
                    Text(
                      "Camera",
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
