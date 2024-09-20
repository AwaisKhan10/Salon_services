import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterSearchScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  FilterSearchScreen({Key? key}) : super(key: key);

  @override
  State<FilterSearchScreen> createState() => _FilterSearchScreenState();
}

class _FilterSearchScreenState extends State<FilterSearchScreen> {
  final List<ValueNotifier> _toggleSettings = [
    ValueNotifier(true),
    ValueNotifier(false),
    ValueNotifier(true),
    ValueNotifier(false),
    ValueNotifier(false),
  ];
  RangeValues values = const RangeValues(10, 100);
  RangeLabels labels = const RangeLabels('\$10', "\$100");
  SfRangeValues _values = const SfRangeValues(10.0, 110.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyldColors.black,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(StyldImages.backIcon),
        ),
        title: Text(
          'Filter',
          style: GoogleFonts.roboto(textStyle: b_16),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Clear',
              style: GoogleFonts.roboto(textStyle: r_16),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: CustomScrollableView(
            coverWholeWidth: true,
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  color: StyldColors.blue,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      'Near By',
                      style: GoogleFonts.roboto(textStyle: b_16),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show Near By Services Providers',
                        style: GoogleFonts.roboto(textStyle: r_16),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _toggleSettings[0],
                        builder: (context, hasError, child) {
                          return Switch(
                            value: _toggleSettings[0].value,
                            onChanged: (val) {
                              _toggleSettings[0].value = val;
                            },
                            activeTrackColor: StyldColors.lightGold,
                            activeColor: const Color(0xFF5B6680),
                            inactiveTrackColor: StyldColors.white,
                            inactiveThumbColor: const Color(0xFF5B6680),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  color: StyldColors.blue,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      'Sort Options',
                      style: GoogleFonts.roboto(textStyle: b_16),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.h,
                ),

                radioTile(title: 'Popularity', value: _toggleSettings[1].value),
                radioTile(
                    title: 'Higher Rating (Highest 1st)',
                    value: _toggleSettings[2].value),
                radioTile(title: 'Top Rated', value: _toggleSettings[3].value),
                radioTile(
                    title: 'Lower Price', value: _toggleSettings[2].value),
                radioTile(
                    title: 'Higher Price', value: _toggleSettings[3].value),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price Range',
                        style: GoogleFonts.roboto(textStyle: b_16),
                      ),
                      Text(
                        '\$10 - \$100',
                        style: GoogleFonts.roboto(textStyle: r_16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                Theme(
                  data: ThemeData(
                    textTheme: TextTheme(
                      bodyLarge: GoogleFonts.roboto(textStyle: r_13),
                    ),
                  ),
                  child: SfRangeSlider(
                    activeColor: StyldColors.lightGold,
                    inactiveColor: StyldColors.white,
                    min: 10.0,
                    max: 100.0,
                    values: _values,
                    stepSize: 10,
                    interval: 10,
                    showTicks: true,
                    labelPlacement: LabelPlacement.betweenTicks,
                    showLabels: true,
                    enableTooltip: true,
                    // minorTicksPerInterval: 1,
                    onChanged: (SfRangeValues values) {
                      setState(() {
                        _values = values;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Center(
                  child: WidthButton(
                      buttonColor: StyldColors.lightGold,
                      buttonColor2: StyldColors.darkGold,
                      titleText: 'APPLY FILTERS',
                      width: 356.w),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget radioTile({required String title, required bool value}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(textStyle: r_16),
          ),
          Radio<bool>(
            toggleable: true,
            // fillColor: ,
            activeColor: StyldColors.lightGold,
            value: true,
            groupValue: value,
            onChanged: (val) {
              setState(() {
                value = val!;
              });
            },
          ),
        ],
      ),
    );
  }
}
