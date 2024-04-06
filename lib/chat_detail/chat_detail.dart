// import 'package:chat_socket/list_message/list_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:package_chat_pie/chat_app_key.dart';
import 'package:package_chat_pie/chat_detail/chat_detail_cubit.dart';
import 'package:package_chat_pie/chat_detail/chat_detail_state.dart';
import 'package:package_chat_pie/input/input.dart';
import 'package:package_chat_pie/list_message/list_message.dart';
import 'package:package_chat_pie/model/message_response.dart';
import 'package:package_chat_pie/ultils/app_color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatDetailScreen extends StatefulWidget {
  List<SendMessageResponse> listMessage;
  ChatAppCarDoctorUtilOption chatKey;
  final Function(SendMessageResponse) pressSend;
  final Function() loadMoreHistory;
  final Function() loadMoreNewHistory;
  String titleChatName;
  String idSenderUser;
  AppBar? appBarCustom;
  final Color? senderColor;
  final Color? otherPeopleColor;
  final Color? senderTextColor;
  final Color? otherPeopleTextColor;
  Widget? sendIcon;
  ChatDetailScreen({
    super.key,
    required this.chatKey,
    required this.listMessage,
    required this.pressSend,
    required this.loadMoreHistory,
    required this.loadMoreNewHistory,
    required this.idSenderUser,
    required this.titleChatName,
    this.appBarCustom,
    this.senderColor = const Color(0xFFF1F1F1),
    this.otherPeopleColor = const Color(0xFF00A651),
    this.senderTextColor = AppColor.black,
    this.otherPeopleTextColor = const Color(0xFFF1F1F1),
    this.sendIcon,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late RefreshController controller;
  late ChatDetailCubit _cubit;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    controller = RefreshController();
    _cubit = ChatDetailCubit(widget.chatKey, widget.idSenderUser);
    _cubit.joinRoom();
    addListHistory();
  }

  addListHistory() {
    _cubit.listMessage = widget.listMessage;
  }

  scrollToEnd() {
    final double end = controller.position!.minScrollExtent;
    controller.position!.animateTo(end,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: BlocConsumer<ChatDetailCubit, ChatDetailState>(
        bloc: _cubit,
        listener: (context, state) async {},
        builder: (context, state) {
          return _buildPage(state);
        },
      ),
    );
  }

  Widget _buildPage(ChatDetailState state) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: widget.appBarCustom ??
            AppBar(
              title: Text('${widget.titleChatName}'),
              elevation: 0.0,
              backgroundColor: Colors.grey[100],
            ),
        // resizeToAvoidBottomInset: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SmartRefresher(
                enablePullUp: true,
                reverse: true,
                footer: CustomFooter(
                  loadStyle: LoadStyle.ShowAlways,
                  builder: (context, mode) {
                    if (mode == LoadStatus.loading ||
                        mode == LoadStatus.canLoading) {
                      return Container(
                        height: 60.0,
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    } else
                      return Container();
                  },
                ),
                header: CustomHeader(
                  builder: (context, mode) {
                    if (mode == RefreshStatus.canRefresh ||
                        mode == RefreshStatus.refreshing) {
                      return Container(
                        height: 60.0,
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    } else
                      return Container();
                  },
                ),
                enablePullDown: true,
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 1000));
                  await widget.loadMoreNewHistory();
                  controller.refreshCompleted();
                },
                onLoading: () async {
                  await Future.delayed(Duration(milliseconds: 1000));
                  await widget.loadMoreHistory();
                  controller.loadComplete();
                },
                controller: controller,
                child: ScrollablePositionedList.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _cubit.listMessage.length,
                  itemBuilder: ((context, index) {
                    bool isMe = false;
                    if (_cubit.listMessage[index].username ==
                        widget.idSenderUser) {
                      isMe = true;
                    }
                    return BuildMessage(
                      message: _cubit.listMessage[index],
                      isMe: isMe,
                      senderColor: widget.senderColor ?? Color(0xFF00A651),
                      otherPeopleColor:
                          widget.otherPeopleColor ?? Color(0xFFF1F1F1),
                      otherPeopleTextColor:
                          widget.otherPeopleTextColor ?? Color(0xFFF1F1F1),
                      senderTextColor: widget.senderTextColor ?? AppColor.black,
                    );
                  }),
                ),
              ),
            ),
            InputComponent(
              press: (value) {
                SendMessageResponse message = SendMessageResponse(
                    originalMessage: value['originalMessage'],
                    filteredMessage: value['originalMessage'],
                    username: widget.idSenderUser,
                    attachmentType: value['attachmentType'],
                    groupName: widget.chatKey.groupName,
                    linkPreview: value['linkPreview']);
                widget.pressSend(message);
                _cubit.addMessage(message);
                scrollToEnd();
              },
              chooseImage: () async {
                var message =
                    await _cubit.chooseImage(widget.chatKey.groupName);
                widget.pressSend(message);
              },
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     addMessage();
        //   },
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}
