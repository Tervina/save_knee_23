import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  MyTextField({required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(height: 8.h),
          SizedBox(
            height: 50.h,
            width: 350.h,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                fillColor: Colors.black12,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20.r)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
