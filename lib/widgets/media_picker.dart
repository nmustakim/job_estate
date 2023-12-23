import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImagePickerWidget extends StatefulWidget {
  final ValueChanged<String> onImagePicked;

  ImagePickerWidget({required this.onImagePicked});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _showPickImageDialog() async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Pick Image'),
          children: <Widget>[
            _buildDialogOption('Take a new photo', ImageSource.camera),
            _buildDialogOption('Pick from gallery', ImageSource.gallery),
          ],
        );
      },
    );

    if (source != null) {
      _pickImage(source);
    }
  }

  SimpleDialogOption _buildDialogOption(String text, ImageSource source) {
    return SimpleDialogOption(
      onPressed: () {
        Navigator.pop(context, source);
      },
      child: Text(text),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);

      if (image != null) {
        final String imageURL = await _uploadImageToFirebase(image.path);
        widget.onImagePicked(imageURL);
      } else {
        _showSnackBar('Image picking canceled');
      }
    } catch (e) {
      // Handle exceptions
      print('Error picking image: $e');
      _showSnackBar('Error picking image: $e');
    }
  }

  Future<String> _uploadImageToFirebase(String imagePath) async {
    try {
      final Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('logos/${DateTime.now().millisecondsSinceEpoch.toString()}');

      final UploadTask uploadTask = storageReference.putFile(
        File(imagePath),
        firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
      );

      await uploadTask.whenComplete(() => null);

      final String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      // Handle exceptions
      print('Error uploading image to Firebase: $e');
      _showSnackBar('Error uploading image to Firebase: $e');
      rethrow;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPickImageDialog,
      child: Text('Logo'),
    );
  }
}
