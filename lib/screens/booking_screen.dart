import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_knee_23/widgets/doctor_container_2.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/doctor_class.dart';
import '../widgets/custom_appbar_2.dart';
import 'appointment_screen.dart';

class BookingScreen extends StatelessWidget {
  final Doctor doctor;

  BookingScreen(this.doctor);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffDBF3FF),
        body: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppbar2(
                  text: 'Booking...',
                  onPressed: () {
                    //for debugging and testing
                    //print(_dates);
                    Navigator.pop(context);
                  }),
              DoctorContainer2(doctor),
              //ListView(),
              Text('data'),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2545F9),
                  fixedSize: Size(290.w, 50.h),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentScreen()));
                },
                child: Text(
                  "Next availability on wed, 24 Feb",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Text('OR'),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  //backgroundColor: Color(0xff2545F9),
                  fixedSize: Size(290.w, 50.h),
                ),
                onPressed: () {
                  launch("tel:${doctor.phone}");
                },
                child: Text(
                  "Contact Clinic",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color(0xff2545F9),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    /*return Scaffold(
      backgroundColor: const Color(0xffC7D6DD),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12).w,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50).r,
                child: Text(
                  "Select Time",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.only(left: 3).r,
            child: Container(
              height: .100 * bodyHeight,
              width: .700 * screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10).w,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5).r,
                    child: Container(
                      height: .095 * bodyHeight,
                      width: .1 * screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10).w,
                        image: const DecorationImage(
                          image: NetworkImage('assets/images/doctor2.png'),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dr.Mona",
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Knee Osteoarthritis Clinic",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.withOpacity(0.90),
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.star_outlined,
                            color: Colors.yellow,
                            size: 20.0,
                          ),
                          Icon(
                            Icons.star_outlined,
                            color: Colors.yellow,
                            size: 20.0,
                          ),
                          Icon(
                            Icons.star_outlined,
                            color: Colors.yellow,
                            size: 20.0,
                          ),
                          Icon(
                            Icons.star_outlined,
                            color: Colors.yellow,
                            size: 20.0,
                          ),
                          Icon(
                            Icons.star_outline_outlined,
                            size: 20.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16).r,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30).r,
              ),
              Container(
                height: .045 * bodyHeight,
                width: 12 * screenWidth,
                decoration: BoxDecoration(
                  color: const Color(0xffE9EEF2),
                  borderRadius: BorderRadius.circular(8).w,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Today, 23 Feb",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "No Slots available",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.withOpacity(0.90),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100).r,
                child: Container(
                  height: bodyHeight * .04,
                  width: screenWidth * .14,
                  decoration: BoxDecoration(
                    color: const Color(0xff1E8A6C),
                    borderRadius: BorderRadius.circular(8).w,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Tomorrow, 24 Feb",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "9 Slots available",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.withOpacity(0.90),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 150).r,
              ),
              Container(
                height: bodyHeight * .04,
                width: screenWidth * .14,
                decoration: BoxDecoration(
                  color: const Color(0xffE9EEF2),
                  borderRadius: BorderRadius.circular(8).w,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Thursday, 25 Feb",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "10 Slots available",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.withOpacity(0.90),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 150).r,
              ),
              Container(
                height: bodyHeight * .04,
                width: screenWidth * .14,
                decoration: BoxDecoration(
                  color: const Color(0xffE9EEF2),
                  borderRadius: BorderRadius.circular(8).w,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Friday, 23 Feb",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "11 Slots available",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.withOpacity(0.90),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Spacer(flex: 1),
          Center(
            child: Text(
              "Today, 23 Feb",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Center(
            child: Text(
              "No Slots available",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                color: Color(0xff9598AA),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2545F9),
                minimumSize: const Size(150, 70),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AppointmentScreen();
                }));
              },
              child: Text(
                "Next availability on wed, 24 Feb",
                style: TextStyle(
                  fontSize: 25.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontSize: 20.sp,
                color: Color(0xff9598AA),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffE2E9EF),
                minimumSize: const Size(400, 70),
              ),
              onPressed: () {},
              child: Text(
                "Contact Clinic",
                style: TextStyle(
                  fontSize: 25.sp,
                  color: Color(0xff2545F9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );*/
  }
}
