import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_knee_23/log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
bool checkBoxValue=false;
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override

  State<SignUp> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUp> {
  final controller=TextEditingController();
  final controller1=TextEditingController();
  final controller2=TextEditingController();
  final controller3=TextEditingController();
  final controller4=TextEditingController();
  final controller5=TextEditingController();
  bool isDoc=true;

void Sign_up(){
  final _auth=FirebaseAuth.instance;
  final newUser=_auth.createUserWithEmailAndPassword(
      email: controller1.text,
      password: controller2.text
  );
  Add_user(controller.text, controller1.text, controller2.text, controller3.text,controller4.text,controller5.text);

}
void Add_user(String name,String email,String pass,String address,String phone,String age){
final _auth=FirebaseFirestore.instance;
 final user=_auth.collection('patients').add({
   'name':name,
   'email':email,
   'pass':pass,
   'address':address,
   'phone':phone,
   'age':age,
 });
}
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/knee_bg_wide.jpg'))),
            ),
          ),
          Container(
            height: 180.h,
            width: 200.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                    bottomLeft: Radius.circular(70)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(height: 20,),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                    Text(
                      "Back",
                      style: TextStyle(color: Colors.black, fontSize: 20.sp),
                    )
                  ],
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.black, fontSize: 30.sp),
                )
              ],
            ),
          ),
          Positioned(
            //top: 350,
            bottom: 0,
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Container(
              // height: MediaQuery.of(context).size.height*0.6,

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Create new Account",
                        style: TextStyle(
                          fontSize: 40.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                          child: Text("Already Registered? Login here")
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "NAME",
                          style: TextStyle(fontSize: 10.sp,),
                          //textAlign: TextAlign.left,
                        ),
                      ),
                      CustomField(controller),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "EMAIL",
                          style: TextStyle(fontSize: 10.sp,),
                          //textAlign: TextAlign.left,
                        ),
                      ),
                      CustomField(controller1),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "PASSWORD",
                          style: TextStyle(fontSize: 10.sp),
                        ),

                      ),
                      TextField(
                          controller: controller2,
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffD9D8D8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none))),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "YOUR COUNTRY",
                          style: TextStyle(fontSize: 10.sp,),
                          //textAlign: TextAlign.left,
                        ),
                      ),
                      CustomField(controller3),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "YOUR AGE",
                          style: TextStyle(fontSize: 10.sp,),
                          //textAlign: TextAlign.left,
                        ),
                      ),
                      CustomField(controller4),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 20.h,
                            width:MediaQuery.of(context).size.width*0.35,
                            child: CheckboxListTile(

                                value: isDoc,
                                title: Text("DOCTOR",style: TextStyle(fontSize: 8.sp),),
                                controlAffinity: ListTileControlAffinity.leading,


                                // activeColor: Colors.green,
                                checkColor: Colors.blue.shade900,
                                onChanged: (bool? value){
                                  if(value==true){

                                    setState(() {
                                      isDoc=true;
                                    });
                                  }else{
                                    setState(() {
                                      isDoc=false;
                                    });
                                  }

                                }),
                          ),
                          SizedBox(
                            height: 20.h,
                            width: MediaQuery.of(context).size.width*0.35,

                            child: CheckboxListTile(
                                value: !isDoc,
                                controlAffinity: ListTileControlAffinity.leading,

                                title: Text("PATIENT",style: TextStyle(fontSize: 8.sp),),

                                // activeColor: Colors.green,
                                checkColor: Colors.blue.shade900,
                                onChanged: (bool? value){
                                  setState(() {
                                    if(value == true){
                                      isDoc=false;
                                    }else{

                                      setState(() {
                                        isDoc=true;
                                      });
                                    }

                                  });
                                }),
                          )
                        ],
                      ),
                      SizedBox(height: 30.h,),
                      ElevatedButton(onPressed: (){
                        Sign_up();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },

                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff3E1E82),
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              minimumSize: Size(350, 60)
                          ),
                          child: Text("Sign Up")
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                          child: Text("Already Have Account?",style: TextStyle(color: Colors.black),)
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                          child: Text("Sign Up !",style: TextStyle(color: Color(0xff3E1E82)),))
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}


class CustomField extends StatelessWidget {
  TextEditingController controller;
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
