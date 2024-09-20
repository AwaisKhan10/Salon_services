import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/ui/custom_widgets/next_icon_button.dart';
import 'package:styld_stylist/ui/custom_widgets/stylist_side_widgets/tag_button.dart';
import 'package:styld_stylist/ui/custom_widgets/time_slot/time_slot_widget.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/authentication/signUpScreen/price_details_screen.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/authentication/stylist-auth-view-model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CompleteRegistrationView extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CompleteRegistrationView({Key? key}) : super(key: key);

  @override
  State<CompleteRegistrationView> createState() =>
      _CompleteRegistrationViewState();
}

class _CompleteRegistrationViewState extends State<CompleteRegistrationView> {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<StylistAuthViewModel>(builder: (context, model, child) {
      return Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Image.asset(StyldImages.mediumLogo)),
                SizedBox(height: 18),

                // const Spacer(),
                Center(
                  child: Text(
                    'Complete Registration',
                    style: GoogleFonts.baskervville(textStyle: welcomeText),
                  ),
                ),
                SizedBox(height: 30),

                Center(
                  child: Text(
                    'Select Your Available Time Slot',
                    style: GoogleFonts.roboto(textStyle: r_16),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: model.timeSlots.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, mainAxisSpacing: 0),
                    itemBuilder: (context, index) {
                      return TimeSlotWidget(
                          action: () {
                            setState(() {
                              model.timeSlots[index].isActive =
                                  !model.timeSlots[index].isActive;
                            });
                          },
                          isActive: model.timeSlots[index].isActive,
                          value: model.timeSlots[index].slot);
                    }),
                Center(
                  child: Text(
                    'Add Custom Time Slots',
                    style: GoogleFonts.roboto(textStyle: r_18),
                  ),
                ),
                const SizedBox(height: 15),
                _customTimeField(model),
                const SizedBox(
                  height: 15,
                ),
                WidthButton(
                    action: () {
                      model.addCustomTimeSlots();
                    },
                    buttonColor: StyldColors.lightGold,
                    buttonColor2: StyldColors.darkGold,
                    titleText: 'Add Time Slot',
                    width: 335),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Choose your Availability Days',
                    style: GoogleFonts.roboto(textStyle: r_16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                _daysSelectionSection(model),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Select Days you want to work each month',
                    style: GoogleFonts.roboto(textStyle: r_16),
                  ),
                ),
                SizedBox(height: 10),

