import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/ui/custom_widgets/stylist_side_widgets/add_service_tile.dart';
import 'package:styld_stylist/ui/custom_widgets/stylist_side_widgets/other_service_tile.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/authentication/signUpScreen/complete_registration_view.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/authentication/stylist-auth-view-model.dart';
import 'add_service_states.dart';

class SelectService {
  String? label;
  String? icon;
  bool? isSelected;
  SelectService(this.label, this.icon, {this.isSelected = false});
}

const List<String> iconList = [
  StyldImages.hairCuttingIcon,
  StyldImages.waxingIcon,
  StyldImages.nailIcon,
  StyldImages.facialIcon,
  StyldImages.massageIcon,
  StyldImages.addOtherIcon,
];
const List<String> titleList = [
  'Hair-cutting',
  'Waxing & other',
  'Nail treatments',
  'Facials & skin',
  'Massage',
];

class AddServiceDialog extends StatefulWidget {
  const AddServiceDialog({Key? key}) : super(key: key);

  @override
  State<AddServiceDialog> createState() => _AddServiceDialogState();
}

class _AddServiceDialogState extends State<AddServiceDialog> {
  List<SelectService> availableServices = [];
  @override
  void initState() {
    availableServices.add(SelectService(
        'Hair-cutting', StyldImages.hairCuttingIcon,
        isSelected: true));
    availableServices.add(SelectService(
      'Waxing & other',
      StyldImages.waxingIcon,
    ));
    availableServices.add(SelectService(
      'Nail treatments',
      StyldImages.nailIcon,
    ));
    availableServices.add(SelectService(
      'Facials & skin',
      StyldImages.facialIcon,
    ));
    availableServices.add(SelectService(
      'Massage',
      StyldImages.massageIcon,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      // title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'Add Services',
              textAlign: TextAlign.center,
              style: r_21_gld,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Services',
                  style: r_12_b,
                ),
                Row(
                  children: [
                    Text(
                      'Select All',
                      style: r_12_b,
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor:
                          MaterialStateProperty.all(StyldColors.darkGold),
                      value: context.watch<AddServiceStates>().selectAll,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      onChanged: (bool? value) {
                        context.read<AddServiceStates>().toggleSelectAll();
                        if (value!) {
                          availableServices.forEach((element) {
                            element.isSelected = true;
                          });
                        } else {
                          availableServices.forEach((element) {
                            element.isSelected = false;
                          });
                        }
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
            Column(
                children: List.generate(
                    availableServices.length,
                    (index) => AddServiceTile(
                          action: (bool? val) {
                            availableServices[index].isSelected = val;
                            setState(() {});
                          },
                          value: availableServices[index].isSelected!,
                          icon: availableServices[index].icon!,
                          title: availableServices[index].label!,
                        ))),

            // AddServiceTile(
            //     action: (bool? val) =>
            //         context.read<AddServiceStates>().toggleService(index: 1),
            //     value: context.watch<AddServiceStates>().selectionStates[1],
            //     icon: iconList[1],
            //     title: titleList[1]),
            // AddServiceTile(
            //     action: (bool? val) =>
            //         context.read<AddServiceStates>().toggleService(index: 2),
            //     value: context.watch<AddServiceStates>().selectionStates[2],
            //     icon: iconList[2],
            //     title: titleList[2]),
            // AddServiceTile(
            //     action: (bool? val) =>
            //         context.read<AddServiceStates>().toggleService(index: 3),
            //     value: context.watch<AddServiceStates>().selectionStates[3],
            //     icon: iconList[3],
            //     title: titleList[3]),
            // AddServiceTile(
            //     action: (bool? val) =>
            //         context.read<AddServiceStates>().toggleService(index: 4),
            //     value: context.watch<AddServiceStates>().selectionStates[4],
            //     icon: iconList[4],
            //     title: titleList[4]),
            // OtherServiceTile(
            //   action: () {},
            // ),
            SizedBox(
              height: 10.h,
            ),
            WidthButton(
                action: () {
                  var model =
                      Provider.of<StylistAuthViewModel>(context, listen: false);
                  model.stylistUser.services = [];
                  for (int i = 0; i < availableServices.length; i++) {
                    if (availableServices[i].isSelected!) {
                      model.stylistUser.services!.add(Service(
                        label: availableServices[i].label,
                      ));
                    }
                  }
                  Get.to(() => CompleteRegistrationView());
                },
                buttonColor: StyldColors.gold,
                buttonColor2: StyldColors.darkGold,
                titleText: 'Add',
                width: 271.w),
          ],
        ),
      ),
    );
  }
}
