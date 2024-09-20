import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/gallery_likes_comments.dart';
import 'package:styld_stylist/core/model/post.dart';
import 'package:styld_stylist/core/model/service_model.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/core/model/stylist_reviews.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import 'package:styld_stylist/core/services/date_time_service.dart';
import '../../../../../locator.dart';

class StylistDetailViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final authService = locator<AuthService>();
  PricingDetails? pricingDetails = PricingDetails();
  List<StylistReview> stylistReviews = [];
  bool isReviewAdded = false;
  double totalRating = 0.0;
  List<Post> posts = [];
  List<GalleryCommentsLikes> gallery = [];
  List<ServiceModel> stylistServices = [];
  DateTimeService dateTimeService = DateTimeService();

  StylistDetailViewModel(StylistUser stylistUser) {
    getStylistPricingDetails(stylistUser);
    getStylistReviews(stylistUser);
    getStylistServices(stylistUser);
    getStylistGallery(stylistUser);
  }

  getStylistGallery(StylistUser stylistUser) async {
    setState(ViewState.busy);
    posts = await _dbService.getAllStylistGalleryPics(stylistUser.id!);
    gallery = [];
    for (int i = 0; i < posts.length; i++) {
      print('post doc id => ${posts[i].id}');
      // posts[i].postImages!.forEach((element) {
        gallery.add(GalleryCommentsLikes(
            id: posts[i].id, imageUrl: posts[i].postImageUrl, likeCount: [], comments: []));
      // });
    }
    print('StylistGalleryLength => ${gallery.length}');
    setState(ViewState.idle);
  }

  getStylistServices(StylistUser stylistUser) {
    for (int i = 0; i < stylistUser.services!.length; i++) {
      if (stylistUser.services![i].label == services[i].title) {
        stylistServices.add(services[i]);
      }
    }
    print('stylistServices => ${stylistServices.length}');
  }

  getStylistReviews(StylistUser stylistUser) async {
    setState(ViewState.busy);
    stylistReviews = await _dbService.getAllStylistReviews(stylistUser.id!);
    print('stylistReviewsLength => ${stylistReviews.length}');
    authService.stylistReviewsLength = stylistReviews.length;
    for (int i = 0; i < stylistReviews.length; i++) {
      totalRating = totalRating + stylistReviews[i].rating!;
      if (stylistReviews[i].customerId == authService.customerUser!.id) {
        isReviewAdded = true;
      }
    }
    totalRating = totalRating / stylistReviews.length;
    if (stylistReviews.isEmpty) {
      totalRating = 0.0;
    }
    print(
        'Total rating is $totalRating based on ${stylistReviews.length} reviews');
    stylistUser.rating = totalRating;
    stylistUser.reviewCount = stylistReviews.length;
    await _dbService.updateStylistUserProfile(stylistUser);
    setState(ViewState.idle);
  }

  getStylistPricingDetails(StylistUser stylistUser) async {
    setState(ViewState.busy);
    pricingDetails = await _dbService.getPricingDetails(stylistUser.id!);
    print('StylistUserPricingDetails => ${pricingDetails!.toJson()}');
    setState(ViewState.idle);
  }

  final List<ServiceModel> services = [
    ServiceModel(iconPath: StyldImages.hairCuttingIcon, title: 'Hair-cutting'),
    ServiceModel(iconPath: StyldImages.waxingIcon, title: 'Waxing & other'),
    ServiceModel(iconPath: StyldImages.nailIcon, title: 'Nail treatments'),
    ServiceModel(iconPath: StyldImages.facialIcon, title: 'Facials & skin'),
    ServiceModel(iconPath: StyldImages.massageIcon, title: 'Massage'),
  ];
}
