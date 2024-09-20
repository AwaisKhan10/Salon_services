import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final double? radius;
  // ignore: prefer_const_constructors_in_immutables
  UserImagePicker({Key? key, required this.imageType, this.radius})
      : super(key: key);
  final Function(File path)? imageType;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
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
          onTap: () => _showPicker(context),
          child: Column(
            children: [
              if (_pickedImage.value)
                CircleAvatar(
                  radius: widget.radius ?? 35,
                  // backgroundImage: Image(image:   FileImage(imageFile),),
                  backgroundColor: StyldColors.black,
                  foregroundColor: StyldColors.black,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Image(
                      fit: BoxFit.cover,
                      height: 80,
                      width: 80,
                      image: FileImage(File(_imageFile!.path)),
                    ),
                  ),
                  // child: FileImage(file),
                ),
              if (!(_pickedImage.value))
                CircleAvatar(
                  radius: widget.radius ?? 35.h,
                  backgroundImage: const AssetImage(
                    StyldImages.userAvatar,
                  ),
                  backgroundColor: StyldColors.black,
                  foregroundColor: StyldColors.black,
                  // child: FileImage(file),
                ),
              SizedBox(
                height: 5.h,
              ),
              SvgPicture.asset(StyldImages.addPhoto),
            ],
          ),
        );
      },
    );
  }
}
