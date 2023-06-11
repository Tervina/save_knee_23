import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_knee_23/screens/booking_screen.dart';

import '../models/doctor_class.dart';

class DoctorContainer1 extends StatelessWidget {
  final Doctor doctor;

  const DoctorContainer1(this.doctor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 150.h,
        width: 350.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                children: [
                  SizedBox(
                      height: 100.h,
                      width: 100.w,
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
                        TextStyle(color: Colors.blue.shade900, fontSize: 15.sp),
                  ),
                  Text(
                    "10 AM tomorrow",
                    style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                  )
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          doctor.name,
                          style: TextStyle(
                            fontSize: 20.sp,
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
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BookingScreen(doctor)));
                            },
                            child: const Text(
                              "Book Now",
                            )),
                      ],
                    )
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
