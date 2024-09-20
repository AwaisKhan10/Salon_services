import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/constants/colors.dart';

// ignore: must_be_immutable
class ChatItemWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final index;

  const ChatItemWidget(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (index % 2 == 0) {
      //This is the sent message. We'll later use data from firebase instead of index to determine the message is sent or received.
      return Column(children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              child: const Text(
                'Hi',
                style: TextStyle(color: StyldColors.white),
              ),
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              // width: 200.0,
              decoration: const BoxDecoration(
                color: StyldColors.lightGold,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              margin: const EdgeInsets.only(right: 10.0),
            )
          ],
          mainAxisAlignment:
              MainAxisAlignment.end, // aligns the chatitem to right end
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Container(
            child: const Text(
              '9:22 AM',
              style: TextStyle(
                  color: StyldColors.lightGrey,
                  fontSize: 12.0,
                  fontStyle: FontStyle.normal),
            ),
            margin:
                EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0, right: 10.w),
          ),
        ])
      ]);
    } else {
      // This is a received message
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: const Text(
                    'Hey I am the way',
                    style: TextStyle(color: StyldColors.black),
                  ),
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  // width: 200.0,
                  decoration: const BoxDecoration(
                    color: StyldColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  margin: const EdgeInsets.only(left: 10.0),
                )
              ],
            ),
            Container(
              child: const Text(
                '9:22 AM',
                style: TextStyle(
                    color: StyldColors.lightGrey,
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal),
              ),
              margin: EdgeInsets.only(
                  left: 10.w, top: 5.0, bottom: 5.0, right: 5.0),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: const EdgeInsets.only(bottom: 10.0),
      );
    }
  }
}
