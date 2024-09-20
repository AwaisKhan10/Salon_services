import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/gallery_likes_comments.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylist_live/stylist_live_view_model.dart';

class FullScreenLiveView extends StatelessWidget {
  final GalleryCommentsLikes gallery;
  final StylistLiveViewModel model;
  FullScreenLiveView(this.gallery, this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(gallery.imageUrl!),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Positioned(
                  top: 0.82.sh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      // model.addLike(gallery);
                                    },
                                    icon: Icon(Icons.favorite,
                                        color: model.isLiked
                                            ? StyldColors.lightGold
                                            : StyldColors.grey)),
                                SizedBox(width: 5.w),
                                Text(
                                  '${model.galleryCommentsLikes.likeCount.length}',
                                  style: GoogleFonts.roboto(textStyle: b_16),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(StyldImages.bubbleIcon,
                                    color: model.isCommeted
                                        ? StyldColors.lightGold
                                        : StyldColors.grey),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  '${model.galleryCommentsLikes.comments.length}',
                                  style: GoogleFonts.roboto(textStyle: b_16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // CommentWidget(onChange: (value) {
                      //   model.newComment.commnetText = value;
                      // }, onTap: () {
                      //   if (model.newComment.commnetText != null) {
                      //     model.addNewComment(gallery);
                      //   } else {
                      //     print('fdafad');
                      //   }
                      // }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
