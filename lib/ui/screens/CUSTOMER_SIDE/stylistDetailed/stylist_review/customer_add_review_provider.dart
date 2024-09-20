import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/core/model/stylist_reviews.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import '../../../../../locator.dart';
import 'package:get/get.dart';

class CustomerAddReviewProvider extends BaseViewModel {
  StylistReview stylistReview = StylistReview();
  final _authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();
  List<StylistReview> stylistReviewsList = [];

  addStylistReview(StylistUser stylistUser, stylistReviews) async {
    setState(ViewState.busy);
    if (stylistReview.rating == 0.0 || stylistReview.reviewText == null) {
      Get.snackbar('Required', 'Please provide rating details',
          snackPosition: SnackPosition.BOTTOM, colorText: StyldColors.white);
    } else {
      stylistReview.createdAt = DateTime.now();
      this.stylistReviewsList = stylistReviews;
      stylistReview.customerId = _authService.customerUser!.id;
      stylistReview.stylistId = stylistUser.id;
      stylistReview.customerUser = _authService.customerUser;
      print('Review data => ${stylistReview.toJson()}');
      await _dbService.addStylistUserReview(stylistReview);
      stylistReviewsList.add(stylistReview);
      Get.back(result: stylistReviewsList);
    }
    setState(ViewState.idle);
  }
}
