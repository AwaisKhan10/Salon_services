import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/enums/message_type.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/ui/custom_widgets/chat_message_containers.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/customer_chat/chat_view_model.dart';

class CustomerConversationScreen extends StatefulWidget {
  final StylistUser stylistUser;
  CustomerConversationScreen(this.stylistUser);

  @override
  _CustomerConversationScreenState createState() =>
      _CustomerConversationScreenState();
}

class _CustomerConversationScreenState
    extends State<CustomerConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatViewModel(widget.stylistUser.id!),
      child: Consumer<ChatViewModel>(builder: (context, model, child) {
        return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: StyldColors.black,
                  elevation: 0.0,
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: SvgPicture.asset(StyldImages.backIcon),
                  ),
                  title: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: StyldColors.black,
                      foregroundColor: StyldColors.black,
                      backgroundImage: NetworkImage(widget.stylistUser.imgUrl!),
                    ),
                    title: Text('${widget.stylistUser.fullName}',
                        style: GoogleFonts.roboto(textStyle: b_16)),
                    subtitle: Text(
                      'Online',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ), // Custom app bar for chat screen
                body: Stack(children: <Widget>[
                  Column(
                    children: <Widget>[
                      chatMessages(model),
                      sendMessageContainer(model), // The input widget
                    ],
                  ),
                ])));
      }),
    );
  }

  sendMessageContainer(ChatViewModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: <Widget>[
          // Text input
          Flexible(
            child: TextFormField(
              style: const TextStyle(color: StyldColors.white, fontSize: 15.0),
              controller: model.controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'Type a message',
                hintStyle: TextStyle(
                  color: StyldColors.white,
                ),
              ),
            ),
          ),
          // Send Message Button
          // Material(
          //   child: IconButton(
          //     icon: SvgPicture.asset(StyldImages.voiceNoteIcon),
          //     onPressed: () => {},
          //   ),
          //   color: StyldColors.lightGrey,
          // ),
          Material(
            child: IconButton(
              icon: SvgPicture.asset(StyldImages.locationIcon),
              onPressed: () {
                Get.defaultDialog(
                    title: "Are you sure?",
                    middleText: 'Do you want to share live location?',
                    onConfirm: () {
                      String loc =
                          'https://www.google.com/maps/search/${model.authService.position!.latitude},${model.authService.position!.longitude}';
                      model.controller.text = loc;
                      model.msgToBeSent.type = MessageType.location;
                      model.sendMessage(widget.stylistUser);
                      Get.back();
                    },
                    confirmTextColor: StyldColors.white,
                    buttonColor: StyldColors.black,
                    cancelTextColor: StyldColors.black,
                    onCancel: () {});
              },
            ),
            color: StyldColors.lightGrey,
          ),

          // Send Message Button
          Material(
            color: StyldColors.lightGrey,
            child: IconButton(
              icon: SvgPicture.asset(StyldImages.sendMessageIcon),
              onPressed: () {
                if (model.controller.text.isNotEmpty) {
                  model.sendMessage(widget.stylistUser);
                }
              },
            ),
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: const BoxDecoration(
        border:
            Border(top: BorderSide(color: StyldColors.lightGrey, width: 0.5)),
        color: StyldColors.lightGrey,
      ),
    );
  }

  chatMessages(ChatViewModel model) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 66.0, bottom: 16.0),
        reverse: true,
        itemCount: model.reverseMessagesList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          //Todo: Change docId to real Firebase Id
          bool isMe = model.reverseMessagesList[index].isCustomer ?? true;
          print('isMe: $isMe');
          return isMe
              ? MessengerTextRight(message: model.reverseMessagesList[index])
              : MessengerTextLeft(message: model.reverseMessagesList[index]);
        },
      ),
    );
  }
}
