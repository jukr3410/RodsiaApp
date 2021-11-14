import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatState {
  final String activeRoom;
  final String userSender;
  final String userReceiver;
  final String userType;
  final List<Map<String, dynamic>> messages;

  ChatState(
      {required this.activeRoom,
      required this.messages,
      required this.userSender,
      required this.userReceiver,
      required this.userType});
}
