import 'package:flutter/material.dart';
import 'package:package_chat_pie/model/message_response.dart';

// ignore: must_be_immutable
class MessageText extends StatelessWidget {
  MessageText({
    super.key,
    required this.message,
    required this.isMe,
    required this.senderColor,
    required this.otherPeopleColor,
    required this.otherPeopleTextColor,
    required this.senderTextColor,
  });
  SendMessageResponse message;
  bool isMe;
  Color senderColor;
  Color otherPeopleColor;
  Color otherPeopleTextColor;
  Color senderTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 0, maxWidth: 300),
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        // SizedBox(width: 30,);
        color: isMe ? senderColor : otherPeopleColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message.originalMessage ?? '',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isMe ? senderTextColor : otherPeopleTextColor,
        ),
      ),
    );
  }
}
