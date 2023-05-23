import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../models/constants.dart';

class MyImagePicker extends StatelessWidget {
  late ImagePicker imagePicker;
  File? _image;

  MyImagePicker(this._image);

  _imgFromCamera(File? _image) async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    File image = File(pickedFile!.path);
    //result = await doImageClassification(_image);
    _image = image;
  }

  _imgFromGallery(File? _image) async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    File image = File(pickedFile!.path);
    //result = await doImageClassification(_image);
    _image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff101010), kHomeScreenColor, Colors.black])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Container(
                height: 24.h,
                width: 180.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    gradient: LinearGradient(colors: [
                      Colors.black,
                      Color(0xff0D235C),
                      Colors.black87
                    ])),
                child: Center(
                    child: Text(
                  'Please Choose Image',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ))),
          ),
          Row(
            children: [
              Column(
                children: [
                  InkWell(
                      onTap: () {
                        _imgFromGallery(_image);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0).w,
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, left: 60),
                          child: Image(
                              image: AssetImage('assets/images/gallery.png'),
                              height: 64.h),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 65, top: 8),
                    child: Text(
                      "Gallery",
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                      onTap: () {
                        _imgFromCamera(_image);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0).w,
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Padding(
                          padding: EdgeInsets.only(top: 32, left: 125),
                          child: Image(
                              image: AssetImage('assets/images/camera.jpg'),
                              height: 48),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 125, top: 16),
                    child: Text(
                      "Camera",
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
