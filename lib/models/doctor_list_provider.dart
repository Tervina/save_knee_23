import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:save_knee_23/models/chatlist_data_class.dart';
import 'package:save_knee_23/models/doctor_class.dart';

class DrListProvider extends ChangeNotifier {
  List<Doctor> _doctorList = [];

  // methid ti fetch doctors list from firebase
  void loadDrList() async {
    final _db = FirebaseFirestore.instance;
    final _drData = await _db.collection('doctors').get();
    for (var data in _drData.docs) {
      final Doctor doctor = Doctor(
        name: data['name'],
        email: data['email'],
        phone: data['phone'],
        imgPath: data['imgPath'],
        isFav: data['isFav'],
        rate: data['rate'],
        salary: data['salary'],
      );
      _doctorList.add(doctor);
    }
    //for debugging and testing
    //print(_doctorList.length);
  }

  // getter for the doctors list
  List<Doctor> get doctorList => _doctorList;

  // fetch converstaions between dr and user
  Future<List<ChatListData>> getChatList() async {
    List<ChatListData> chatListData = [];
    final _auth = FirebaseAuth.instance;
    final chat = FirebaseFirestore.instance;

    for (Doctor doctor in _doctorList) {
      final data = await chat
          .collection('chats')
          .doc('Andrew Ashraf')
          .collection(doctor.name)
          .get();
      if (data.docs.isEmpty) {
        print('new chat');
      } else if (data.docs.isNotEmpty) {
        final chatData = ChatListData(
          name: doctor.name,
          text: data.docs.last['text'],
          imgPath: doctor.imgPath,
        );
        chatListData.add(chatData);
        print(data.docs.length);
      }
    }
    return chatListData;
  }
}
