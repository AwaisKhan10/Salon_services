import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

// ignore: must_be_immutable
class IconTextField extends StatelessWidget {
  final bool? hideText;
  final bool? readOnly;
  final onChange;
  final VoidCallback? action;

  final String title;
  final String iconPath;
  TextEditingController controller = TextEditingController();
  IconTextField(
      {Key? key,
      required this.controller,
      this.hideText,
      this.onChange,
      required this.title,
      this.action,
      this.readOnly,
      required this.iconPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: StyldColors.blue,
        ),
        width: MediaQuery.of(context).size.width * 0.85,
        child: TextFormField(
          onTap: action,
          onChanged: onChange,
          readOnly: readOnly ?? false,
          obscureText: hideText ?? false,
          controller: controller,
          style: GoogleFonts.roboto(textStyle: r_17),
          cursorColor: StyldColors.white,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: title,
            hintStyle: GoogleFonts.roboto(textStyle: r_17),
            prefixIcon: IconButton(
                onPressed: action ?? () {}, icon: SvgPicture.asset(iconPath)),
          ),
        ),
      ),
    );
  }
}
