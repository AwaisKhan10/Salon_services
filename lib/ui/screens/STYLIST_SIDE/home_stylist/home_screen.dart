import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/ui/custom_widgets/full_screen_image.dart';
import 'package:styld_stylist/ui/custom_widgets/user_review_tile.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/home_stylist/home_viewmodel.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/home_stylist/upload_Images/upload_image.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/notifications/stylist_notification_screen.dart';
import '../../../../locator.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class StylistHomeScreen extends StatefulWidget {
  // const StylistHomeScreen({Key? key}) : super(key: key);

  @override
  State<StylistHomeScreen> createState() => _StylistHomeScreenState();
}

class _StylistHomeScreenState extends State<StylistHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeStylistViewModel(),
      child: Consumer<HomeStylistViewModel>(
        builder: (context, model, child) => DefaultTabController(
          length: 2,
          child: ModalProgressHUD(
            inAsyncCall: model.state == ViewState.loading,
            child: Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height *
                            model.posts.length),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () =>
                                    Get.to(() => StylistNotificaitonScreen()),
                                icon: SvgPicture.asset(
                                    StyldImages.notificationIcon)),
                          ),
                          Center(child: Image.asset(StyldImages.mediumLogo)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Welcome ${locator<AuthService>().stylistUser!.fullName}!',
                            // 'Welcome Isabella!',
                            style: GoogleFonts.roboto(textStyle: authText),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 45.h,
                              backgroundColor: StyldColors.black,
                              foregroundColor: StyldColors.black,
                              backgroundImage: NetworkImage(
                                  locator<AuthService>().stylistUser!.imgUrl!),
                              // const AssetImage(StyldImages.femaleImage),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Center(
                            child: Text(
                              // "",
                              'Luxury Beauty Studio',
                              style: GoogleFonts.roboto(textStyle: buttonStyle),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),

                          /// rating bar
                          ///
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingBarIndicator(
                                rating: model.totalRating,
                                unratedColor: StyldColors.lightGrey,
                                itemBuilder: (context, index) => Image.asset(
                                    '$staticAsset/star.png',
                                    width: 17.5.w,
                                    height: 17.1.h),
                                itemCount: 5,
                                itemSize: 18,
                                direction: Axis.horizontal,
                              ),
                              SizedBox(width: 4.w),
                              Text('${model.totalRating.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: StyldColors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 4.w),
                              Text('(${model.stylistReviews.length})',
                                  style: TextStyle(
                                      color: StyldColors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          const Divider(
                            thickness: 3.0,
                            color: StyldColors.grey,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            height: 50.h,
                            child: const TabBar(
                              indicatorColor: StyldColors.gold,
                              tabs: [
                                Tab(
                                  text: "My Gallery",
                                ),
                                Tab(
                                  text: "Users Ratings",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // height: MediaQuery.of(context).size.height * 0.35,
                              padding: EdgeInsets.only(top: 10.h),
                              child: TabBarView(
                                children: [
                                  // first tab bar view widget
                                  galleryView(model),

                                  // second tab bar viiew widget
                                  userRatingsView(model),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  galleryView(HomeStylistViewModel model) {
    return Column(children: [
      WidthButton(
          action: () async {
            model.posts = await Get.to(() => UploadImage()) ?? model.posts;
            model.setState(ViewState.idle);
          },
          width: 340.w,
          buttonColor: StyldColors.lightGold,
          titleText: 'Upload Images'),
      SizedBox(
        height: 15.h,
      ),
      Expanded(
        child: MasonryGridView.count(
          shrinkWrap: true,
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          itemCount: model.posts.length,
          itemBuilder: (BuildContext context, int index) =>
              // CustomStaggeredTile(
              //     imagePath: stylistImages[index].path,
              //     text: stylistImages[index].title),
              GestureDetector(
            onTap: () {
              Get.to(() => FullScreenImage(
                    imageUrl: model.posts[index].postImageUrl!,
                  ));
            },
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(3),
                  padding: EdgeInsets.only(left: 5.w, bottom: 5.w),
                  // height: 120.0.h,
                  // width: 120.0.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      width: 0.4.sw,
                      height: 0.35.sh,
                      placeholder: 'assets/images/placeholder.png',
                      image: '${model.posts[index].postImageUrl}',
                      fit: BoxFit.fill,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: StyldColors.black),
                        onPressed: () {
                          model.editImage(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: StyldColors.black),
                        onPressed: () {
                          model.deleteImage(index);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // staggeredTileBuilder: (int index) =>
          //     StaggeredTile.count(2, index.isEven ? 3 : 2),
          // mainAxisSpacing: 4.0,
          // crossAxisSpacing: 4.0,
        ),
      ),
    ]);
  }

  userRatingsView(HomeStylistViewModel model) {
    return ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            thickness: 1.5,
            color: StyldColors.lightGrey,
          ),
          SizedBox(height: 5.h),
          Text(
            'Reviews',
            textAlign: TextAlign.start,
            style: GoogleFonts.roboto(textStyle: b_20),
          ),
          SizedBox(height: 15.h),
          Center(
            child: Text(
              '${model.totalRating.toStringAsFixed(2)}',
              style: GoogleFonts.roboto(textStyle: b_51),
            ),
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBarIndicator(
                rating: model.totalRating,
                unratedColor: StyldColors.lightGrey,
                itemBuilder: (context, index) => Image.asset(
                    '$staticAsset/star.png',
                    width: 22.w,
                    height: 22.h),
                itemCount: 5,
                itemSize: 25,
                direction: Axis.horizontal,
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Center(
            child: Text(
              'based on ${model.stylistReviews.length} Reviews',
              style: GoogleFonts.roboto(textStyle: b_17),
            ),
          ),
          SizedBox(height: 5.h),
          const Divider(
            thickness: 1.5,
            color: StyldColors.lightGrey,
          ),
          model.stylistReviews.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No one reviewed yet",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.stylistReviews.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: UserReviewTile(
                        stylistReview: model.stylistReviews[index],
                      ),
                    );
                  }),

          // for (var item in reviewsList) UserReviewTile(userReview: item)
        ]);
  }
}
