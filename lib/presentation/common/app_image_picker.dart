import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:moreinfo/data/providers/config.dart';
import 'package:moreinfo/presentation/config/constants.dart';

const defaultImage =
    'https://cdn3.vectorstock.com/i/thumb-large/32/12/default-avatar-profile-icon-vector-39013212.jpg';

const decoration = BoxDecoration(
  color: lightGray,
  shape: BoxShape.circle,
);

class AppImagePicker extends StatefulWidget {
  String userImage;
  void Function(String) setImage;
  AppImagePicker({required this.userImage, required this.setImage});
  @override
  AppImagePickerState createState() => AppImagePickerState();
}

class AppImagePickerState extends State<AppImagePicker> {
  var _image;
  var imagePicker;

  AppImagePickerState();

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          XFile? image = await imagePicker.pickImage(
            source: ImageSource.gallery,
          );
          if (image != null) {
            setState(() {
              _image = File(image.path);
              widget.setImage(image.path);
            });
          }
        },
        child: Container(
          width: 150,
          height: 150,
          decoration: decoration,
          child: _image != null
              ? CircleAvatar(
                  radius: 75,
                  backgroundImage: FileImage(_image),
                )
              : CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(
                    widget.userImage != 'null'
                        ? widget.userImage
                        : defaultImage,
                  ),
                ),
        ),
      ),
    );
  }
}
