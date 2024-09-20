import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/chat.dart';
import 'package:styld_stylist/core/model/customer_side_models/customer_user.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';

import '../../../../../locator.dart';

class StylistChatViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final dbService = locator<DatabaseService>();
  late Stream messagesStream;
  Chat msgToBeSent = Chat();
  final controller = TextEditingController();
  List<Chat> messagesList = [];
  List<Chat> reverseMessagesList = [];

  StylistChatViewModel(String customerId) {
    getChatMessges(customerId);
  }

  ///
  /// Get messages from db
  getChatMessges(String customerId) {
    setState(ViewState.busy);
    messagesStream =
        dbService.getMessagesStream(authService.stylistUser!.id!, customerId);
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
  sendMessage(CustomerUser customerUser) async {
    setState(ViewState.busy);
    msgToBeSent.createdAt = DateTime.now().toString();
    msgToBeSent.customerFcm = customerUser.fcmToken;
    msgToBeSent.customerId = customerUser.id;
    msgToBeSent.message = controller.text;
    msgToBeSent.customerUser = customerUser;
    msgToBeSent.stylistFcm = authService.stylistUser!.fcmToken;
    msgToBeSent.stylistId = authService.stylistUser!.id;
    msgToBeSent.stylistUser = authService.stylistUser;
    msgToBeSent.isCustomer = false;
    msgToBeSent.isStylist = true;
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
