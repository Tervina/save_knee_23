
import 'package:save_knee_23/constants.dart';

import 'package:save_knee_23/screens/07_home_page.dart';
import 'package:save_knee_23/screens/08_time_table.dart';
import 'package:save_knee_23/screens/10_xray.dart';
import 'package:save_knee_23/screens/12_emg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as https;
import 'package:save_knee_23/screens/14_private_chat.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icons_plus/icons_plus.dart';

import '15_chat_page.dart';
late User user;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final searchController=TextEditingController();
 final user =FirebaseAuth.instance.currentUser;
List<Doctor> result=[];
SearchDoc(String value){
  result.clear();
  for(Doctor doctor in drList){
    if(doctor.name.contains(value)){
      result.add(doctor);
    }
  }
}
  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    final bodyHeight=screenHeight-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat,color: Color(0xff0D235C)), label: " Chat"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.xRay,color: Color(0xff0D235C),), label: "X-Ray"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.fileWaveform,color: Color(0xff0D235C),), label: "EMG")
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
            // only scroll to top when current index is selected.
              if (_selectedIndex == index) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return ChatPage();
                    }));
              }
              break;
            case 1:
              if (_selectedIndex == index) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return xray();
                    }));
              }
              break;
            case 2:
              if (_selectedIndex == index) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return emg();
                    }));
              }
              break;
          }
          setState(
                () {
              _selectedIndex = index;
            },
          );
        },
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
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
                      ])),
            ),
            Container(
              height: bodyHeight*.17,
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Color(0xff949398),
                color: Color(0xff0D235C),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30).w,
                    bottomRight: Radius.circular(30).w),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15).w,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: bodyHeight*.05,
                    ),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Hi...!${user!.email!}",
                                  style: TextStyle(
                                    color: Color(0xfffec102),
                                    fontSize: 25.sp,
                                  )),
                              Text(
                                "Find Your Doctor",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                          ),
                        ]),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 2.w, horizontal: 0.h),
                      child: SizedBox(
                        height: bodyHeight*.045,
                        child: TextField(
                          controller: searchController,
                          onChanged: (value){

                            SearchDoc(value);
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: IconButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return HomePage(result);
                                  }));
                                },
                               icon:Icon(Icons.search) ,
                                color: Colors.blue.shade900,
                              ),
                              suffixIcon: Icon(
                                Icons.close,
                                color: Colors.grey,
                              ),
                              hintText: "Search....",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10).w,
                              )),
                        ),
                      ),
                    ),
                    Text(
                      "Continue Excercising",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
                    ),
                    SizedBox(
                      height: bodyHeight*.01,
                    ),
                    Container(
                      height: bodyHeight*.2,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: urlList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MyCard(urlList[index]);
                        },
                      ),
                    ),
                    Text(
                      "Last Related Doctors",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
                    ),
                    Container(
                      height: 200.h,

                      /*decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),*/
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: drList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DoctorCard(
                              imgPath: drList[index].imgPath,
                              name: drList[index].name,
                              department: drList[index].department,
                              rate: drList[index].rate,
                            myFunction: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeTable()));
                            },
                          );
                        },
                      ),
                    ),
                    Text(
                      "Last Contacted Doctors",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
                    ),
                    Container(
                      height: bodyHeight*.4,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: drList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ContactedDoc(
                                rate:drList[index].rate,
                                imgPath:drList[index].imgPath,
                                salary:drList[index].salary.toString(),
                                name:drList[index].name,myFunction: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat()));
                            },);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget MyCard(String url) {
  String id = url.substring(url.length - 11);
  String urlLink = "https://img.youtube.com/vi/${id}/0.jpg";
  return GestureDetector(
    onTap: () {
      launchUrl(Uri.parse(url));
    },
    child: Card(
      child: Image.network("${urlLink}"),
    ),
  );
}



class DoctorCard extends StatelessWidget {
 final String imgPath;
 final String name;
 final String department;
 final double rate;
 final Function myFunction;
 DoctorCard({required this.imgPath, required this.name, required this.department, required this.rate, required this.myFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: GestureDetector(
        onTap:(){
          myFunction();
        }

        ,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20).w,
          child: Container(
            // height: 50,
            color: Color(0xffeaeaea),
            width: 170.w,

            /*decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Color(0xffeaeaea)
                //0xffD9DAD6)
                //(0xffE5E1DA),
                ),*/
            child: Column(
              children: [
                Image.network(imgPath,height: 110.h,fit: BoxFit.fitHeight,),
                Padding(
                  padding: const EdgeInsets.only(top: 1.5).w,
                  child: Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                  ),
                ),
                Text(department),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0).w,
                  child: RatingBarIndicator(
                    rating: rate,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 30,
                    direction: Axis.horizontal,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ContactedDoc extends StatelessWidget {
  final double rate;
  final String imgPath;
  final String salary;
  final String name;
  final Function myFunction;
  ContactedDoc({ required this.rate, required this.imgPath, required this.salary, required this.name,required this.myFunction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20).w,
        child: GestureDetector(
          onTap: (){
            myFunction();
          },
          child: Container(
            color: Color(0xffeaeaea),
            width: 170.w,
            child: Padding(
              padding: const EdgeInsets.all(10).w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.favorite_border, color: Colors.red),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(rate.toString()),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: NetworkImage(imgPath),
                  ),
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                  ),
                  Text(
                    "\$ ${salary}/hours",
                    style: TextStyle(color: Colors.grey, fontSize: 20.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
