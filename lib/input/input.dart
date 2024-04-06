import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:package_chat_pie/model/message_request.dart';
import 'package:package_chat_pie/ultils/pick_image_video_utils.dart';

// ignore: must_be_immutable
class InputComponent extends StatefulWidget {
  final Function(Map<String, dynamic>) press;
  final VoidCallback chooseImage;
  VoidCallback? onTap;
  InputComponent(
      {super.key, required this.press, this.onTap, required this.chooseImage});

  @override
  State<InputComponent> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            iconSize: 24,
            onPressed: (() {}),
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Color(0xFFBFBFBF),
            ),
          ),
          IconButton(
            onPressed: widget.chooseImage,
            icon: Icon(
              Icons.photo_size_select_actual_outlined,
            ),
            iconSize: 24,
            color: Color(0xFFBFBFBF),
          ),
          Expanded(
            child: TextField(
              // maxLength: 500,
              maxLines: 5,
              minLines: 1,
              onTap: widget.onTap,
              onChanged: (value) {},
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 26, 26, 26),
              ),

              controller: controller,
              decoration: InputDecoration(
                counterText: "",
                hintText: 'Nhập tin nhắn',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFBFBFBF),
                ),
                filled: true,
                fillColor: const Color(0xFFF3F3F3),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: const EdgeInsets.all(8),
              ),
            ),
          ),
          IconButton(
            onPressed: (() {
              var x = controller.text.replaceAll(' ', '');
              if (x != '') {
                var message = SendMessageRequest(
                  originalMessage: controller.text,
                  attachmentType: '${DateTime.now().millisecondsSinceEpoch}',
                  linkPreview: "",
                  // username: widget.idSender,
                  // groupName: widget.data.groupName,
                );
                // widget.typing({
                //   'id': widget.data.userIDReal,
                //   'typing': false,
                // });

                widget.press(message.toMap());
                if (mounted) {
                  setState(() {
                    controller.text = '';
                    controller.clear();
                  });
                }
              }
            }),
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Color(0xFF00A651),
          ),
        ],
      ),
    );
  }
}
