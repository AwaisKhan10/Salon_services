import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class SimpleTextField extends StatelessWidget {
  final TextEditingController? fieldController;
  final onsaved;
  final onChange;
  final validatorFunction;
  final String? hintText;
  final String? iconPath;
  final icon;
  const SimpleTextField(
      {Key? key,
       this.fieldController,
      this.validatorFunction,
      this.onsaved,
       this.hintText,
      this.onChange,
      this.icon,
      this.iconPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onsaved,
      controller: fieldController,
      onChanged: onChange,
      validator: validatorFunction,
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
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
            textStyle: TextStyle(color: StyldColors.white, fontSize: 18.sp)),
        prefixIcon: iconPath == null ? Icon(icon, color: StyldColors.gold) : ImageIcon(
          Svg(iconPath!),
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
