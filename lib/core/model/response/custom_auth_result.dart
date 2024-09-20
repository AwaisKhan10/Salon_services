import 'package:firebase_auth/firebase_auth.dart';
import 'package:styld_stylist/core/model/customer_side_models/customer_user.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';

class CustomAuthResponse {
  bool? status;
  String? errorMessage;
  User? user;
  CustomerUser? customer;
  StylistUser? stylistUser;

  CustomAuthResponse(
      {this.status,
      this.errorMessage,
      this.user,
      this.customer,
      this.stylistUser});
}
