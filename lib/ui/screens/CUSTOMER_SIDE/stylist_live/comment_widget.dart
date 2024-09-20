import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/repos/stylist_approval_data.dart';

// ignore: must_be_immutable
class CommentWidget extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  final onTap;
  final onChange;
  CommentWidget({this.onTap, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: const BoxDecoration(
          // border:
          //     Border(top: BorderSide(color: StyldColors.lightGrey, width: 0.5)),
          // color: StyldColors.lightGrey,
          ),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 30.h,
            backgroundColor: StyldColors.gold,
            foregroundColor: StyldColors.gold,
            backgroundImage: AssetImage(
              activeStylistData[1].imageUrl,
            ),
          ),

          // Text input
          Flexible(
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: const BoxDecoration(
                color: StyldColors.darkGold,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
              ),
              child: Center(
                child: TextField(
                  onChanged: onChange,
                  style:
                      const TextStyle(color: StyldColors.white, fontSize: 15.0),
                  controller: textEditingController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Post Comment...',
                    hintStyle: TextStyle(
                      color: StyldColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Send Message Button

          // Send Message Button
          Container(
            height: 50,
            decoration: const BoxDecoration(
              color: StyldColors.darkGold,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            child: IconButton(
              icon: SvgPicture.asset(StyldImages.sendAwayIcon),
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
