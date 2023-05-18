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
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    final bodyHeight=screenHeight-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                 Padding(
                  padding: EdgeInsets.only(left: 25).r,
                ),
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
                const Spacer(
                  flex: 2,
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
                const Spacer(
                  flex: 2,
                ),
                 Padding(
                    padding: const EdgeInsets.only(right: 30).r,
                    child: IconButton(
                      icon: Icon(
                        Icons.logout_outlined,
                        color: Color(0xff0D235C),
                        size: 50,
                      ),
                      onPressed: (){},
                    )),
              ],
            ),
            const Spacer(
              flex: 1,
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
            const Spacer(
              flex: 1,
            ),
            ListView.builder(
              itemCount: chatModel.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16).r,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatModel[index].name,
                  messageText: chatModel[index].messageText,
                  imageUrl: chatModel[index].imageURL,
                  isMessageRead:
                      (index == 0 && index == 1 && index == 2) ? true : false,
                );
              },
            ),
            const Spacer(
              flex: 15,
            ),
          ],
        ),
      ),
    );
  }
}
