import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:save_knee_23/screens/home_screen.dart';

import '../models/constants.dart';
import '../models/doctor_list_provider.dart';
import '../services/user_auth.dart';
import '../widgets/text_field.dart';
import 'login_Screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final String profilePicCtrl = 'assets/images/user_profile_pic.jpg';
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  File? _image;
  bool showSpinner = false;

  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    _image = File(pickedFile!.path);
    setState(() {
      _image;
    });
  }

  _imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    _image = File(pickedFile!.path);
    setState(() {
      _image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/knee_bg_wide.jpg'))),
            ),
            Container(
              height: 160.h,
              width: 180.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70.r),
                      bottomRight: Radius.circular(70.r),
                      bottomLeft: Radius.circular(70.r)),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back)),
                      Text(
                        "Back",
                        style: TextStyle(color: Colors.black, fontSize: 20.sp),
                      )
                    ],
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            Positioned(
              //top: 350,
              bottom: 0,
              height: MediaQuery.of(context).size.height * 0.69,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.r),
                        topLeft: Radius.circular(40.r))),
                child: Padding(
                  padding: EdgeInsets.all(40.h),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Create new Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 48.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text("Already Registered? Login here")),
                        MyTextField(title: 'FULL NAME', controller: nameCtrl),
                        MyTextField(title: 'EMAIL', controller: emailCtrl),
                        MyTextField(title: 'PASSWORD', controller: passCtrl),
                        MyTextField(title: 'PHONE', controller: phoneCtrl),
                        MyTextField(title: 'AGE', controller: ageCtrl),
                        MyTextField(title: 'CITY', controller: cityCtrl),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Text('Add Profile Picture: '),
                            IconButton(
                                onPressed: () => _imgFromCamera(),
                                icon: Icon(Icons.camera_alt)),
                            IconButton(
                                onPressed: () => _imgFromGallery(),
                                icon: Icon(Icons.image)),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              //create new user
                              try {
                                await userCreate(
                                  nameCtrl: nameCtrl,
                                  emailCtrl: emailCtrl,
                                  passCtrl: passCtrl,
                                  phoneCtrl: phoneCtrl,
                                  profilePicFile: _image,
                                  ageCtrl: ageCtrl,
                                  cityCtrl: cityCtrl,
                                );

                                await Provider.of<DrListProvider>(context)
                                    .loadLstCntDrList();
                                //navigate to home screen
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              } on Exception catch (e) {
                                print(e);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kButtonColor,
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20.sp),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r)),
                                minimumSize: Size(250.w, 50.h)),
                            child: Text("Sign Up")),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
