import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/gallery_likes_comments.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import 'package:get/get.dart';
import '../../../../locator.dart';

class StylistLiveViewModel extends BaseViewModel {
  GalleryCommentsLikes galleryCommentsLikes =
      GalleryCommentsLikes(likeCount: [], comments: []);
  final authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();
  bool isLiked = false;
  bool isCommeted = false;
  Comments newComment = Comments();
  StylistLiveViewModel(GalleryCommentsLikes galleryCommentsLikes) {
    getAllComments(galleryCommentsLikes);
  }

  getAllComments(GalleryCommentsLikes galleryComments) async {
    setState(ViewState.busy);
    this.galleryCommentsLikes =
        await _dbService.getAllGalleryCommentsLikes(galleryComments.id!);
    for (int i = 0; i < galleryCommentsLikes.likeCount.length; i++) {
      if (authService.customerUser!.id ==
          galleryCommentsLikes.likeCount[i].customerId) {
        print('likedddd');
        isLiked = true;
      }
    }
    for (int i = 0; i < galleryCommentsLikes.comments.length; i++) {
      if (authService.customerUser!.id ==
          galleryCommentsLikes.comments[i].customerId) {
        isCommeted = true;
      }
    }
    setState(ViewState.idle);
  }

  addLike(GalleryCommentsLikes commentsLikes) async {
    isLiked = !isLiked;
    bool isFound = false;
    setState(ViewState.idle);
    for (int i = 0; i < galleryCommentsLikes.likeCount.length; i++) {
      if (authService.customerUser!.id ==
          galleryCommentsLikes.likeCount[i].customerId) {
        galleryCommentsLikes.likeCount.removeAt(i);
        isFound = true;
      }
    }
    print('likeFound => $isFound');
    if (!isFound) {
      Likes like = Likes();
      like.isLiked = true;
      like.customerId = authService.customerUser!.id;
      galleryCommentsLikes.likeCount.add(like);
      await _dbService.addGalleryComments(
          galleryCommentsLikes, commentsLikes.id!);
    } else {
      await _dbService.addGalleryComments(
          galleryCommentsLikes, commentsLikes.id!);
    }
  }

  addNewComment(GalleryCommentsLikes commentsLikes) async {
    if (!isCommeted) {
      isCommeted = true;
      newComment.id = commentsLikes.id;
      newComment.customerId = authService.customerUser!.id;
      newComment.createdAt = DateTime.now();
      newComment.customerUser = authService.customerUser;
      print('New Comment => ${newComment.toJson()}');
      galleryCommentsLikes.comments.add(newComment);
      setState(ViewState.idle);
      await _dbService.addGalleryComments(
          galleryCommentsLikes, commentsLikes.id!);
    } else {
      Get.snackbar('Already added', 'You have already added comment',
          snackPosition: SnackPosition.BOTTOM, colorText: StyldColors.white);
    }
  }
}
