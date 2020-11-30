import 'package:flutter/material.dart';

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputWidget extends StatefulWidget {

  final Function onSelectImage;
  ImageInputWidget(this.onSelectImage);

  @override
  _ImageInputWidgetState createState() => _ImageInputWidgetState();
}


class _ImageInputWidgetState extends State<ImageInputWidget> {
  File _storedImage;

  Future<void> _takePicture() async{
   final File imageFile = await ImagePicker.pickImage(
       source: ImageSource.camera,
       maxHeight: 450);

   if(imageFile == null) return;

   setState(() {
     _storedImage = imageFile;
   });

   //Find system path that can be used to store image
   Directory appDocDir = await getApplicationDocumentsDirectory();
   //Name of the file where the image is located
   final String fileName = path.basename(imageFile.path);
   //Copy the saved image locally to the device
   final File savedImage = await imageFile.copy('${appDocDir.path}/$fileName');
   widget.onSelectImage(savedImage);

  }

  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          width: _mediaQuery.width * 0.65,
          height: _mediaQuery.height * 0.35,
          decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(_storedImage, fit: BoxFit.cover, width: double.infinity)
              : Text('No image picked',),
          alignment: Alignment.center,
        ),
        Expanded(
            child: GestureDetector(
              onTap: _takePicture,
                child: Image.network('https://icons-for-free.com/iconfiles/png/512/32px+Free+Set+Camera-1320568209414231422.png')
            )
        ),
          /*
          Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          )*/

      ],
    );

  }
}
