import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:save_knee_23/models/doctor_list_provider.dart';

import '../models/constants.dart';
import '../widgets/custom_appbar_2.dart';

List<DateTime?> _dates = [DateTime.now()];

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: kGradientDecoration,
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAppbar2(
                      text: 'Appointment',
                      onPressed: () {
                        //for debugging and testing
                        //print(_dates);
                        Navigator.pop(context);
                      }),
                  const CalenderBox(),
                  const TimePickBox()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CalenderBox extends StatelessWidget {
  const CalenderBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.indigo, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.18, 0.18])),
        child: CalendarDatePicker2(
          config: CalendarDatePicker2Config(
            firstDayOfWeek: 6,
            selectedDayHighlightColor: Colors.indigo,
          ),
          value: _dates,
          onValueChanged: (dates) => _dates = dates,
        ),
      ),
    );
  }
}

class TimePickBox extends StatelessWidget {
  const TimePickBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DrListProvider>(
        builder: (BuildContext context, drListProvider, Widget? child) {
      return ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.42,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('Available Time'),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.15,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: availableTimes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.h),
                        child: InkWell(
                          onTap: () {
                            drListProvider.setTimeListCounter(index);
                            /*setState(() {
                            _timeCounter = index;
                          });*/
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.indigo,
                            radius: 32.r,
                            child: CircleAvatar(
                              backgroundColor:
                                  drListProvider.timeListCounter == index
                                      ? Colors.indigo
                                      : Colors.white,
                              foregroundColor:
                                  drListProvider.timeListCounter == index
                                      ? Colors.white
                                      : Colors.indigo,
                              radius: 30.r,
                              child: Text(
                                availableTimes[index],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Text('Remind Me Before'),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.15,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: remindTimes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.h),
                        child: InkWell(
                          onTap: () {
                            drListProvider.setRemindListCounter(index);
                            /*setState(() {
                            _rmndCounter = index;
                          });*/
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.indigo,
                            radius: 32.r,
                            child: CircleAvatar(
                              backgroundColor:
                                  drListProvider.remindListCounter == index
                                      ? Colors.indigo
                                      : Colors.white,
                              foregroundColor:
                                  drListProvider.remindListCounter == index
                                      ? Colors.white
                                      : Colors.indigo,
                              radius: 30.r,
                              child: Text(
                                remindTimes[index],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () => _onAlertWithCustomImagePressed(context),
                    child: const Text('Confirm'))
              ],
            ),
          ),
        ),
      );
    });
  }
}

void _onAlertWithCustomImagePressed(context) {
  int tc = Provider.of<DrListProvider>(context, listen: false).timeListCounter;
  int rc =
      Provider.of<DrListProvider>(context, listen: false).remindListCounter;
  String date = DateFormat.MMMMEEEEd().format(_dates.last!);
  Alert(
    context: context,
    title: "Thank You!",
    desc:
        "You booked and appointment on $date at ${availableTimes[tc]}\n You will be reminded ${remindTimes[rc]} before your appointment",
    image: Image.asset(
      "assets/images/like.png",
      width: 150.w,
      height: 150.h,
    ),
  ).show();
}
