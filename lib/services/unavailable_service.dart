import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

unavailableService(context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('This service isn\'t available yet!',
          style: TextStyle(fontSize: 15.sp)),
      duration: const Duration(milliseconds: 1800),
      width: 300.w,
      // Width of the SnackBar.
      padding: EdgeInsets.all(16.w),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.r),
      ),
    ),
  );
}
