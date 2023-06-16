import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/doctor_class.dart';

class DoctorContainer2 extends StatelessWidget {
  final Doctor doctor;

  const DoctorContainer2(this.doctor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: Container(
        height: 150.h,
        width: 350.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r), color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Row(
            children: [
              Column(
                children: [
                  SizedBox(
                      height: 90.h,
                      width: 90.w,
                      child: Hero(
                        tag: doctor.name,
                        child: Image.network(
                          doctor.imgPath,
                          fit: BoxFit.fill,
                        ),
                      )),
                  Text(
                    "Next Avalability",
                    style:
                        TextStyle(color: Colors.blue.shade900, fontSize: 14.sp),
                  ),
                  Text(
                    "10 AM tomorrow",
                    style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                  )
                ],
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          doctor.name,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          doctor.isFav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    Text(
                      doctor.email,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingBarIndicator(
                        itemSize: 20.sp,
                        rating: doctor.rate,
                        itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
