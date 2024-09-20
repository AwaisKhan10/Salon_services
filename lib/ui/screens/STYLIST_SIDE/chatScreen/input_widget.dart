import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/constants/images.dart';

// ignore: must_be_immutable
class InputWidget extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  InputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: <Widget>[
          // Text input
          Flexible(
            child: TextField(
              style: const TextStyle(color: StyldColors.white, fontSize: 15.0),
              controller: textEditingController,
              decoration: const InputDecoration.collapsed(
                hintText: 'Type a message',
                hintStyle: TextStyle(
                  color: StyldColors.white,
                ),
              ),
            ),
          ),
          // Send Message Button
          Material(
            child: IconButton(
              icon: SvgPicture.asset(StyldImages.voiceNoteIcon),
              onPressed: () => {},
            ),
            color: StyldColors.lightGrey,
          ),
          Material(
            child: IconButton(
              icon: SvgPicture.asset(StyldImages.locationIcon),
              onPressed: () => {},
            ),
            color: StyldColors.lightGrey,
          ),

          // Send Message Button
          Material(
            child: IconButton(
              icon: SvgPicture.asset(StyldImages.sendMessageIcon),
              onPressed: () => {},
            ),
            color: StyldColors.lightGrey,
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
}
