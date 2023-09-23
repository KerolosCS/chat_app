import 'package:chat_app/Features/home/data/models/message_model.dart';
import 'package:chat_app/Features/home/pressentation/view/widgets/custom_send_msg.dart';
import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class HomeViewBody extends StatelessWidget {
  HomeViewBody({
    super.key,
    required this.id,
  });
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String id;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  var msgController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('time', descending: false).snapshots(),
      builder: (context, snapshot) {
        List<MessageModel> messagesFromModel = [];

        if (snapshot.hasData) {
          final length = snapshot.data?.docs.length ?? 0;
          for (int i = 0; i < length; i++) {
            messagesFromModel
                .add(MessageModel.fromJson(snapshot.data!.docs[i].data()));
          }
          messagesFromModel.forEach((element) {
            print('GUBA :: ${element.msgContent}');
          });
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // print('MSGGGGGGGGGGGGG : ${snapshot.data!.docs[2]['msg']}');

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: false,
                  controller: scrollController,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: messagesFromModel[index].msgId == id
                        ? ChatBubbleSender(
                            msgContent:
                                messagesFromModel[index].msgContent ?? '',
                            backgroundColor: kPrimaryColor)
                        : ChatBubbleReciever(
                            msgContent:
                                messagesFromModel[index].msgContent ?? '',
                            backgroundColor: Colors.grey,
                          ),
                  ),
                  itemCount: messagesFromModel.length,
                ),
              ),
              CustomSendMessage(
                control: msgController,
                onSubmitted: (msgData) {
                  messages.add({
                    'msg': msgData,
                    'time': DateTime.now().toUtc(),
                  });
                },
                hintTxt: 'Type Your message...',
                marg: 8,
                suffixIcon: Icons.send,
                suffixOnPress: () {
                  if (msgController.text != "") {
                    messages.add({
                      'msg': msgController.text,
                      'time': DateTime.now(),
                      'id': id,
                    });

                    scrollDown();
                  }
                  msgController.clear();
                },
              ),
            ],
          );
        }
      },
    );
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
}

class ChatBubbleSender extends StatelessWidget {
  const ChatBubbleSender({
    super.key,
    required this.msgContent,
    required this.backgroundColor,
    this.hasTail,
    this.isSend,
  });
  final String msgContent;
  final Color backgroundColor;
  final bool? hasTail;
  final bool? isSend;
  @override
  Widget build(BuildContext context) {
    return BubbleSpecialOne(
      text: msgContent,
      color: backgroundColor,
      tail: hasTail ?? false,
      isSender: isSend ?? true,
      textStyle: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}

class ChatBubbleReciever extends StatelessWidget {
  const ChatBubbleReciever({
    super.key,
    required this.msgContent,
    required this.backgroundColor,
    this.hasTail,
    this.isSend,
  });
  final String msgContent;
  final Color backgroundColor;
  final bool? hasTail;
  final bool? isSend;
  @override
  Widget build(BuildContext context) {
    return BubbleSpecialOne(
      text: msgContent,
      color: backgroundColor,
      tail: hasTail ?? false,
      isSender: false,
      textStyle: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
