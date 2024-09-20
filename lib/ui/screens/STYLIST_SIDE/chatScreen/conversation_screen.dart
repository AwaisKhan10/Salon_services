import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'chat_list_widget.dart';
import 'input_widget.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
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
                leading: const CircleAvatar(
                  backgroundColor: StyldColors.black,
                  foregroundColor: StyldColors.black,
                  backgroundImage: AssetImage(StyldImages.hairDresser3),
                ),
                title: Text('Olevia Emma',
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
                  ChatListWidget(), //Chat list
                  InputWidget() // The input widget
                ],
              ),
            ])));
  }
}
