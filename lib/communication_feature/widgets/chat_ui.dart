import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/message_model.dart';
import 'package:rodsiaapp/main.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatUi extends StatefulWidget {
  ChatUi({Key? key}) : super(key: key);

  @override
  _ChatUiState createState() => _ChatUiState();
}

class _ChatUiState extends State<ChatUi> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    socketServer();
  }

  void socketServer() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
    socket.connect();
    socket.onConnect((data) => print('connected-socketIO'));
    socket.onDisconnect((data) => logger.d('disconnected'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 3.0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.call),
            )
          ],
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: textColorBlack),
          title: Text(
            'Garage1892',
            style: TextStyle(
                color: textColorBlack,
                fontSize: fontSizeXl,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: mockuoMsg.length,
                    itemBuilder: (context, index) {
                      final Message msg = mockuoMsg[index];
                      final isMe = msg.sender.id == mockUpUser1.id;
                      return _buildMsg(msg, isMe);
                    })),
            _buildMsgComposer()
          ],
        ));
  }

  _buildMsg(Message msg, bool isMe) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: isMe
              ? EdgeInsets.only(top: 4, left: 110, right: 15)
              : EdgeInsets.only(top: 4, right: 110, left: 15),
          decoration: BoxDecoration(
              boxShadow: [boxShadow],
              color: isMe ? textColorBlack : primaryColor,
              borderRadius: isMe
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))
                  : BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              msg.text,
              style: TextStyle(
                  color: isMe ? primaryColor : textColorBlack,
                  fontSize: fontSizeM - 1),
            ),
          ),
        ),
        Padding(
          padding:
              isMe ? EdgeInsets.only(right: 15) : EdgeInsets.only(left: 15),
          child: Text(
            msg.time + "  " + (msg.unread ? '...' : 'Read'),
            style: TextStyle(fontSize: fontSizeS - 2),
          ),
        ),
      ],
    );
  }

  _buildMsgComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 50,
      decoration: BoxDecoration(color: bgColor, boxShadow: [boxShadow]),
      child: Row(
        children: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.camera_alt),
          //   color: primaryColor,
          //   iconSize: 23,
          // ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.image),
            color: textColorBlack,
            iconSize: 23,
          ),
          Expanded(
              child: TextField(
            style: TextStyle(color: textColorBlack),
            decoration: InputDecoration.collapsed(
                hintText: tSentMsg + '...',
                hintStyle: TextStyle(color: textColorBlack)),
          )),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
            ),
            color: textColorBlack,
            iconSize: 23,
          )
        ],
      ),
    );
  }
}
