import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_knee_23/screens/chats_list_screen.dart';

import '../models/constants.dart';
import '../widgets/custom_appbar.dart';
import 'home_screen.dart';

class XRayResultScreen extends StatelessWidget {
  final File? _image;
  final String result;

  XRayResultScreen(this._image, this.result);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: CustomAppBar(
            title: 'Your Result',
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/test_bg.jpg'),
                fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 3),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: kHomeScreenColor),
                ),
                child: Image.file(
                  _image!,
                  width: 180.w,
                  height: 180.h,
                  fit: BoxFit.fill,
                ),
              ),
              Spacer(flex: 2),
              Container(
                height: 40.h,
                width: MediaQuery.of(context).size.width * .75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0).w,
                    gradient: LinearGradient(
                        colors: [kHomeScreenColor, Colors.black])),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$result',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Spacer(flex: 1),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }));
                          },
                          icon: Icon(Icons.home,
                              size: 40.sp, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }));
                          },
                          icon: Icon(Icons.ondemand_video,
                              size: 40.sp, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }));
                          },
                          icon: Icon(Icons.menu_book_outlined,
                              size: 40.sp, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChatsListScreen();
                            }));
                          },
                          icon: Icon(Icons.chat_bubble_outline,
                              size: 40.sp, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
