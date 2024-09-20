import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

// ignore: must_be_immutable
class PrefixTextField extends StatelessWidget {
  final bool? hideText;
  final onChange;
  final bool? readOnly;
  final initialValue;
  final VoidCallback? action;
  final String? hintText;
  final String title;
  final String iconPath;
  TextEditingController controller = TextEditingController();
  PrefixTextField(
      {Key? key,
      required this.controller,
      this.hideText,
      this.initialValue,
      required this.title,
      this.onChange,
      this.action,
      this.readOnly,
      this.hintText,
      required this.iconPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(textStyle: r_14),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: StyldColors.blue,
            ),
            // width: MediaQuery.of(context).size.width * 0.85,
            child: TextFormField(
              initialValue: initialValue ?? '',
              onChanged: onChange,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'required field';
                } else {
                  return null;
                }
              },
              readOnly: readOnly ?? false,
              obscureText: hideText ?? false,
              // controller: controller,
              style: GoogleFonts.roboto(textStyle: r_17),
              cursorColor: StyldColors.white,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: hintText,
                suffixIcon: IconButton(
                    onPressed: action ?? () {},
                    icon: SvgPicture.asset(iconPath)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
