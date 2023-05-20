//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/chat_model.dart';

import '../chat_model.dart';
import '../conversation_list.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Widget> chatBoxs=[];
  bool isLoaded=false;
 void getdrList()async{
    List doctorList=[];

    final _auth=FirebaseAuth.instance;
    final user=_auth.currentUser;
    final chat=FirebaseFirestore.instance;
    final eachUser=await chat.collection('doctors').get();
    for(var item in eachUser.docs){
     // print(item['name']);
      doctorList.add(item['name']);

    }
    for(var doctor in doctorList){
      final data =await chat.collection('chats').doc('Andrew Ashraf').collection(doctor).get();
      if(data.docs.isNotEmpty){
        final docChats=await chat.collection('chats').doc('Andrew Ashraf').collection(doctor).get();
        final text =docChats.docs.last;
        final ConversationList box=ConversationList(name: doctor, messageText:text['text'] , imageUrl: 'assets/images/doctor2.png', isMessageRead: true);
        chatBoxs.add(box);
      }
    }setState(() {
      isLoaded=true;
    });

  }
  List<ChatModel> chatModel = [
    ChatModel(
        name: "Dr/Mona Mady",
        messageText: "Hello,how are you now?",
        imageURL: "images/doctor2.png"),
    ChatModel(
        name: "Dr/Shimaa Elsawy",
        messageText: "Thank you",
        imageURL: "images/doctor3.png"),
    ChatModel(
        name: "Dr/Ramy",
        messageText: "Physiotherapy session on Thursday, waiting for you",
        imageURL: "images/doctor4.png"),
  ];
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdrList();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    final bodyHeight=screenHeight-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom;

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
                       color: Color(0xff0D235C),
                       size: 50,
                     ),
                     onPressed: (){
                       getdrList();
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
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
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
                   children: chatBoxs,
                ),
                replacement: CircularProgressIndicator(),
                visible: isLoaded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
