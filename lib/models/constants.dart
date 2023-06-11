import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color kLogoDrk = const Color(0xFF222641);
Color kLogoLit = const Color(0xFF4942ce);
Color kPrimaryColor = const Color(0xFF00174d);
Color kHomeScreenColor = const Color(0xff0D235C);
Color kButtonColor = const Color(0xff3E1E82);
Color kBackgroundColor = const Color(0xffDBF3FF);

TextStyle kButtonTextStyle = TextStyle(fontSize: 18.sp, color: Colors.white);

BoxDecoration kGradientDecoration = const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment(0, 0),
    colors: [
      Color(0xFFfba867),
      //Color(0xFFff8a65),
      Color(0xFFc5cae9),
      // Color(0xFFfba867),
      Color(0xFF7986cb),
      Color(0xFFc5cae9),
    ],
  ),
);

BoxDecoration kGradientDecoration2 = const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
      Color(0xFFc5cae9),
      Color(0xffD4CFC8),
      // Color(0xFF7986cb),
      Color(0xFFdcf4ff),
      Color(0xffced5e8),
      Color(0xFFc5cae9),
      Color(0xFFc5cae9),
    ]));

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromRGBO(255, 255, 255, 1)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.6666667);
    path0.quadraticBezierTo(
        size.width * 0.45, size.height, size.width * 0.7, size.height * 0.7);
    path0.quadraticBezierTo(
        size.width, size.height * 0.35, size.width * 2 / 3, 0);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//SCRATCH DATA
class OldDoctorClass {
  final String name;
  final String department;
  final double rate;
  final String imgPath;
  final bool isFav;
  final int salary;

  OldDoctorClass(
      {required this.name,
      required this.department,
      required this.rate,
      required this.imgPath,
      required this.isFav,
      required this.salary});
}

List<String> urlList = [
  'https://youtu.be/ILgVZvYM1WI',
  'https://youtu.be/U_WjSAsyh-8',
  'https://youtu.be/y6NUWq_AEvI',
  'https://youtu.be/hXa9QIEGQPg',
  'https://youtu.be/wN__vnhknJw',
  'https://youtu.be/raSJqKjjUv0',
  'https://youtu.be/QPFRYUlXR2I',
  'https://youtu.be/OexLzyW8tXM',
  'https://youtu.be/sDz7uY5JdYs',
  'https://youtu.be/v4U6YE_BX08',
  'https://youtu.be/7SpA_0jLC0g',
  'https://youtu.be/CCwMevUe7lc',
];

List<OldDoctorClass> drList = [
  OldDoctorClass(
      name: 'Dr. Fillerup Garb',
      department: 'Medicine Specialist',
      rate: 3.7,
      imgPath:
          'https://as2.ftcdn.net/v2/jpg/02/82/72/13/1000_F_282721302_ASa8MKXhTukl1TnIxGl56eiOQkrvK5zL.jpg',
      isFav: false,
      salary: 25),
  OldDoctorClass(
      name: 'Dr. Blessing Ross',
      department: 'Dentist',
      rate: 4,
      imgPath:
          'https://as2.ftcdn.net/v2/jpg/02/69/98/91/1000_F_269989145_sP2OHMejODs0zrlkLWpB2zADAmTwljkT.jpg',
      isFav: true,
      salary: 18),
  OldDoctorClass(
      name: 'Dr. Crick Bong',
      department: 'Oncologist',
      rate: 3.5,
      imgPath:
          'https://as2.ftcdn.net/v2/jpg/01/70/97/49/1000_F_170974984_vTtMiYxyEyKgshyQqcdFLjQ0WkQFULEG.jpg',
      isFav: false,
      salary: 30),
  OldDoctorClass(
      name: 'Dr. Strain Oliver',
      department: 'Oncologist',
      rate: 4.8,
      imgPath:
          'https://as1.ftcdn.net/v2/jpg/01/32/94/46/1000_F_132944601_TzKWWNgwnBBsShz9UwWiUjTpoydpB5cV.jpg',
      isFav: true,
      salary: 35),
  OldDoctorClass(
      name: 'Dr. Lachinet Hades',
      department: 'Medicine Specialist',
      rate: 2.9,
      imgPath:
          'https://as2.ftcdn.net/v2/jpg/02/46/36/57/1000_F_246365778_4X1uXrRyBoFq79wr3flAMv3GDGdSjA6e.jpg',
      isFav: false,
      salary: 40),
];

List<String> availableTimes = [
  '01:00 PM',
  '02:00 PM',
  '03:00 PM',
  '04:00 PM',
  '05:00 PM',
  '06:00 PM',
  '07:00 PM',
  '08:00 PM',
  '09:00 PM',
  '10:00 PM',
  '11:00 PM',
  '12:00 AM',
  '08:00 AM',
  '09:00 AM',
  '10:00 AM',
  '11:00 AM',
  '12:00 PM',
];

List<String> remindTimes = [
  '10 minutes',
  '15 minutes',
  '20 minutes',
  '25 minutes',
  '30 minutes',
  '35 minutes',
  '40 minutes',
  '45 minutes',
  '50 minutes',
  '55 minutes',
  '1 hour',
  '1.5 hour'
];
