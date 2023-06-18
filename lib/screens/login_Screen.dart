import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:save_knee_23/models/constants.dart';
import 'package:save_knee_23/models/doctor_list_provider.dart';
import 'package:save_knee_23/screens/signup_screen.dart';
import 'package:save_knee_23/widgets/text_field.dart';

import '../services/user_auth.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            //Background
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/knee_bg_wide.jpg'))),
            ),
            //Corner Containter
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
                    "Login",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            //main container
            Positioned(
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
                          "Login",
                          style: TextStyle(
                            fontSize: 48.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        MyTextField(title: 'EMAIL', controller: emailCtrl),
                        MyTextField(title: 'PASSWORD', controller: passCtrl),
                        SizedBox(height: 10.h),
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                await userLogin(emailCtrl, passCtrl);
                                await Provider.of<DrListProvider>(context,
                                        listen: false)
                                    .loadLstCntDrList();
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
                            child: Text("Login")),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.sp),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: Text(
                              "SignUp !",
                              style: TextStyle(
                                  color: kButtonColor, fontSize: 15.sp),
                            ))
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

class CustomField extends StatelessWidget {
  final TextEditingController controller;

  CustomField(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffD9D8D8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none)));
  }
}
