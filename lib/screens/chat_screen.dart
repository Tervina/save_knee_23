//import 'dart:wasm';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_knee_23/screens/logo_screen.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final current_user = _auth.currentUser;
late User loggedInUser;

class ChatScreen extends StatelessWidget {
  final String otherUserName;

  ChatScreen({required this.otherUserName});

  final String currentUserName =
      FirebaseAuth.instance.currentUser!.displayName!;

  void getMessages() async {
    final messages = await _fireStore.collection('chats').get();
    for (var message in messages.docs) {
      print(message.data);
    }
  }

  void messagesStream() async {
    await for (var snapShot in _fireStore.collection('chats').snapshots()) {
      for (var message in snapShot.docs) {}
    }
  }

  TextEditingController text_control = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bodyHeight = screenHeight -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20).r,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.blue.shade900,
              size: 50,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          otherUserName,
          style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 30).r,
              child: IconButton(
                icon: Icon(
                  Icons.logout_outlined,
                  color: Colors.blue.shade900,
                  size: 50,
                ),
                onPressed: () {
                  _auth.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogoScreen()));
                },
              )),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: MesaageStream(currentUserName, otherUserName)),
          Container(
            height: .1 * bodyHeight,
            child: Padding(
              padding: const EdgeInsets.all(10).w,
              child: TextField(
                controller: text_control,
                //TextEditingController(text: text_control.text),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue.shade900,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20).w),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        _fireStore
                            .collection('chats')
                            .doc(currentUserName)
                            .collection(otherUserName)
                            .add({
                          'isSentByMe': true,
                          'text': text_control.text,
                          'timeStamp': DateTime.now().toString(),
                        });
                        text_control.clear();
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
  Message({
    required this.text,
    required this.isSentByMe,
    required this.timeStamp,
    required this.curruntUserName,
    required this.otherUserName,
  });

  final bool isSentByMe;
  final String text;
  final String timeStamp;
  final String curruntUserName;
  final String otherUserName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment:
            isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 5.0,
            borderRadius: isSentByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isSentByMe ? Colors.blue.shade900 : Colors.grey.shade400,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 15,
                    color: isSentByMe ? Colors.white : Colors.black),
              ),
            ),
          ),
          Text(
            timeStamp,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
    ;
  }
}

class MesaageStream extends StatelessWidget {
  final String curruntUserName;
  final String otherUserName;

  MesaageStream(this.curruntUserName, this.otherUserName);

  @override
  Widget build(BuildContext context) {
    var chats = _fireStore
        .collection('chats')
        .doc(curruntUserName)
        .collection(otherUserName)
        .orderBy('timeStamp', descending: true);

    return StreamBuilder<QuerySnapshot>(
        stream: chats.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepPurple,
              ),
            );
          }
          final messages = snapshot.data!.docs;
          List<Message> message_list = [];
          for (var item in messages) {
            final isSentByMe = item['isSentByMe'];
            final text = item['text'];
            final timeStamp = item['timeStamp'];
            final messageBubble = Message(
              text: text,
              isSentByMe: isSentByMe,
              timeStamp: timeStamp,
              curruntUserName: curruntUserName,
              otherUserName: otherUserName,
            );
            message_list.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              reverse: true,
              children: message_list,
            ),
          );
        });
  }
}
