import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_chat_pie/chat_app_key.dart';
import 'package:package_chat_pie/chat_detail/chat_detail_state.dart';
import 'package:package_chat_pie/model/message_response.dart';
import 'package:package_chat_pie/ultils/pick_image_video_utils.dart';
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
          if (message.attachmentType == messageSocket.attachmentType) {
            print('change status ${message.toJson().toString()}');
            message.groupId = messageSocket.groupId;
            message.createdAtStr = messageSocket.createdAtStr;
            message.updatedAtStr = messageSocket.updatedAtStr;
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

  Future<SendMessageResponse> chooseImage(String groupName) async {
    List<PlatformFile> multimedia = await PickImageVideoUtils.selectImages();
    print('check multi image ${multimedia}');
    var images = [];
    for (var e in multimedia) {
      var x = json.encode({
        'image': e.path,
      });
      images.add(x);
    }
    var message = SendMessageResponse(
      originalMessage:
          "{\"key\":\"${DateTime.now().millisecondsSinceEpoch}\",\"value\":null,\"valueImage\":$images,\"valueFiles\":null,\"valueServices\":[]}",
      attachmentType: '${DateTime.now().millisecondsSinceEpoch}',
      linkPreview: "",
      username: idSenderUser,
      groupName: groupName,
      type: 5,
    );
    addMessage(message);
    return message;
  }
}
