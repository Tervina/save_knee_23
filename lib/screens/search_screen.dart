import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_knee_23/models/constants.dart';
import 'package:save_knee_23/screens/booking_screen.dart';

class SearchScreen extends StatelessWidget {
  final List<OldDoctorClass> result;

  SearchScreen(this.result);

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bodyHeight = screenHeight -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffDBF3FF),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff073D97),
                      borderRadius: BorderRadius.circular(12).w,
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
                      "Messages",
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
                      size: 50,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8).w,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20).w,
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            SizedBox(
              height: 500.h,
              child: ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return DoctorContainer(result[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 200.h,
        width: 350.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).w,
                      image: const DecorationImage(
                          image: AssetImage('assets/images/doctor2.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Text(
                    "Next Availabilty",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.sp,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "10:00",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "AM tomorrow",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.90),
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr.Mona",
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Orthopedist",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "6 Years experience",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey.withOpacity(0.90),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.r),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.grey,
                      size: 24.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.r),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2545F9),
                        minimumSize: const Size(50, 40),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BookingScreen();
                        }));
                      },
                      child: Text(
                        "Book now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorContainer extends StatelessWidget {
  final OldDoctorClass doctor;

  DoctorContainer(this.doctor);

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
                      child: Image.network(
                        doctor.imgPath,
                        fit: BoxFit.fill,
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
                      doctor.department,
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
                            onPressed: () {},
                            child: Text(
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
