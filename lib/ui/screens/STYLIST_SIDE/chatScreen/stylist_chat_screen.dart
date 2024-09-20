import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/enums/message_type.dart';
import 'package:styld_stylist/core/model/customer_side_models/customer_user.dart';
import 'package:styld_stylist/ui/custom_widgets/chat_message_containers.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/chatScreen/stylist_chat_view_model.dart';

class StylistChatScreen extends StatefulWidget {
  final CustomerUser customerUser;
  StylistChatScreen(this.customerUser);

  @override
  _CustomerConversationScreenState createState() =>
      _CustomerConversationScreenState();
}

class _CustomerConversationScreenState extends State<StylistChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StylistChatViewModel(widget.customerUser.id!),
      child: Consumer<StylistChatViewModel>(builder: (context, model, child) {
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
                    leading: widget.customerUser.imageUrl == null
                        ? CircleAvatar(
                            backgroundColor: StyldColors.black,
                            foregroundColor: StyldColors.black,
                            backgroundImage:
                                AssetImage('$staticAsset/profile.png'),
                          )
                        : CircleAvatar(
                            backgroundColor: StyldColors.black,
                            foregroundColor: StyldColors.black,
                            backgroundImage:
                                NetworkImage(widget.customerUser.imageUrl!),
                          ),
                    title: Text('${widget.customerUser.name}',
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

  sendMessageContainer(StylistChatViewModel model) {
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
          //     onPressed: () {
          //                    },
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
                      model.sendMessage(widget.customerUser);
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
                  model.sendMessage(widget.customerUser);
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

  chatMessages(StylistChatViewModel model) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 66.0, bottom: 16.0),
        reverse: true,
        itemCount: model.reverseMessagesList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          bool isMe = model.reverseMessagesList[index].isStylist ?? false;
          print('isMe: $isMe');
          return isMe
              ? MessengerTextRight(message: model.reverseMessagesList[index])
              : MessengerTextLeft(message: model.reverseMessagesList[index]);
        },
      ),
    );
  }
}
