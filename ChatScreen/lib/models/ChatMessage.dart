import 'package:flutter/material.dart';

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isMe ;
  final bool isSameUser;


  ChatMessage({
    this.text,
    @required this.messageType,
    @required this.messageStatus,
    @required this.isMe,
    @required this.isSameUser,

  });
}

List demeChatMessages = [
  ChatMessage(
    text: "Čus",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isMe: true,
    isSameUser: false,
  ),
  ChatMessage(
    text: "Jak je?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isMe: true,
    isSameUser: true,
  ),


  ChatMessage(
    text: "Ujde to",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isMe: false,
    isSameUser: true,
  ),
    ChatMessage(
    text: "",
    messageType: ChatMessageType.image,
    messageStatus: MessageStatus.not_view,
    isMe: true,
    isSameUser: false,),

        ChatMessage(
    text: "Co na to říkáš?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_sent,
    isMe: true,
    isSameUser: true,),
    

];
