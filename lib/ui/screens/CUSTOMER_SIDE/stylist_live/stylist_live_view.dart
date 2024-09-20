import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/gallery_likes_comments.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/comment_tile.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylist_live/stylist_live_view_model.dart';
import 'comment_widget.dart';
import 'full_screen_live_view.dart';

class StylistLiveView extends StatelessWidget {
  final GalleryCommentsLikes? gallery;
  StylistLiveView({this.gallery});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StylistLiveViewModel(gallery!),
      child: Consumer<StylistLiveViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => Get.to(FullScreenLiveView(gallery!, model)),
                    child: PreferredSize(
                      preferredSize: Size.fromHeight(100.h),
                      child: AppBar(
                        leading: IconButton(
                          onPressed: () => Get.back(),
                          icon: SvgPicture.asset(StyldImages.backIcon),
                        ),
                        // title: Text('App Bar!'),
                        flexibleSpace: Container(
                          height: 0.4.sh,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(22),
                                bottomRight: Radius.circular(22)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(gallery!.imageUrl!),
                            ),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      model.addLike(gallery!);
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: model.galleryCommentsLikes.comments.length,
                        itemBuilder: (context, index) {
                          return CommentTile(
                              comment:
                                  model.galleryCommentsLikes.comments[index]);
                        }),
                  ),
                  CommentWidget(onChange: (value) {
                    model.newComment.commnetText = value;
                  }, onTap: () {
                    if (model.newComment.commnetText != null) {
                      model.addNewComment(gallery!);
                    } else {
                      print('fdafad');
                    }
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
