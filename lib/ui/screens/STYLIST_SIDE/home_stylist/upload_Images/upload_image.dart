import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:get/get.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/home_stylist/home_viewmodel.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImage extends StatefulWidget {
  final imageType;
  const UploadImage({this.imageType});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final ValueNotifier<bool> _pickedImage = ValueNotifier(false);
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeStylistViewModel(isGetPosts: false),
      child: Consumer<HomeStylistViewModel>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: StyldColors.black,
              elevation: 0.0,
              title: Text(
                'New Post',
                style: GoogleFonts.roboto(textStyle: r_18),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(StyldImages.backIcon),
              ),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    child: ValueListenableBuilder(
                      valueListenable: _pickedImage,
                      builder: (context, hasError, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(StyldImages.cameraIcon),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'Add Photos',
                                  style: GoogleFonts.roboto(textStyle: r_16),
                                ),
                              ],
                            ),
                            Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9.0),
                                          color: StyldColors.darkGold,
                                        ),
                                        width: 89,
                                        height: 93,
                                        // padding: EdgeInsets.symmetric(
                                        //     horizontal: 15.w,
                                        //     vertical: 10.w,
                                        //   ),
                                        child: InkWell(
                                          onTap: () {
                                            model.getImages();
                                          },
                                          child: SvgPicture.asset(
                                            StyldImages.uploadPhotos,
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                // :
                                //  Container(
                                //     margin:
                                //         EdgeInsets.symmetric(vertical: 10.h),
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(9.0),
                                //       color: StyldColors.darkGold,
                                //     ),
                                //     width: MediaQuery.of(context).size.width,
                                //     padding: EdgeInsets.symmetric(
                                //       horizontal: 15.w,
                                //       vertical: 10.w,
                                //     ),
                                //     child: InkWell(
                                //       onTap: () {
                                //         model.getImages();
                                //       },
                                //       child: SvgPicture.asset(
                                //           StyldImages.uploadPhotos),
                                //     ),
                                //   ),
                                  Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(6),
                                            child: Container(
                                              height: 8.h,
                                              width: 1.sw,
                                              color: Colors.grey.withOpacity(0.2),
                                              child: model.image == null ? Container(): Image.file(model.image!, fit: BoxFit.cover)
                                              // child: ListView.builder(
                                              //     shrinkWrap: true,
                                              //     scrollDirection: Axis.horizontal,
                                              //     itemCount:
                                              //         model.uplodImages.length,
                                              //     itemBuilder: (context, index) {
                                              //       return Container(
                                              //         margin: EdgeInsets.symmetric(
                                              //             vertical: 10.h,
                                              //             horizontal: 5.w),
                                              //         decoration: BoxDecoration(
                                              //           image: DecorationImage(
                                              //               fit: BoxFit.cover,
                                              //               image: FileImage(File(
                                              //                   model
                                              //                       .uplodImages[
                                              //                           index]
                                              //                       .path))),
                                              //           borderRadius:
                                              //               BorderRadius.circular(
                                              //                   9.0),
                                              //           // color: StyldColors.darkGold,
                                              //         ),
                                              //         width: 89,
                                              //         height: 93,
                                              //         // padding: EdgeInsets.symmetric(
                                              //         //   horizontal: 15.w,
                                              //         //   vertical: 10.w,
                                              //         // ),
                                              //       );
                                              //     }),
                                            ),
                                          ),
                                        ),
                                      ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Text(
                                  'Description',
                                  style: GoogleFonts.roboto(textStyle: r_16),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5.h),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: StyldColors.lightGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                  // color: StyldColors.blue,
                                ),
                                width: MediaQuery.of(context).size.width * 0.85,
                                height:
                                    MediaQuery.of(context).size.height * 0.28,
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 10,
                                  // controller: _reviewController,
                                  style: GoogleFonts.roboto(textStyle: r_17),
                                  cursorColor: StyldColors.white,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please add post description';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    model.post.description = value;
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintText:
                                        "The description may be title, Caption or details about photos",
                                    hintStyle: GoogleFonts.roboto(
                                        textStyle: r_17.copyWith(
                                            color: StyldColors.lightGrey)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 45.h,
                            ),

                            WidthButton(
                                action: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (model.image != null) {
                                      model.getImagesUrl();
                                    } else {
                                      Get.snackbar('Required!',
                                          'Please add images of the post',
                                          colorText: StyldColors.white,
                                          snackPosition: SnackPosition.BOTTOM);
                                    }
                                  }
                                },
                                width: 340.w,
                                buttonColor: StyldColors.lightGold,
                                titleText: 'Upload Images'),

                            // Center(
                            //   child: Container(
                            //     // height: MediaQuery.of(context).size.height * 0.15,
                            //     height: 150,
                            //     // width: MediaQuery.of(context).size.width * 0.85,
                            //     margin: EdgeInsets.symmetric(vertical: 5.h),
                            //     padding: EdgeInsets.symmetric(horizontal: 10.w),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(4.0),
                            //       color: StyldColors.blue,
                            //     ),
                            //     child:
                            //   ),
                            // ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
