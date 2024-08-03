// import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seproject/other/api_calls.dart';
import 'package:seproject/other/color_palette.dart';

class Image_pic_pre extends StatefulWidget {
  static File? _imageFile;
  static String? fileName;

  static File? getImageFile() {
    return _imageFile;
  }

  static String? getImageFileName() {
    return fileName;
  }

  static Future<String?> upload() async {
    if (_imageFile == null) {
      return null;
    }
    final resp = await ApiRequester.uploadImage(_imageFile!.path);
    return resp;
  }

  @override
  _Image_pic_preState createState() => _Image_pic_preState();
}

class _Image_pic_preState extends State<Image_pic_pre> {
  //  static  File? Image_pic_pre._imageFile ;
  // String? Image_pic_pre.fileName;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        Image_pic_pre._imageFile = File(pickedFile.path);
        Image_pic_pre.fileName = Image_pic_pre._imageFile!.path.split('/').last;
      }
    });
  }

  _previewImage() {
    if (Image_pic_pre._imageFile != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(background_darkgrey),
            title: Text('Image Preview'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Image.file(Image_pic_pre._imageFile!),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(golden_yellow)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close', style: TextStyle(color: Color(background_darkgrey)),),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(background_darkgrey),
            title: Text('Image Preview'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    children: [
                      Text("No Image Selected Please select one from Photos",style: TextStyle(color: Color(text_dm_offwhite), fontWeight: FontWeight.w600))
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(golden_yellow)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close', style: TextStyle(color: Color(background_darkgrey))),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String? fileName = Image_pic_pre.fileName;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image_pic_pre._imageFile == null
              ? Text('No image selected.', style: TextStyle(color: Color(text_dm_offwhite)),)
              : Wrap(
                  children: [
                    Text('Chosen Image : $fileName',
                        style: TextStyle(color: Color(text_dm_offwhite)))
                  ],
                ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
                child: Card(
                    color: Color(golden_yellow),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Set border radius
                      side: BorderSide(color: Colors.black), // Set border color
                    ),
                    child: Center(
                      child: Text(
                        "Upload",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff181816)),
                      ),
                    )),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  _previewImage();
                },
                child: Card(
                    color: Color(golden_yellow),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Set border radius
                      side: BorderSide(color: Colors.black), // Set border color
                    ),
                    child: Center(
                      child: Text(
                        "Preview",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff181816)),
                      ),
                    )),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
