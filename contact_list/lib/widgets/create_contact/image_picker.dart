import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    super.key,
    required this.onPickImage,
    this.pickedImage,
    required this.onValidateForm,
  });

  final void Function(File pickedImage) onPickImage;
  final void Function(String value) onValidateForm;

  final File? pickedImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? pickedImageFile;
  @override
  void initState() {
    pickedImageFile = widget.pickedImage;
    super.initState();
  }

  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() {
      pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(pickedImageFile!);
    widget.onValidateForm('value');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 64,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundImage:
              pickedImageFile != null ? FileImage(pickedImageFile!) : null,
        ),
        TextButton(
          onPressed: pickImage,
          child: Text(
            pickedImageFile != null ? 'Change photo' : 'Add photo',
            style: const TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }
}
