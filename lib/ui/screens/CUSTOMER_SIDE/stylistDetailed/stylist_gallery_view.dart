import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/model/gallery_likes_comments.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylist_live/stylist_live_view.dart';

class StylistGalleryView extends StatelessWidget {
  final List<GalleryCommentsLikes> gallery;
  StylistGalleryView(this.gallery);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: MasonryGridView.count(
          crossAxisCount: 3,
          itemCount: gallery.length,
          itemBuilder: (BuildContext context, int index) => InkWell(
            onTap: () => Get.to(StylistLiveView(gallery: gallery[index])),
            child: Container(
              margin: const EdgeInsets.all(3),
              padding: EdgeInsets.only(left: 5.w, bottom: 5.w),
              height: 50.0.h,
              width: 5.0.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  width: 50.w,
                  height: 50.h,
                  placeholder: 'assets/images/placeholder.png',
                  image: '${gallery[index].imageUrl}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          // staggeredTileBuilder: (int index) =>
          // StaggeredTile.count(4, index.isEven ? 3 : 2),
          //     StaggeredTile.count(1, index.isEven ? 3 : 2),
          // mainAxisSpacing: 6.0,
          // crossAxisSpacing: 4.0,
        ),
      ),
    ]);
  }
}
