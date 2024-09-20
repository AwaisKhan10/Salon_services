import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class SuffixTextField extends StatelessWidget {
  final TextEditingController fieldController;
  final validatorFunction;
  final String hintText;
  final String iconPath;
  final onChange;
  final onsaved;
  final String suffixIconPath;
  final bool hideText;
  final VoidCallback suffixAction;
  const SuffixTextField({
    Key? key,
    required this.fieldController,
    required this.hintText,
    required this.iconPath,
    this.onChange,
    required this.hideText,
    required this.suffixIconPath,
    required this.suffixAction,
    this.validatorFunction,
    this.onsaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onsaved,
      validator: validatorFunction,
      obscureText: hideText,
      controller: fieldController,
      onChanged: onChange,
      cursorColor: StyldColors.lightGold,
      style: const TextStyle(color: StyldColors.white),
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 2.0, color: StyldColors.lightGold),
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 2.0, color: StyldColors.lightGold),
          borderRadius: BorderRadius.circular(5.0),
        ),
        suffixIcon: InkWell(
          onTap: suffixAction,
          child: ImageIcon(
            Svg(suffixIconPath),
            color: StyldColors.white,
          ),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
            textStyle: TextStyle(color: StyldColors.white, fontSize: 18.sp)),
        prefixIcon: ImageIcon(
          Svg(iconPath),
          color: StyldColors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 2.0, color: StyldColors.lightGold),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 2.0, color: StyldColors.lightGold),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
