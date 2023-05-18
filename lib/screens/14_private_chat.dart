//import 'dart:wasm';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore=FirebaseFirestore.instance;
final _auth=FirebaseAuth.instance;
final current_user=_auth.currentUser;
late User user;
class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  void getCurrentUser(){
    //final new_user=_auth.currentUser;

  }
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Message> messages = [
    Message(
      text: 'yes sure',
      date: DateTime.now().subtract(Duration(days: 3, minutes: 3)),
      isSentByMe: true,
      sender: current_user!.email!,
    ),
    Message(
      text: 'Helloooo',
      date: DateTime.now().subtract(Duration(days: 3, minutes: 4)),
      isSentByMe: false,
      sender: current_user!.email!,
    ),
    Message(
      text: 'how are you?',
      date: DateTime.now().subtract(Duration(days: 4, minutes: 7)),
      isSentByMe: true,
      sender: current_user!.email!,
    ),
    Message(
      text: 'fine',
      date: DateTime.now().subtract(Duration(days: 5, minutes: 3)),
      isSentByMe: false,
      sender: current_user!.email!,
    ),
    Message(
      text: 'Hiiii',
      date: DateTime.now().subtract(Duration(days: 6, minutes: 2)),
      isSentByMe: false,
      sender: current_user!.email!,
    ),
  ].reversed.toList();
  TextEditingController text_control = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    final bodyHeight=screenHeight-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20).r,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
            onPressed: () {},
          ),
        ),
        centerTitle: true,
        title: Text(
          "Dr/shimaa Elsawy",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 30).r,
              child: IconButton(
                icon: Icon(
                  Icons.logout_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 50,
                ),
                onPressed: () {},
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 12,
            child: GroupedListView(
              reverse: true,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              order: GroupedListOrder.DESC,
              elements: messages,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              padding: EdgeInsets.all(8).w,
              groupHeaderBuilder: (Message message) => SizedBox(
                height: .04*bodyHeight,
                child: Center(
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).w,
                      child: Text(
                        DateFormat.yMMMd().format(message.date),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12).w,
                    child: Text(message.text),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10).w,
              child: Container(
                height: .1*bodyHeight,
                child: TextField(
                  controller: text_control,
                  //TextEditingController(text: text_control.text),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20).w),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          final message = Message(
                              text: text_control.text,
                              date: DateTime.now(),
                              isSentByMe: true,
                            sender: current_user!.email!,
                          );
                          setState(() {
                            messages.add(message);
                            text_control.clear();
                          });
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        )),
                    contentPadding: EdgeInsets.all(20).w,
                    hintText: 'Type your message here',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                  onSubmitted: (text) {
                    final message = Message(
                        text: text, date: DateTime.now(), isSentByMe: true,sender: current_user!.email!,);
                    setState(() {
                      messages.add(message);
                      text_control.clear();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*
class Message {
  String text;
  DateTime date;
  bool isSentByMe;
  Message({required this.text, required this.date, required this.isSentByMe});
}*/

class Message extends StatelessWidget {
  Message({required this.sender,required this.text,required this.isSentByMe,required this.date});
  final bool isSentByMe;
  final String sender;
  final String text;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        crossAxisAlignment: isSentByMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender,style: TextStyle(
              fontSize: 12,
              color: Colors.black
          ),),
          Material(
            elevation:5.0,
            borderRadius: isSentByMe?BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)):
            BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
            ),
            color: isSentByMe?Colors.lightBlueAccent:Colors.white,
            child: Text('text from $sender',
              style: TextStyle(
                  fontSize: 15,
                  color: isSentByMe? Colors.white:Colors.black
              ),),
          ),
        ],
      ),
    );;
  }
}
