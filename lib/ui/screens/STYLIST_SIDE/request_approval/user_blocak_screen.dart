import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/root/stylist_root_screen.dart';
import '../../../../locator.dart';

class BlockedScreen extends StatefulWidget {
  @override
  _ApprovalPendingScreenState createState() => _ApprovalPendingScreenState();
}

class _ApprovalPendingScreenState extends State<BlockedScreen> {
  final _dbService = DatabaseService();

  @override
  void initState() {
    _listenUserDataStream();
    super.initState();
  }

  _listenUserDataStream() async {
    print(
        '@approvalStatus/init: ${jsonEncode(locator<AuthService>().stylistUser!.id)}');
    final Stream<DocumentSnapshot> stream =
        _dbService.getUserDataStream(locator<AuthService>().stylistUser!.id);
    stream.listen((snapshot) {
      print('Snapshot: ${snapshot.data().toString()}');

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        if (data['isBlocked'] == false) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => StylistRootScreen()),
              (route) => false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: StyldColors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Container(
              height: 0.4.sh,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/logos/Logo_STYLD-ToGo_White.png"),
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Account Blocked!',
                      style: TextStyle(
                          fontSize: 28,
                          color: StyldColors.white,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: '\nyour account is blocked by admin,',
                            style: TextStyle(
                                fontSize: 16,
                                color: StyldColors.white,
                                fontWeight: FontWeight.normal)),
                        TextSpan(
                            text: '\nplease contact support',
                            style: TextStyle(
                                fontSize: 16,
                                color: StyldColors.white,
                                fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
