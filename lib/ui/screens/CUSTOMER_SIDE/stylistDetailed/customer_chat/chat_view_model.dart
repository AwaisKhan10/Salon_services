import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/chat.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';

import '../../../../../locator.dart';

class ChatViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final dbService = locator<DatabaseService>();
  late Stream messagesStream;
  Chat msgToBeSent = Chat();
  final controller = TextEditingController();
  List<Chat> messagesList = [];
  List<Chat> reverseMessagesList = [];

  ChatViewModel(String stylistId) {
    getChatMessges(stylistId);
  }

  ///
  /// Get messages from db
  getChatMessges(String stylistId) {
    setState(ViewState.busy);
    messagesStream =
        dbService.getMessagesStream(stylistId, authService.customerUser!.id!);
    messagesStream.listen((event) {
      print('getMessgesStream');
      print(event.snapshot.value.toString());
      Chat message =
          Chat.fromJson(Map<String, dynamic>.from(event.snapshot.value));
      messagesList.add(message);
      reverseMessagesList = messagesList.reversed.toList();
      notifyListeners();
    });

    msgToBeSent = Chat();
    // print('conversationList => ${conversationList.length}');
    setState(ViewState.idle);
  }

  ///
  /// Send message to db
  sendMessage(StylistUser stylistUser) async {
    setState(ViewState.busy);
    msgToBeSent.createdAt = DateTime.now().toString();
    msgToBeSent.customerFcm = authService.customerUser!.fcmToken;
    msgToBeSent.customerId = authService.customerUser!.id;
    msgToBeSent.message = controller.text;
    msgToBeSent.customerUser = authService.customerUser;
    msgToBeSent.message = controller.text;
    msgToBeSent.stylistFcm = stylistUser.fcmToken;
    msgToBeSent.stylistId = stylistUser.id;
    msgToBeSent.stylistUser = stylistUser;
    msgToBeSent.isCustomer = true;
    msgToBeSent.isStylist = false;
    DateTime time = DateFormat('yyyy-mm-dd HH:mm:s')
        .parse(DateTime.now().toString())
        .toLocal();
    if (time != null) {
      msgToBeSent.formattedTime = DateFormat('HH:mm a').format(time);
      print('FormattedTime => ${msgToBeSent.formattedTime}');
    }
    await dbService.sendMessage(msgToBeSent);
    controller.clear();
    msgToBeSent = Chat();
    setState(ViewState.idle);
  }
}
