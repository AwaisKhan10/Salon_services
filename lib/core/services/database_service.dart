import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:styld_stylist/core/model/USER.dart';
import 'package:styld_stylist/core/model/app-user.dart';
import 'package:styld_stylist/core/model/booking.dart';
import 'package:styld_stylist/core/model/chat.dart';
import 'package:styld_stylist/core/model/customer_side_models/app_banners.dart';
import 'package:styld_stylist/core/model/customer_side_models/customer_user.dart';
import 'package:styld_stylist/core/model/customer_side_models/stylist_users_list.dart';
import 'package:styld_stylist/core/model/gallery-pic.dart';
import 'package:styld_stylist/core/model/gallery_likes_comments.dart';
import 'package:styld_stylist/core/model/notification.dart';
import 'package:styld_stylist/core/model/post.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/core/model/stylist_notification.dart';
import 'package:styld_stylist/core/model/stylist_reviews.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/card.dart';

class DatabaseService {
  final firestoreRef = FirebaseFirestore.instance;
  final firebaseDb = FirebaseDatabase.instance.ref().child('chat_system');
  final rentUserRef = FirebaseFirestore.instance.collection('rent-users');
  final hostUserRef = FirebaseFirestore.instance.collection('host-users');
  final guestUserRef = FirebaseFirestore.instance.collection('guest-users');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  // final summaryRef = FirebaseFirestore.instance.collection('summary');

  ////***************************************************************************** */
  ////***************************************************************************** */
  /// [[Stylist user database working functions]]********************************* */
  ////***************************************************************************** */
  ////***************************************************************************** */
  ///
  ///upload provider User
  ///
  Future<void> registerStylistUser(
      StylistUser stylistUser, PricingDetails pricingDetails) async {
    print('@registerStylistUser: uid is ${stylistUser.id}');
    try {
      await firestoreRef
          .collection('stylist_user')
          .doc(stylistUser.id)
          .set(stylistUser.toJson());

      ///
      /// now add stylist pricing packages
      await firestoreRef
          .collection('stylist_user')
          .doc(stylistUser.id)
          .collection('pricingDetails')
          .add(pricingDetails.toJson());
    } catch (e) {
      print('Exception @registerStylistUser: $e');
      throw e;
    }
  }

  /// Register User using this functon
  addCardDetails(CardDetails user, String id) async {
    print("User @Id => $id");
    try {
      await firestoreRef
          .collection('stylist_user')
          .doc(id)
          .collection('card_details')
          .add(user.toJson());
    } catch (e, s) {
      print('Exception @DatabaseService/addingCardDetails');
      print(s);
    }
  }

