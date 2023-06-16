import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_knee_23/models/constants.dart';

import '../models/doctor_class.dart';
import '../widgets/doctor_container_1.dart';

class SearchScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final List<Doctor> result;

  SearchScreen(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(20.h),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff073D97),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.logout_outlined,
                      color: kHomeScreenColor,
                      size: 50.sp,
                    ),
                    onPressed: () {
                      _auth.signOut();
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20.sp,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8.h),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            SizedBox(
              height: 500.h,
              child: ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) =>
                      DoctorContainer1(result[index])),
            ),
          ],
        ),
      ),
    );
  }
}
