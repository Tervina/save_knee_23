import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_knee_23/models/doctor_class.dart';

import 'chatlist_data_class.dart';

class DrListProvider extends ChangeNotifier {
  final List<Doctor> _doctorList = [];
  final List<Doctor> _drChatList = [];
  int _timeListCounter = 0;
  int _remindListCounter = 0;

  // method to fetch doctors list from firebase
  void loadDrList() async {
    final db = FirebaseFirestore.instance;
    final drData = await db.collection('doctors').get();
    for (var data in drData.docs) {
      final Doctor doctor = Doctor(
        name: data['name'],
        email: data['email'],
        phone: data['phone'],
        imgPath: data['imgPath'],
        isFav: data['isFav'],
        rate: double.parse(data['rate']),
        salary: data['salary'],
      );
      _doctorList.add(doctor);
    }
    _doctorList.shuffle();
    //for debugging and testing
    print(_doctorList.length);
  }

  // method to fetch last contacted drs
  Future loadLstCntDrList() async {
    final _auth = FirebaseAuth.instance;
    final current_user = _auth.currentUser;
    final String currentUserName = current_user!.displayName!;
    final chat = FirebaseFirestore.instance;
    for (Doctor doctor in _doctorList) {
      final data = await chat
          .collection('chats')
          .doc(currentUserName)
          .collection(doctor.name)
          .get();
      if (data.docs.isEmpty) {
        //print('new chat');
      } else if (data.docs.isNotEmpty) {
        _drChatList.add(doctor);
        //print(data.docs.length);
      }
    }
    //for debugging and testing
    print(_drChatList.length);
  }

  // getter for the doctors list
  List<Doctor> get doctorList => _doctorList;

  List<Doctor> get drChatList => _drChatList;

  // fetch converstaions between dr and user
  Future<List<ChatListData>> getChatList() async {
    final _auth = FirebaseAuth.instance;
    final current_user = _auth.currentUser;
    final String currentUserName = current_user!.displayName!;
    List<ChatListData> chatListData = [];
    final chat = FirebaseFirestore.instance;

    for (Doctor doctor in _doctorList) {
      final data = await chat
          .collection('chats')
          .doc(currentUserName)
          .collection(doctor.name)
          .get();
      if (data.docs.isEmpty) {
        //print('new chat');
      } else if (data.docs.isNotEmpty) {
        final chatData = ChatListData(
          name: doctor.name,
          text: data.docs.last['text'],
          imgPath: doctor.imgPath,
        );
        chatListData.add(chatData);
        _drChatList.add(doctor);
        //print(data.docs.length);
      }
    }
    return chatListData;
  }

  // getter fot counters
  int get timeListCounter => _timeListCounter;

  int get remindListCounter => _remindListCounter;

  // setter for time counter
  void setTimeListCounter(int x) {
    _timeListCounter = x;
    notifyListeners();
  }

  // setter for remind counter
  void setRemindListCounter(int x) {
    _remindListCounter = x;
    notifyListeners();
  }
}
