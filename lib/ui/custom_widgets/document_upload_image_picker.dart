import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:image_picker/image_picker.dart';

class DocumentUploadImagePicker extends StatefulWidget {
  final onTap;
  // ignore: prefer_const_constructors_in_immutables
  final String? name;
  DocumentUploadImagePicker(
      {Key? key, required this.imageType, this.name, this.onTap})
      : super(key: key);
  final imageType;

  @override
  State<DocumentUploadImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<DocumentUploadImagePicker> {
  final ValueNotifier<bool> _pickedImage = ValueNotifier(false);
  XFile? _imageFile;
  Future<void> takeImageFromGallery() async {
    final picker = ImagePicker();

    _imageFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (_imageFile == null) return;
    _pickedImage.value = true;

    setState(() {
      widget.imageType!(File(_imageFile!.path));
    });
  }

  Future<void> takeImageFromCamera() async {
    final picker = ImagePicker();
    _imageFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (_imageFile == null) return;
    _pickedImage.value = true;
    setState(() {
      widget.imageType!(File(_imageFile!.path));
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      takeImageFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    takeImageFromCamera();

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _pickedImage,
      builder: (context, hasData, child) {
        return InkWell(
          onTap: widget.onTap,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(5.0),
            color: StyldColors.lightGold,
            strokeWidth: 2,
            child: SizedBox(
              height: 50.h,
              child: Row(children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(StyldImages.uploadIcon),
                ),
                Flexible(
                  child: Text('${widget.name}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: StyldColors.white, fontSize: 18.sp))),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
