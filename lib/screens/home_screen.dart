import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:save_knee_23/models/constants.dart';
import 'package:save_knee_23/screens/search_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/fetch_thumbnails.dart';
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
  List<OldDoctorClass> result = [];
  int _selectedIndex = 0;

  SearchDoc(String value) {
    result.clear();
    for (OldDoctorClass doctor in drList) {
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
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    //Top bar
                    SizedBox(
                      height: 100.h,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Hi, ${user!.displayName}!",
                                    style: TextStyle(
                                      color: Color(0xfffec102),
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(
                                  "Find Your Doctor",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35.sp,
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
                                backgroundImage: NetworkImage(user!.photoURL!),
                              ),
                            ),
                          ]),
                    ),
                    //Search Field
                    SizedBox(
                      height: 50.h,
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) => SearchDoc(value),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: IconButton(
                              onPressed: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SearchScreen(result);
                              })),
                              icon: Icon(Icons.search),
                              color: Colors.blue.shade900,
                            ),
                            suffixIcon: Icon(Icons.close, color: Colors.grey),
                            hintText: "Search....",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.r),
                            )),
                      ),
                    ),
                    // Scroll View
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.669,
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
                                height: 120.h,
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

class RollList extends StatelessWidget {
  final double height;
  final String label;
  final bool hasSeeAllButton;
  final Widget tile;

  RollList(
      {required this.height,
      required this.label,
      required this.hasSeeAllButton,
      required this.tile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
              ),
              TextButton(
                  onPressed: () {},
                  child: hasSeeAllButton ? Text('see all >') : Text('')),
            ],
          ),
          SizedBox(
            height: height,
            child: tile,
          )
        ],
      ),
    );
  }
}

class ExcVidList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: urlList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.white70, BlendMode.hue),
                    child: Image.network(
                      getYoutubeThumbnail(urlList[index]),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Icon(
                    Icons.play_circle_outline_sharp,
                    color: Color.fromRGBO(255, 255, 255, 30),
                    size: 30,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LstRtdList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: drList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 180,
                color: Colors.white,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      drList[index].imgPath,
                      fit: BoxFit.fill,
                      height: 130,
                    ),
                    SizedBox(height: 5),
                    Text(drList[index].name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Text(drList[index].department,
                        style: TextStyle(fontSize: 12)),
                    RatingBarIndicator(
                      rating: drList[index].rate,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
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

class LstCntList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: drList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 90,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            drList[index].isFav
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                            size: 15,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 15),
                              Text(drList[index].rate.toString(),
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 25,
                        foregroundImage: NetworkImage(drList[index].imgPath),
                      ),
                      Text(
                        drList[index].name,
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                      Text("\$ ${drList[index].salary} / hours",
                          style: TextStyle(fontSize: 8, color: Colors.green)),
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

  DoctorCard(
      {required this.imgPath,
      required this.name,
      required this.department,
      required this.rate,
      required this.myFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: GestureDetector(
        onTap: () {
          myFunction();
        },
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
                Image.network(
                  imgPath,
                  height: 110.h,
                  fit: BoxFit.fitHeight,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1.5).w,
                  child: Text(
                    name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
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

  ContactedDoc(
      {required this.rate,
      required this.imgPath,
      required this.salary,
      required this.name,
      required this.myFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20).w,
        child: GestureDetector(
          onTap: () {
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
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