  Future<List<CardDetails>> getCards(uuid) async {
    print("getCards");
    try {
      List<CardDetails> post = [];
      QuerySnapshot snapshot = await firestoreRef
          .collection('stylist_user')
          .doc(uuid)
          .collection('card_details')
          .get();
      if (snapshot.docs.length < 1) {
        print('No gallery pics found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        post.add(
            CardDetails.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      print('Stylist Post :: db => ${post.length}');

      return post;
    } catch (e, s) {
      print("Exception/getStylistGallery=========> $e, $s");
      return [];
    }
  }

  /// This function will get [Approval Status] in Stream ....
  Stream<DocumentSnapshot> getUserDataStream(id) {
    print('@getStylistDataStream; UserId: $id');
    return firestoreRef.collection('stylist_user').doc(id).snapshots();
  }

  // //this will get user data for authentication purpose
  Future<StylistUser?> getStylistUser(uid) async {
    print('@DatabaseService/getStylistUser ==> $uid');
    try {
      final DocumentSnapshot snapshot =
          await firestoreRef.collection('stylist_user').doc(uid).get();
      if (snapshot.data != null) {
        final user = StylistUser.fromJson(snapshot.data(), uid);
        print('@DatabaseService/getStylistUser: ${user.toJson()}');
        return user;
      } else {
        print('User Data is null');
        return null;
      }
    } catch (e) {
      print('Exception @getStylistUserData: $e');
      return null;
    }
  }

  /// update stylist user
  ///
  updateStylistUserProfile(StylistUser stylistUser) async {
    print('@updateStylisUser: uid is ${stylistUser.id}');
    try {
      await firestoreRef
          .collection('stylist_user')
          .doc(stylistUser.id)
          .set(stylistUser.toJson());
    } catch (e) {
      print('Exception @updateStylistUser: $e');
      throw e;
    }
  }

  Future<List<Post>> getAllStylistGalleryPics(uuid) async {
    print("getAllStylistGalleryPics/");
    try {
      List<Post> post = [];
      QuerySnapshot snapshot = await firestoreRef
          .collection('gallery_pics')
          .where('stylistId', isEqualTo: uuid)
          .get();
      if (snapshot.docs.length < 1) {
        print('No gallery pics found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        post.add(Post.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      print('Stylist Post :: db => ${post.length}');

      return post;
    } catch (e, s) {
      print("Exception/getStylistGallery=========> $e, $s");
      return [];
    }
  }

  /// update customer user
  ///
  updatePostImage(String id, Post post) async {
    try {
      await firestoreRef.collection('gallery_pics').doc(id).set(post.toJson());
    } catch (e) {
      print('Exception @updateCustomerUser: $e');
      throw e;
    }
  }

  /// update customer user
  ///
  deletePostImage(String id, Post post) async {
    try {
      await firestoreRef.collection('gallery_pics').doc(id).delete();
    } catch (e) {
      print('Exception @updateCustomerUser: $e');
      throw e;
    }
  }

  Future<void> addToMyGalleryPics(Post galleryPic, uid) async {
    print('@addToMyGalleryPics}');
    try {
      await firestoreRef.collection('gallery_pics').add(galleryPic.toJson());
    } catch (e) {
      print('Exception @addToMyGalleryPics: $e');
    }
  }

  /// Add and Update notifications of Stylist user
  addStylistNotification(String id, StylistNotification notification) async {
    print('@addStylistNotification uid => $id');
    try {
      await firestoreRef
          .collection('stylist_notification')
          .doc(id)
          .set(notification.toJson())
          .then((value) => print('notificaiton settings updated successfully'));
    } catch (e) {
      print('Exception @addStylistNotification: $e');
    }
  }

  Future<StylistNotification?> getAllNotifications(uuid) async {
    print("@getStylistNotificatons uid => $uuid");
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('stylist_notification')
          .doc(uuid)
          .get();
      final user = StylistNotification.fromJson(snapshot.data(), snapshot.id);
      print('@Got///Notifications: ${user.toJson()}');
      return user;
    } catch (e, s) {
      print("Exception/getStylistNotifications=========> $e, $s");
      return null;
    }
  }

//   ///upload pic to storage firebase
//   ///
//   ///
  // Future<String>
  uploadFile(File file, reference, fileName) async {
    print("@UploadFile=====>${file.path}");
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('$reference/$fileName.png')
          .putFile(file);

      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('$reference/$fileName.png')
          .getDownloadURL();

      print("UPLOADED IMAGE URL IS +========> $downloadURL");

      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print("Exception @UploadFile====>$e");
    }
  }

  ////***************************************************************************** */
  ////***************************************************************************** */
  /// [[Customer user database working functions]]********************************* */
  ////***************************************************************************** */
  ////***************************************************************************** */

  Future<void> registerCustomerUser(CustomerUser customerUser) async {
    print('@registerCustomreUser: uid is ${customerUser.id}');
    try {
      await firestoreRef
          .collection('customer_user')
          .doc(customerUser.id)
          .set(customerUser.toJson());
    } catch (e) {
      print('Exception @registerCustomreUser: $e');
      throw e;
    }
  }

  // //this will get user data for authentication purpose
  Future<CustomerUser?> getCustomerUserData(uid) async {
    print('@DatabaseService/getCustomerUserData of user ==> $uid');
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('customer_user')
          .doc(uid)
          .get();
      if (snapshot.data != null) {
        final user = CustomerUser.fromJson(snapshot.data(), uid);
        print('@DatabaseService/getCustomerUserData: ${user.toJson()}');
        return user;
      } else {
        print('User Data is null');
        return null;
      }
    } catch (e) {
      print('Exception @getCustomerUserData: $e');
      return null;
    }
  }

  /// update customer user
  ///
  updateCustomerUser(CustomerUser customerUser) async {
    print('@updateCustomerUser: uid is ${customerUser.id}');
    try {
      await firestoreRef
          .collection('customer_user')
          .doc(customerUser.id)
          .set(customerUser.toJson());
    } catch (e) {
      print('Exception @updateCustomerUser: $e');
      throw e;
    }
  }

  ///
  /// Get all stylist users
  Future<List<StylistUser>> getAllStylistUsers() async {
    print("<<==/getAllStylistUsers/==>>");
    try {
      List<StylistUser> stylistUsers = [];
      QuerySnapshot snapshot = await firestoreRef
          .collection('stylist_user')
          .where('isApproved', isEqualTo: true)
          .where('isBlocked', isEqualTo: false)
          .get();
      if (snapshot.docs.length < 1) {
        print('No stylist users found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        stylistUsers.add(
            StylistUser.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }

      return stylistUsers;
    } catch (e, s) {
      print("Exception/getStylistGallery=========> $e, $s");
      return [];
    }
  }

  /// get Stylist pricing details
  ///
  Future<PricingDetails?> getPricingDetails(String id) async {
    print("<<==/getPricingDetials/==>>UID => $id");
    try {
      List<PricingDetails> pricingDetails = [];
      QuerySnapshot snapshot = await firestoreRef
          .collection('stylist_user')
          .doc(id)
          .collection('pricingDetails')
          .get();
      if (snapshot.docs.length < 1) {
        print('pricing details not added for user id=>$id');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        pricingDetails.add(PricingDetails.fromJson(
            snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      PricingDetails pricingDetail = pricingDetails[0];
      return pricingDetail;
    } catch (e, s) {
      print("Exception/getStylistGallery=========> $e, $s");
      return null;
    }
  }

  ///
  /// Add stylist user review
  ///
  addStylistUserReview(StylistReview stylistReview) async {
    print('@addStylistReview');
    try {
      await firestoreRef
          .collection('stylist_reviews')
          .add(stylistReview.toJson())
          .then((value) => print('Stylist review added successfully'));
    } catch (e) {
      print('Exception @addingStylistReview: $e');
      throw e;
    }
  }

  ///
  /// Get all reviews of stylist user
  Future<List<StylistReview>> getAllStylistReviews(String id) async {
    print("<<==/getAllStylistReviews/==>>");
    try {
      List<StylistReview> stylistUsers = [];
      QuerySnapshot snapshot = await firestoreRef
          .collection('stylist_reviews')
          .where('stylistId', isEqualTo: id)
          .get();
      if (snapshot.docs.length < 1) {
        print('No stylist reviews found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        stylistUsers.add(StylistReview.fromJson(
            snapshot.docs[i].data(), snapshot.docs[i].id));
      }

      return stylistUsers;
    } catch (e, s) {
      print("Exception/gettingAllStylistReviews=========> $e, $s");
      return [];
    }
  }

  ///
  /// Gallery comments and likes getting
  Future<GalleryCommentsLikes> getAllGalleryCommentsLikes(String id) async {
    print("<<==/getGalleryCommentsLikes/==>>DocID => $id");
    try {
      List<GalleryCommentsLikes> galleryComments = [];
      QuerySnapshot snapshot = await firestoreRef
          .collection('gallery_pics')
          .doc(id)
          .collection('comments')
          .get();
      if (snapshot.docs.length < 1) {
        print('Gallery comments not found');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        galleryComments.add(GalleryCommentsLikes.fromJson(
            snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      GalleryCommentsLikes gallery =
          GalleryCommentsLikes(likeCount: [], comments: []);
      if (galleryComments.length > 0) {
        gallery = galleryComments[0];
      }
      return gallery;
    } catch (e, s) {
      print("Exception/gettingAllGalleryCommetsAndLikes=========> $e, $s");
      return GalleryCommentsLikes(likeCount: [], comments: []);
    }
  }

  ///
  /// Add stylist user review
  ///
  addGalleryComments(
      GalleryCommentsLikes galleryCommentsLikes, String id) async {
    print('@addGalleryComments');
    try {
      await firestoreRef
          .collection('gallery_pics')
          .doc(id)
          .collection('comments')
          .doc(id)
          .set(galleryCommentsLikes.toJson())
          .then((value) => print('Gallery comments likes updated success!!!'));
    } catch (e) {
      print('Exception @addingGalleryCommentsLikes: $e');
      throw e;
    }
  }

  ///
  /// book new appointment
  ///
  bookAppointment(Booking booking) async {
    print('@bookNewAppointment');
    try {
      await firestoreRef
          .collection('bookings')
          .add(booking.toJson())
          .then((value) => print('Service booked successfully!!!'));
    } catch (e) {
      print('Exception @bookingNewSerivce: $e');
      throw e;
    }
  }

  ///
  /// book new appointment
  ///
  updateBooking(Booking booking) async {
    print('@updateBooking');
    try {
      await firestoreRef
          .collection('bookings')
          .doc(booking.id)
          .set(booking.toJson())
          .then((value) => print('booking updated successfully!!!'));
    } catch (e) {
      print('Exception @updatingBooking: $e');
      throw e;
    }
  }

//
  /// add notification
  ///
  addNotification(Notification booking) async {
    print('@addNotification');
    try {
      await firestoreRef
          .collection('notifications')
          .add(booking.toJson())
          .then((value) => print('notification added success!!!'));
    } catch (e) {
      print('Exception @bookingNewSerivce: $e');
      throw e;
    }
  }

  ///
  /// get banner sliders
  Future<List<Notification>> getCustomerNotifications(String id) async {
    print("<<==/getNotificaitons/==>>");
    try {
      List<Notification> banners = [];
      QuerySnapshot snapshot = await firestoreRef
          .collection('notifications')
          .where('customerId', isEqualTo: id)
          .orderBy('createdAt', descending: true)
          .get();
      if (snapshot.docs.length < 1) {
        print('notificaiton not in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        banners.add(Notification.fromJson(
            snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      return banners;
    } catch (e, s) {
      print("Exception/gettingNotifications=========> $e, $s");
      return [];
    }
  }

  ///
  /// get banner sliders
  Future<List<Notification>> getStylistNotifications(String id) async {
    print("<<==/getNotificaitons/==>>");
    try {
      List<Notification> banners = [];
      QuerySnapshot snapshot = await firestoreRef
          .collection('notifications')
          .where('stylistId', isEqualTo: id)
          .orderBy('createdAt', descending: true)
          .get();
      if (snapshot.docs.length < 1) {
        print('notificaiton not in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        banners.add(Notification.fromJson(
            snapshot.docs[i].data(), snapshot.docs[i].id));
      }
      return banners;
    } catch (e, s) {
      print("Exception/gettingNotifications=========> $e, $s");
      return [];
    }
  }

  ///
  /// get banner sliders
  Future<List<AppBanners>> getBannerSliders() async {
    print("<<==/getBannerImages/==>>");
    try {
      List<AppBanners> banners = [];
      QuerySnapshot snapshot =
          await firestoreRef.collection('slider_images').limit(5).get();
      if (snapshot.docs.length < 1) {
        print('Slider images not found in db');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        banners.add(AppBanners.fromJson(snapshot.docs[i].data()));
      }

      return banners;
    } catch (e, s) {
      print("Exception/gettingAllStylistReviews=========> $e, $s");
      return [];
    }
  }

  ///
  /// get banner sliders
  Future<List<Booking>> getCustomerBookings(String id) async {
    print("<<==/getCustomerBookings/==>>");
    try {
      List<Booking> bookings = [];
      QuerySnapshot snapshot = await firestoreRef
          .collection('bookings')
          .where('customerId', isEqualTo: id)
          .orderBy('created_at', descending: true)
          .get();
      if (snapshot.docs.length < 1) {
        print('No booking found for customer');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        bookings.add(
            Booking.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }

      return bookings;
    } catch (e, s) {
      print("Exception/gettingCustomerBookings=========> $e, $s");
      return [];
    }
  }

  ///
  /// get banner sliders
  Future<List<Booking>> getStylistBookings(String id) async {
    print("<<==/getStylistBookings/==>>");
    try {
      List<Booking> bookings = [];
      QuerySnapshot snapshot = await firestoreRef
          .collection('bookings')
          .where('stylistId', isEqualTo: id)
          .orderBy('created_at', descending: true)
          .get();
      if (snapshot.docs.length < 1) {
        print('No booking found for stylist');
      }
      for (int i = 0; i < snapshot.docs.length; i++) {
        bookings.add(
            Booking.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
      }

      return bookings;
    } catch (e, s) {
      print("Exception/gettingStylistBookings=========> $e, $s");
      return [];
    }
  }

  ////***************************************************************************** */
  ////***************************************************************************** */
  /// [[Chat messages are for both apps]]********************************* */
  ////***************************************************************************** */
  ////***************************************************************************** */

  ///
  /// Send message to database
  sendMessage(Chat message) {
    print('@sendMessage');
    try {
      firebaseDb
          .child('messages')
          .child('${message.stylistId}_${message.customerId}')
          .push()
          .set(message.toJson())
          .then((value) => print('Message sent successfull!!!'));
    } catch (e) {
      print('Exception @sendMessageFirebaseDb: $e');
    }
  }

  ///
  /// Get messages as stream
  getMessagesStream(String stylistId, String customerId) {
    print('@getMessagesStream');
    Stream stream;
    try {
      stream = firebaseDb
          .child('messages')
          .child('${stylistId}_$customerId')
          .onChildAdded;
      return stream;
    } catch (e) {
      print('Exception @getMessagesStream: $e');
    }
  }
}
