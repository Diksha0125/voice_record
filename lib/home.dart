import 'package:flutter/material.dart';
import 'package:text_voice_record/chat_model.dart';
import 'package:text_voice_record/textField.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Di", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey David, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ];

  Widget get body => GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            // ListView.builder(
            //   itemCount: messages.length,
            //   shrinkWrap: true,
            //   padding: EdgeInsets.only(top: 10, bottom: 20),
            //   physics: NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) {
            //     return Container(
            //       padding:
            //           EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
            //       child: Align(
            //         alignment: (messages[index].messageType == "receiver"
            //             ? Alignment.topLeft
            //             : Alignment.topRight),
            //         child: Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             color: (messages[index].messageType == "receiver"
            //                 ? Colors.grey.shade200
            //                 : Colors.blue[200]),
            //           ),
            //           padding: EdgeInsets.all(16),
            //           child: Text(
            //             messages[index].messageContent,
            //             style: TextStyle(fontSize: 15),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
            CustomTxtField()
          ],
        ),
      );

  Widget get appBar => AppBar(
        backgroundColor: Colors.blueGrey[800],
        leading: Row(
          children: [
            Icon(
              Icons.arrow_back,
              size: 18,
            ),
            SizedBox(width: 6),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            )
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('David Beckham'),
            SizedBox(height: 2),
            Text(
              "last seen today at 3:00",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            )
          ],
        ),
        actions: [
          Icon(Icons.videocam_outlined),
          SizedBox(width: 20),
          Icon(Icons.call),
          SizedBox(width: 10),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: appBar,
      body: body,
    );
  }
}
