import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';

class Message {
  final User sender;
  final String time;
  final String text;
  final bool isliked;
  final bool unread;

  Message(
      {required this.isliked,
      required this.sender,
      required this.time,
      required this.text,
      required this.unread});
}

User mockUpUser1 = User(
    id: '0',
    name: 'Jorge Dennel',
    email: 'JorgeDennel@mail.com',
    phone: '06155648451',
    password: '1234',
    otp: '1234',
    validatePhone: true,
    cars: mockUpCar);
User mockUpUser2 = User(
    id: '1',
    name: 'John Cena',
    email: 'JorgeDennel@mail.com',
    phone: '06155648451',
    password: '1234',
    otp: '1234',
    validatePhone: true,
    cars: mockUpCar);
User mockUpUser3 = User(
    id: '2',
    name: 'Kevin Owen',
    email: 'JorgeDennel@mail.com',
    phone: '06155648451',
    password: '1234',
    otp: '1234',
    validatePhone: true,
    cars: mockUpCar);

List<Message> mockuoMsg = [
  Message(
      isliked: false,
      sender: mockUpUser1,
      text: 'Hello!',
      time: '3:15 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser2,
      text: 'Hi!',
      time: '3:15 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser1,
      text: 'What are you doing?',
      time: '3:16 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser2,
      text: 'I playing Varorant',
      time: '3:17 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser2,
      text: 'And you?',
      time: '3:17 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser1,
      text: 'Same, I playing Valorant.',
      time: '3:18 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser2,
      text: 'Okay, Can I you play with me? ',
      time: '3:18 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser2,
      text: 'sure!!',
      time: '3:20 PM',
      unread: true),
  Message(
      isliked: false,
      sender: mockUpUser1,
      text: 'Hello!',
      time: '3:15 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser2,
      text: 'Hi!',
      time: '3:15 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser1,
      text: 'What are you doing?',
      time: '3:16 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser2,
      text: 'I playing Varorant',
      time: '3:17 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser2,
      text: 'And you?',
      time: '3:17 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser1,
      text: 'Same, I playing Valorant.',
      time: '3:18 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser2,
      text: 'Okay, Can I you play with me? ',
      time: '3:18 PM',
      unread: false),
  Message(
      isliked: false,
      sender: mockUpUser2,
      text: 'sure!!',
      time: '3:20 PM',
      unread: true),
];
