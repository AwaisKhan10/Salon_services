import 'package:flutter/material.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/enums/message_type.dart';
import 'package:styld_stylist/core/model/chat.dart';
import 'package:styld_stylist/core/services/google_map_service.dart';

class MessengerTextRight extends StatelessWidget {
  final Chat? message;

  MessengerTextRight({this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 3,
                child: Material(
                  color: StyldColors.lightGold,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (message!.type == MessageType.location) {
                              print('openmap');
                              GoogleMapService googleMapService =
                                  GoogleMapService();
                              googleMapService
                                  .openMapFromLink(message!.message!);
                            }
                          },
                          child: Text(message!.message ?? '',
                              style: TextStyle(
                                  decoration:
                                      message!.type == MessageType.location
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                  color: message!.type == MessageType.location
                                      ? StyldColors.blue
                                      : StyldColors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 60, end: 7, top: 5),
            child: Text(
              message!.formattedTime ?? ' ',
              style: TextStyle(
                  color: StyldColors.lightGrey,
                  fontSize: 12.0,
                  fontStyle: FontStyle.normal),
            ),
          ),
        ],
      ),
    );
  }
}

class MessengerTextLeft extends StatelessWidget {
  final Chat? message;

  MessengerTextLeft({this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Flexible(
                flex: 3,
                child: Material(
                  color: StyldColors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (message!.type == MessageType.location) {
                          print('openmap');
                          GoogleMapService googleMapService =
                              GoogleMapService();
                          googleMapService.openMapFromLink(message!.message!);
                        }
                      },
                      child: Text(message!.message ?? '',
                          style: TextStyle(
                              decoration: message!.type == MessageType.location
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              color: message!.type == MessageType.location
                                  ? StyldColors.blue
                                  : StyldColors.black)),
                    ),
                  ),
                ),
              ),
              Flexible(flex: 1, child: Container()),
            ],
          ),
          Padding(
            padding:
                const EdgeInsetsDirectional.only(end: 60, start: 8, top: 5.0),
            child: Text(
              message!.formattedTime ?? '',
              style: TextStyle(
                  color: StyldColors.lightGrey,
                  fontSize: 12.0,
                  fontStyle: FontStyle.normal),
            ),
          ),
        ],
      ),
    );
  }
}
