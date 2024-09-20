import 'package:styld_stylist/core/model/stylish_user_profile.dart';

class StylistUsersList {
  StylistUser? stylistUser;
  String? id;
  PricingDetails? pricingDetails;

  StylistUsersList({
    this.stylistUser,
    this.id,
    this.pricingDetails,
  });

  StylistUsersList.fromJson(json, id) {
    this.id = id;
    stylistUser = StylistUser.fromJson(json, id);
    pricingDetails = PricingDetails.fromJson(json, id);
  }
}
