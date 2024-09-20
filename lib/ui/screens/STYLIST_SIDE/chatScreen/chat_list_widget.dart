import 'package:flutter/material.dart';

import 'chat_item_widget.dart';

// ignore: must_be_immutable
class ChatListWidget extends StatelessWidget {
  ScrollController listScrollController = ScrollController();

  ChatListWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, index) => ChatItemWidget(index),
      itemCount: 20, 
      reverse: true,
      controller: listScrollController,
    ));
  }
}
