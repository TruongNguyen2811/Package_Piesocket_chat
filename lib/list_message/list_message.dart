import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_chat_pie/list_message/widget/message_multimedia.dart';
import 'package:package_chat_pie/list_message/widget/message_text.dart';
import 'package:package_chat_pie/model/form_item.dart';
import 'package:package_chat_pie/model/message_response.dart';
import 'package:package_chat_pie/ultils/utils.dart';
import 'package:package_chat_pie/widget/custom_cache_image.dart';

// ignore: must_be_immutable
class BuildMessage extends StatefulWidget {
  SendMessageResponse message;
  bool isMe;
  Color senderColor;
  Color otherPeopleColor;
  Color senderTextColor;
  Color otherPeopleTextColor;
  BuildMessage({
    super.key,
    required this.message,
    required this.isMe,
    required this.senderColor,
    required this.otherPeopleColor,
    required this.senderTextColor,
    required this.otherPeopleTextColor,
  });

  @override
  State<BuildMessage> createState() => _BuildMessageState();
}

class _BuildMessageState extends State<BuildMessage> {
  bool hidden = false;
  @override
  Widget build(BuildContext context) {
    List<String> images = [];

    if (widget.message.type == 5) {
      var x = FormData.fromJson(json.decode(widget.message.originalMessage!));
      for (var e in x.valueImage!) {
        images.add(e.image!);
      }
    }
    if (widget.message.type == 7) {
      var x = FormData.fromJson(json.decode(widget.message.originalMessage!));
      images.add(x.urlVideo!);
    }
    return Column(
      children: [
        if (hidden) const SizedBox(height: 4),
        if (hidden)
          Text(
            Utils.formatMessageDate(widget.message.createdAtStr ?? ''),
            // Utils.formatMessageDate(widget.data.createdAtStr!),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromRGBO(175, 177, 175, 1),
              fontSize: 12,
            ),
          ),
        if (hidden) const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment:
                widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!widget.isMe) ...[
                CustomCacheImageWidget(
                  imageUrl:
                      'https://upload.aggregatoricapaci.com/cardoctor-dev/2024/04/chat-data/image_picker_2CF7CF37-B723-4D8C-88A9-4BBF082E3225-86736-000029FFE4616977_7812000.jpg',
                  height: 32,
                  // width: 32,
                  isCircle: true,
                ),
                // SizedBox(
                //   width: 8,
                // )
              ],
              Column(
                crossAxisAlignment: widget.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (widget.message.type == null) ...[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          hidden ? hidden = false : hidden = true;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: widget.isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          MessageText(
                            message: widget.message,
                            isMe: widget.isMe,
                            senderColor: widget.senderColor,
                            otherPeopleColor: widget.otherPeopleColor,
                            senderTextColor: widget.senderTextColor,
                            otherPeopleTextColor: widget.otherPeopleTextColor,
                          ),
                          if (hidden && (widget.message.groupId != null)) ...[
                            const SizedBox(height: 4),
                            const Text(
                              'Đã gửi',
                              // Utils.formatMessageDate(widget.data.createdAtStr!),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color.fromRGBO(175, 177, 175, 1),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                          ]
                        ],
                      ),
                    ),
                  ],
                  if (widget.message.type == 5) ...[
                    Container(
                      constraints: BoxConstraints(
                          minWidth: 0,
                          maxWidth: images.length == 1 ? 160 : 246),
                      child: MediaGridview(
                        mediaURLs: images,
                        type: MediaGridviewType.grid,
                        width: images.length == 1 ? 160 : 246,
                      ),
                    )
                  ],
                  if (widget.message.type == 7) ...[
                    Container(
                      constraints: BoxConstraints(
                          minWidth: 0,
                          maxWidth: images.length == 1 ? 160 : 246),
                      child: MediaGridview(
                        mediaURLs: images,
                        type: MediaGridviewType.grid,
                        width: images.length == 1 ? 160 : 246,
                      ),
                    )
                  ],
                  if (widget.message.groupId == null && widget.isMe) ...[
                    const SizedBox(height: 4),
                    const Text(
                      'Đang gửi ...',
                      // Utils.formatMessageDate(widget.data.createdAtStr!),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color.fromRGBO(175, 177, 175, 1),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
