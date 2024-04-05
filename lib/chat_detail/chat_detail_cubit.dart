import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_chat_pie/chat_app_key.dart';
import 'package:package_chat_pie/chat_detail/chat_detail_state.dart';
import 'package:package_chat_pie/model/message_response.dart';
import 'package:piesocket_channels/channels.dart';

// import 'package:package_info_plus/package_info_plus.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  ChatAppCarDoctorUtilOption chatKey;
  String idSenderUser;
  // final void Function(String message) sendMessageCallback;
  ChatDetailCubit(
    this.chatKey,
    this.idSenderUser,
    // this.sendMessageCallback,
  ) : super(ChatDetailInitial());

  late PieSocketOptions options;
  late Channel channel;
  List<SendMessageResponse> listMessage = [];

  joinRoom() {
    options = PieSocketOptions();
    options.setClusterId(chatKey.cluseterID);
    // options.setApiKey("vmUe5lxo19WujTs0MsZxtVN3ZBa74SQx2nhFnDdt");
    options.setApiKey(chatKey.apiKey);
    PieSocket piesocket = PieSocket(options);
    channel = piesocket.join(chatKey.groupName);
    channel.listen("new_message", (PieSocketEvent event) {
      // print(event.toString());
      var messageSocket =
          SendMessageResponse.fromMap(json.decode(event.getData()));
      print('check var ${messageSocket}');
      emit(ChatDetailLoading());
      if (messageSocket.username != idSenderUser) {
        listMessage.add(messageSocket);
        print('add');
      } else {
        print('check status update');
        for (var message in listMessage) {
          if (message.attachmentType == messageSocket.attachment) {
            print('change status ${message.toJson().toString()}');
            message.groupId = messageSocket.groupId;
            break;
          }
        }
      }
      emit(UpdateMessage());
    });
  }

  addMessage(SendMessageResponse value) {
    emit(ChatDetailLoading());
    listMessage.add(value);
    // print('check add');
    // PieSocketEvent newMessage = PieSocketEvent("new_message");
    // newMessage.setData(json.encode(value));
    // //Publish event
    // channel.publish(newMessage);
    emit(ChatDetailGetDataSuccess());
  }
}
