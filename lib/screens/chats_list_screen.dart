import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save_knee_23/models/doctor_list_provider.dart';

import '../Widgets/conversation_box.dart';
import '../models/constants.dart';

class ChatsListScreen extends StatefulWidget {
  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  List<Widget> ConvList = [];
  bool isLoaded = false;
  final _auth = FirebaseAuth.instance;

  void updateConvList() async {
    List chatListData =
        await Provider.of<DrListProvider>(context, listen: false).getChatList();
    chatListData.forEach((data) {
      ConvList.add(ConversationBox(
        name: data.name,
        text: data.text,
        imgPath: data.imgPath,
      ));
    });
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    updateConvList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff073D97),
                      borderRadius: BorderRadius.circular(12).w,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Messages",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.logout_outlined,
                      color: kHomeScreenColor,
                      size: 50,
                    ),
                    onPressed: () {
                      _auth.signOut();
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatsListScreen()));
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8).w,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20).w,
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            SizedBox(
              height: 350,
              child: Visibility(
                child: ListView(
                  padding: const EdgeInsets.only(top: 16).r,
                  physics: const NeverScrollableScrollPhysics(),
                  children: ConvList,
                ),
                replacement: Center(
                  child: SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: CircularProgressIndicator()),
                ),
                visible: isLoaded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
