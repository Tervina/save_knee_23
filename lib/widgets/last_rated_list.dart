import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/doctor_class.dart';
import '../models/doctor_list_provider.dart';

class LstRtdList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Doctor> drList =
        Provider.of<DrListProvider>(context, listen: false).doctorList;
    List<Doctor> newDrList = drList..shuffle();
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: newDrList.length,
      itemBuilder: (BuildContext context, int index) {
        double rate = newDrList[index].rate as double;
        return InkWell(
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: 180.h,
                color: Colors.white,
                child: Column(
                  children: [
                    Image.network(
                      newDrList[index].imgPath,
                      fit: BoxFit.fill,
                      height: 130.h,
                    ),
                    SizedBox(height: 5.h),
                    Text(newDrList[index].name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Text(newDrList[index].email,
                        style: TextStyle(fontSize: 12.sp)),
                    RatingBarIndicator(
                      rating: rate,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.sp,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
