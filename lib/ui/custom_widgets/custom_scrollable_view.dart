import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScrollableView extends StatelessWidget {
  final bool? coverWholeWidth;
  final Widget widget;
  const CustomScrollableView(
      {Key? key, required this.widget, this.coverWholeWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            margin: coverWholeWidth == true
                ? EdgeInsets.symmetric(horizontal: 0.w)
                : EdgeInsets.symmetric(horizontal: 15.w),
            child: widget,
          ),
        ),
      ],
    );
  }
}