                ///
                /// range picker
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                        color: Color(0xFF262A34),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SfDateRangePicker(
                        backgroundColor: Color(0xFF262A34),
                        controller: model.controller,
                        view: DateRangePickerView.month,
                        headerHeight: 0,
                        monthViewSettings:
                            const DateRangePickerMonthViewSettings(
                                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                                  textStyle: TextStyle(
                                      color: Color(0xFFE8E6F1), fontSize: 13),
                                ),
                                firstDayOfWeek: 1,
                                dayFormat: 'EEE'),
                        monthCellStyle: const DateRangePickerMonthCellStyle(
                            todayTextStyle: TextStyle(
                                color: Color(0xFFE8E6F1), fontSize: 13),
                            textStyle: TextStyle(
                                color: Color(0xFFE8E6F1), fontSize: 13)),
                        todayHighlightColor: Colors.transparent,
                        selectionColor:
                            const Color(0xFFDFBD8D).withOpacity(0.5),
                        rangeSelectionColor:
                            const Color(0xFFDFBD8D).withOpacity(0.5),
                        startRangeSelectionColor:
                            const Color(0xFFDFBD8D).withOpacity(0.5),
                        endRangeSelectionColor:
                            const Color(0xFFDFBD8D).withOpacity(0.5),
                        selectionRadius: 15,
                        onSelectionChanged:
                            (DateRangePickerSelectionChangedArgs args) {
                          model.onSelectionChanged(args);
                        },
                        selectionMode: DateRangePickerSelectionMode.range,
                        rangeTextStyle: const TextStyle(
                            color: Color(0xFFDFBD8D),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'About your services',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: StyldColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    // width: MediaQuery.of(context).size.width * 0.85,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      // color: StyldColors.blue,
                      border:
                          Border.all(color: StyldColors.lightGrey, width: 2.0),
                    ),
                    child: AutoSizeTextField(
                      onChanged: (value) {
                        model.stylistUser.aboutService = value;
                      },
                      keyboardType: TextInputType.multiline,
                      controller: model.aboutController,
                      minLines: 1, //Normal textInputField will be displayed
                      maxLines: 6,
                      style: GoogleFonts.roboto(textStyle: r_17),
                      cursorColor: StyldColors.white,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: "Add service details here...",
                        hintStyle: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic)
                                .copyWith(color: StyldColors.lightGrey)),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Tags for your services',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: StyldColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _tagsSection(model),
                NextIconButton(
                    action: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        var model = Provider.of<StylistAuthViewModel>(context,
                            listen: false);
                        model.stylistUser.availableTimings = [];
                        model.stylistUser.availableDays = [];
                        model.stylistUser.tags = [];
                        //first give all timings to stylist profile
                        model.timeSlots.forEach((tslot) {
                          if (tslot.isActive) {
                            model.stylistUser.availableTimings!
                                .add(AvailableTiming(time: tslot.slot));
                          }
                        });

                        //then give days
                        model.days.forEach((day) {
                          if (day.active) {
                            model.stylistUser.availableDays!
                                .add(AvailableDay(day: day.day));
                          }
                        });

                        // then give tags

                        model.services.forEach((tag) {
                          if (tag.active) {
                            model.stylistUser.tags!.add(Tag(label: tag.name));
                          }
                        });

                        Get.to(() => PriceDetailsScreen());
                      }
                    },
                    icon: StyldImages.nextIcon,
                    title: 'Next'.toUpperCase()),
                const SizedBox(
                  height: 5,
                ),

                // const Spacer(),
              ],
            ),
          ),
        ),
      );
    });
  }

  _tagsSection(StylistAuthViewModel model) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: StyldColors.lightGrey, width: 2.0),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            children: [
              RegistrationTagButton(
                tagValue: model.services[0].name,
                selected: model.services[0].active,
                callback: () => setState(() {
                  model.services[0].active = !model.services[0].active;
                }),
              ),
              RegistrationTagButton(
                tagValue: model.services[1].name,
                selected: model.services[1].active,
                callback: () => setState(() {
                  model.services[1].active = !model.services[1].active;
                }),
              ),
              RegistrationTagButton(
                tagValue: model.services[2].name,
                selected: model.services[2].active,
                callback: () => setState(() {
                  model.services[2].active = !model.services[2].active;
                }),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              RegistrationTagButton(
                tagValue: model.services[3].name,
                selected: model.services[3].active,
                callback: () => setState(() {
                  model.services[3].active = !model.services[3].active;
                }),
              ),
              RegistrationTagButton(
                tagValue: model.services[4].name,
                selected: model.services[4].active,
                callback: () => setState(() {
                  model.services[4].active = !model.services[4].active;
                }),
              ),
              RegistrationTagButton(
                tagValue: model.services[5].name,
                selected: model.services[5].active,
                callback: () => setState(() {
                  model.services[5].active = !model.services[5].active;
                }),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              RegistrationTagButton(
                tagValue: model.services[6].name,
                selected: model.services[6].active,
                callback: () => setState(() {
                  model.services[6].active = !model.services[6].active;
                }),
              ),
              RegistrationTagButton(
                tagValue: model.services[7].name,
                selected: model.services[7].active,
                callback: () => setState(() {
                  model.services[7].active = !model.services[7].active;
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _customTimeField(StylistAuthViewModel model) {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      // color: StyldColors.blue,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: StyldColors.lightGold,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
                width: 61,
                height: 41,
                child: TextFormField(
                    cursorColor: StyldColors.white,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                        border: InputBorder.none),
                    style:
                        const TextStyle(color: StyldColors.white, fontSize: 32),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      if (value.length >= 2) {
                        model.customTimeSlotHr = value.substring(0, 2);
                        print(model.customTimeSlotHr);
                      } else {
                        model.customTimeSlotHr = value;
                        print(model.customTimeSlotHr);
                      }
                    }),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: const Color(0xFFDFBD8D)))),
            SizedBox(width: 10),
            Column(
              children: [
                Container(
                    height: 7,
                    width: 7,
                    decoration: const BoxDecoration(
                        color: Color(0xFFDFBD8D), shape: BoxShape.circle)),
                const SizedBox(height: 8),
                Container(
                    height: 7,
                    width: 7,
                    decoration: const BoxDecoration(
                        color: Color(0xFFDFBD8D), shape: BoxShape.circle)),
              ],
            ),
            const SizedBox(width: 10),
            Container(
                width: 61,
                height: 41,
                child: TextFormField(
                    cursorColor: StyldColors.white,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                        border: InputBorder.none),
                    style:
                        const TextStyle(color: StyldColors.white, fontSize: 32),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      if (value.length >= 2) {
                        model.customTimeSlotMin = value.substring(0, 2);
                        print(model.customTimeSlotMin);
                      } else {
                        model.customTimeSlotMin = value;
                        print(model.customTimeSlotMin);
                      }
                    }),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: const Color(0xFFDFBD8D)))),
          ],
        ),
        SizedBox(width: 14),
        Container(
          margin: EdgeInsets.only(right: 45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    model.customTimeSlotMeridian == 'AM';
                  });
                },
                child: Container(
                  width: 33,
                  height: 21,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: StyldColors.lightGold, width: 1.0),
                    borderRadius: BorderRadius.circular(3.0),
                    color: model.customTimeSlotMeridian == 'AM'
                        ? StyldColors.lightGold
                        : StyldColors.black,
                  ),
                  child: Center(
                      child: Text(
                    'AM',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: model.customTimeSlotMeridian == 'AM'
                            ? StyldColors.black
                            : StyldColors.lightGold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )),
                ),
              ),
              SizedBox(height: 5),
              InkWell(
                onTap: () {
                  setState(() {
                    model.customTimeSlotMeridian = 'PM';
                  });
                },
                child: Container(
                  width: 33,
                  height: 21,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: StyldColors.lightGold, width: 1.0),
                    borderRadius: BorderRadius.circular(3.0),
                    color: model.customTimeSlotMeridian == 'PM'
                        ? StyldColors.lightGold
                        : StyldColors.black,
                  ),
                  child: Center(
                      child: Text(
                    'PM',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: model.customTimeSlotMeridian == 'PM'
                            ? StyldColors.black
                            : StyldColors.lightGold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _daysSelectionSection(StylistAuthViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var i = 0; i < 4; i++)
              Flexible(
                child: TimeSlotWidget(
                    action: () {
                      setState(() {
                        model.days[i].active = !model.days[i].active;
                      });
                    },
                    isActive: model.days[i].active,
                    value: model.days[i].day),
              ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 4; i < 7; i++)
              Flexible(
                child: TimeSlotWidget(
                    action: () {
                      setState(() {
                        model.days[i].active = !model.days[i].active;
                      });
                    },
                    isActive: model.days[i].active,
                    value: model.days[i].day),
              ),
          ],
        ),
      ],
    );
  }
}
