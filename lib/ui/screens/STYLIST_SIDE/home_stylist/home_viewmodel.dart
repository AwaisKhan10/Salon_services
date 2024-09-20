import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/gallery-pic.dart';
import 'package:styld_stylist/core/model/post.dart';
import 'package:styld_stylist/core/model/stylist_reviews.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import 'package:styld_stylist/core/services/local_storage_service.dart';
import 'package:styld_stylist/core/services/storage_service.dart';
import 'package:get/get.dart';
import '../../../../locator.dart';

class HomeStylistViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final _localStorageService = locator<LocalStorageService>();
  List<GalleryPic> galleryPics = [];
  StorageService storageService = StorageService();
  final picker = ImagePicker();
  // List<File> uplodImages = [];
  File? image;
  Post post = Post();
  double totalRating = 0.0;
  List<Post> posts = [];
  List<StylistReview> stylistReviews = [];
  final authService = locator<AuthService>();

  HomeStylistViewModel({bool isGetPosts = true}) {
    getStylistReviews();
    getAllPosts();
    // print('gallery => ${authService.stylistUserGallery.length}');
  }
  getAllPosts() async {
    final uuid = _localStorageService.accessTokenStylist;
    setState(ViewState.loading);

    posts = await _dbService.getAllStylistGalleryPics(uuid);
    setState(ViewState.idle);
  }

  editImage(index) async{
    setState(ViewState.loading);
    image = null;
    await getImages();
    if(image != null ){
      posts[index].postImageUrl = await storageService.uploadImage(image!, '"post-images"');
      await _dbService.updatePostImage(posts[index].id!, posts[index]);
    Get.snackbar('Update success', "Image updated successfully", snackPosition: SnackPosition.BOTTOM);
    }
    setState(ViewState.idle);
  }

  deleteImage(index) async{
    setState(ViewState.loading);
    await _dbService.deletePostImage(posts[index].id!, posts[index]);
    posts.removeAt(index);
    Get.snackbar('Delete success', "Image deleted successfully", snackPosition: SnackPosition.BOTTOM);
    setState(ViewState.idle);
  }

  getStylistReviews() async {
    setState(ViewState.busy);
    stylistReviews =
        await _dbService.getAllStylistReviews(authService.stylistUser!.id!);
    print('stylistReviewsLength => ${stylistReviews.length}');
    authService.stylistReviewsLength = stylistReviews.length;
    for (int i = 0; i < stylistReviews.length; i++) {
      totalRating = totalRating + stylistReviews[i].rating!;
    }
    totalRating = totalRating / stylistReviews.length;
    if (stylistReviews.isEmpty) {
      totalRating = 0.0;
    }
    print(
        'Total rating is $totalRating based on ${stylistReviews.length} reviews');
    setState(ViewState.idle);
  }

  addPost() async {
    setState(ViewState.busy);
    final id = _localStorageService.accessTokenStylist;
    post.stylistId = id;
    _dbService.addToMyGalleryPics(post, id);
    await getAllPosts();
    Get.back(result: posts);
    setState(ViewState.idle);
  }

  Future getImages() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      // pickedImage.forEach((element) {
        // uplodImages.add(File(element.path));
      // });
      // print('Images Length => ${uplodImages.length}');
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  getImagesUrl() async {
    setState(ViewState.busy);
    // post.postImages = [];
    post.postImageUrl =
        await storageService.uploadImage(image!, '"post-images"');
    // print('Images Lenght => ${post.postImages!.length}');
    await addPost();
  }

  uploadImages(File file, String fileName) async {
    // setState(ViewState.loading);
    // carToBeAdded.imgUrl
    var downloadFileUrl =
        await _dbService.uploadFile(file, 'provider_services', '$fileName');
    // setState(ViewState.idle);
    return downloadFileUrl;
  }
}
