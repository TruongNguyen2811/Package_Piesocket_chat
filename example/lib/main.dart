import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:package_chat_pie/chat_detail/chat_detail.dart';
import 'package:package_chat_pie/model/message_response.dart';
import 'package:package_chat_pie/chat_app_key.dart';
import 'package:piesocket_channels/channels.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<SendMessageResponse> listMessage = [];
  late PieSocketOptions options;
  late Channel channel;
  ChatAppCarDoctorUtilOption data = ChatAppCarDoctorUtilOption(
      apiKey: 'y5sUErrtnWyif3LddZ97aXJ4xDi8sbkL91g1p3xa',
      apiSecret: 'YBjSTOa65xpWIWYtpbTkLlhik0IBDDfW',
      cluseterID: 'free.blr2',
      getNotifySelf: '1',
      groupName: 'GR_1697178354776',
      userIDReal: 'CarDoctor447GARAGE_OWNER');

  @override
  void initState() {
    super.initState();
    options = PieSocketOptions();
    options.setClusterId(data.cluseterID);
    // options.setApiKey("vmUe5lxo19WujTs0MsZxtVN3ZBa74SQx2nhFnDdt");
    options.setApiKey(data.apiKey);

    PieSocket piesocket = PieSocket(options);
    channel = piesocket.join(data.groupName);
  }

  addMessage(SendMessageResponse value) async {
    await Future.delayed(Duration(milliseconds: 1000));
    value.groupId = 1;
    print('check add');
    PieSocketEvent newMessage = PieSocketEvent("new_message");
    newMessage.setData(json.encode(value));
    //Publish event
    channel.publish(newMessage);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChatDetail(
      titleChatName: 'Báo Đốm',
      idSenderUser: 'CarDoctor447GARAGE_OWNER',
      chatKey: data,
      listMessage: listMessage,
      pressSend: (contentMessage) {
        addMessage(contentMessage);
      },
      loadMoreHistory: () {
        print('loadmoreHistory');
        setState(() {
          listMessage.insertAll(0, [
            SendMessageResponse(
                originalMessage: 'kkk',
                username: 'CarDoctor447GARAGE_OWNER',
                groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(
                originalMessage: 'kkk',
                username: 'CarDoctor447GARAGE_OWNER',
                groupId: 1),
            SendMessageResponse(
                originalMessage: "muhaha",
                username: 'CarDoctor447GARAGE_OWNER',
                groupId: 1),
          ]);
        });
      },
      loadMoreNewHistory: () {
        setState(() {
          print('loadmoreNewHistory');
          listMessage.addAll([
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
            SendMessageResponse(originalMessage: '123', groupId: 1),
          ]);
        });
      },
    ));
  }
}
