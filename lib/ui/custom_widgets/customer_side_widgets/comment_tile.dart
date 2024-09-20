import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/gallery_likes_comments.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentTile extends StatelessWidget {
  final Comments? comment;
  CommentTile({this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Row(
        children: [
          comment!.customerUser!.imageUrl == null
              ? CircleAvatar(
                  radius: 28.h,
                  backgroundColor: StyldColors.gold,
                  foregroundColor: StyldColors.gold,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                )
              : CircleAvatar(
                  radius: 28.h,
                  backgroundColor: StyldColors.gold,
                  foregroundColor: StyldColors.gold,
                  backgroundImage:
                      NetworkImage(comment!.customerUser!.imageUrl!),
                ),
          SizedBox(width: 5.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${comment!.customerUser!.name}',
                      style: GoogleFonts.roboto(textStyle: b_18),
                    ),
                    Text('${timeago.format(comment!.createdAt!)}',
                        style: GoogleFonts.roboto(textStyle: b_11)),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                AutoSizeText(
                  // 'Hello',
                  '${comment!.commnetText}',
                  maxLines: 3,
                  // overflow: TextOverflow.fade,
                  style: GoogleFonts.roboto(textStyle: m_14),
                ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
