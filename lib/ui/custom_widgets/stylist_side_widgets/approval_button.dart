import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

class ApprovalButtonColor extends StatelessWidget {
  final VoidCallback? action;
  final String title;
  final Color color;
  final bool isBlack;
  const ApprovalButtonColor(
      {Key? key,
      this.action,
      required this.color,
      required this.title,
      required this.isBlack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        height: 28,
        width: 118,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: color,
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.roboto(
                textStyle: isBlack ? buttonStyleBlack : buttonStyle),
          ),
        ),
      ),
    );
  }
}
