import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save_knee_23/screens/chat_screen.dart';

import '../models/doctor_class.dart';
import '../models/doctor_list_provider.dart';

class LstCntList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Doctor> newDrList =
        Provider.of<DrListProvider>(context, listen: false).drChatList;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: newDrList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return ChatScreen(otherUserName: newDrList[index].name);
            }));
          },
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: 90.w,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            newDrList[index].isFav
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                            size: 15.sp,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star,
                                  color: Colors.orange, size: 15.sp),
                              Text(newDrList[index].rate.toString(),
                                  style: TextStyle(fontSize: 12.sp)),
                            ],
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 30.sp,
                        foregroundImage: NetworkImage(newDrList[index].imgPath),
                      ),
                      Text(
                        newDrList[index].name,
                        style: TextStyle(fontSize: 10.sp),
                        textAlign: TextAlign.center,
                      ),
                      Text("\$ ${newDrList[index].salary} / hours",
                          style:
                              TextStyle(fontSize: 8.sp, color: Colors.green)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
