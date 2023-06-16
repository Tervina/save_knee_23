import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:save_knee_23/models/constants.dart';
import 'package:save_knee_23/models/doctor_list_provider.dart';
import 'package:save_knee_23/screens/search_screen.dart';

import '../models/doctor_class.dart';
import '../widgets/last_contacted_list.dart';
import '../widgets/last_rated_list.dart';
import '../widgets/roll_list.dart';
import '../widgets/video_list.dart';
import 'chats_list_screen.dart';
import 'emg_screen.dart';
import 'xray_screen.dart';

late User user;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final User user = FirebaseAuth.instance.currentUser!;
  List<Doctor> result = [];
  int _selectedIndex = 0;

  //new dr list
  updateSearchList(String value) {
    result.clear();
    for (Doctor doctor
        in Provider.of<DrListProvider>(context, listen: false).doctorList) {
      if (doctor.name.contains(value)) {
        result.add(doctor);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: kHomeScreenColor),
              label: " Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.xRay, color: kHomeScreenColor),
              label: "X-Ray",
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(FontAwesomeIcons.fileWaveform, color: kHomeScreenColor),
              label: "EMG",
            )
          ],
          onTap: (int index) {
            switch (index) {
              case 0:
                // only scroll to top when current index is selected.
                if (_selectedIndex == index) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return ChatsListScreen();
                  }));
                }
                break;
              case 1:
                if (_selectedIndex == index) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return XRayScreen();
                  }));
                }
                break;
              case 2:
                if (_selectedIndex == index) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return EMGScreen();
                  }));
                }
                break;
            }
            setState(
              () => _selectedIndex = index,
            );
          },
        ),
        body: Stack(
          children: [
            //Background
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: kGradientDecoration2,
            ),
            //Top Background Bar
            Container(
              height: MediaQuery.of(context).size.height * .21,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kHomeScreenColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
              ),
            ),
            //Home screen
            Padding(
              padding: EdgeInsets.only(
                  top: 20.h, right: 20.w, left: 20.w, bottom: 2.h),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    //Top bar
                    SizedBox(
                      height: 100.h,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Hi, ${user.displayName}!",
                                    style: TextStyle(
                                      color: const Color(0xfffec102),
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w500,
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
                            InkWell(
                              onLongPress: () {
                                _auth.signOut();
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                              },
                              child: CircleAvatar(
                                radius: 30.r,
                                backgroundImage: NetworkImage(user.photoURL!),
                              ),
                            ),
                          ]),
                    ),
                    //Search Field
                    SizedBox(
                      height: 50.h,
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) => updateSearchList(value),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: IconButton(
                              onPressed: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SearchScreen(result);
                              })),
                              icon: const Icon(Icons.search),
                              color: Colors.blue.shade900,
                            ),
                            suffixIcon:
                                const Icon(Icons.close, color: Colors.grey),
                            hintText: "Search....",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.r),
                            )),
                      ),
                    ),
                    // Scroll View
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.63,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            RollList(
                                height: 100.h,
                                label: 'Continue Excercising',
                                hasSeeAllButton: false,
                                tile: ExcVidList()),
                            RollList(
                                height: 200.h,
                                label: 'Last Rated Doctors',
                                hasSeeAllButton: true,
                                tile: LstRtdList()),
                            RollList(
                                height: 150.h,
                                label: 'Last Contacted Doctors',
                                hasSeeAllButton: true,
                                tile: LstCntList()),
                          ],
                        ),
                      ),
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
