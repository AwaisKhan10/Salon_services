import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

class AccountSettingsTile extends StatelessWidget {
  final Function()? action;
  final String title;
  final String iconPath;

  const AccountSettingsTile(
      {Key? key, this.action, required this.iconPath, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: action,
          leading: IconButton(
            iconSize: 35,
            icon: SvgPicture.asset(
              iconPath,
              color: StyldColors.lightGold,
            ),
            onPressed: () {},
          ),
          title: Text(
            title,
            style: GoogleFonts.roboto(textStyle: r_16),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          child: const Divider(
            thickness: 1.0,
            color: StyldColors.lightGrey,
          ),
        ),
      ],
    );
  }
}
