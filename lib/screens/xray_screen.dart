import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:save_knee_23/widgets/bottom_sheet.dart';

import '../models/constants.dart';
import '../services/xray_classifier.dart';
import '../widgets/custom_appbar.dart';
import 'xray_result_screen.dart';

class XRayScreen extends StatefulWidget {
  @override
  State<XRayScreen> createState() => _XRayScreenState();
}

class _XRayScreenState extends State<XRayScreen> {
  File? _image;
  ImagePicker imagePicker = ImagePicker();
  late String result;

  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    _image = File(pickedFile!.path);
    result = await doImageClassification(_image);
    setState(() {
      _image;
    });
  }

  _imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    _image = File(pickedFile!.path);
    result = await doImageClassification(_image);
    setState(() {
      _image;
    });
  }

  @override
  void initState() {
    super.initState();
    loadModelFiles();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: CustomAppBar(
            title: 'Your X-ray',
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
              _image == null
                  ? CircleAvatar(
                      radius: 100.r,
                      backgroundColor: kHomeScreenColor,
                      child: CircleAvatar(
                        radius: 95.r,
                        backgroundImage:
                            const AssetImage('assets/images/bg_circle.png'),
                      ))
                  : Container(
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    gradient: LinearGradient(
                        colors: [kHomeScreenColor, Colors.black])),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kHomeScreenColor,
                        fixedSize: Size(220.w, 40.h)),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => CustomBottomSheet(
                                context,
                                galleryFunction: _imgFromGallery,
                                cameraFunction: _imgFromCamera,
                              ));
                    },
                    child: Text(
                      'Choose X-ray Image',
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    )),
              ),
              Spacer(flex: 1),
              Container(
                decoration: BoxDecoration(
                  color: kHomeScreenColor,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kHomeScreenColor,
                      fixedSize: Size(100.w, 15.h),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return XRayResultScreen(_image, result);
                      }));
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    )),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
