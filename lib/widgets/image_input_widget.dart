import 'package:flutter/material.dart';

import 'dart:io';

class ImageInputWidget extends StatefulWidget {
  @override
  _ImageInputWidgetState createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery.of(context).size;
    File _storedImage;
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
              onTap: (){print("This got tapped");},
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
