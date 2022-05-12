import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/button.dart';

class UploadImage extends StatefulWidget {
  Function(XFile?) handleImageUpload;
  File? image;

  UploadImage({
    Key? key,
    required this.handleImageUpload,
    required this.image,
  }) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  var imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.grey.shade200,
            image: widget.image != null
                ? DecorationImage(
                    image: FileImage(widget.image!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: widget.image == null
              ? Center(
                  child: Text(
                    AppLocalization.of(context)!
                        .translate('no_picture_selected'),
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                )
              : null,
        ),
        const SizedBox(height: 15),
        AppButton(
          press: () async {
            XFile? image = await imagePicker.pickImage(
              source: ImageSource.gallery,
            );
            widget.handleImageUpload(image);
          },
          text: 'Rasm yuklash',
          icon: Icons.file_upload_outlined,
        ),
      ],
    );
  }
}
