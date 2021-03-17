import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';

import '../../models/product.dart';

class ImageInput extends StatefulWidget {
  final Function setImage;
  final Product product;

  ImageInput(this.setImage, this.product);

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile;

  _getImage(ImageSource source) {
    ImagePicker.pickImage(source: source).then((image) {
      setState(() {
        _imageFile = image;
      });

      ImageCropper.cropImage(
        sourcePath: image.path,
        maxHeight: 600,
        maxWidth: 600,
      ).then((croppedImage) {
        setState(() {
          _imageFile = croppedImage;
        });

        widget.setImage(croppedImage);
      });

      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Text(
                'Pick an Image',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Use Camera'),
                onPressed: () {
                  _getImage(ImageSource.camera);
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Use Gallery'),
                onPressed: () {
                  _getImage(ImageSource.gallery);
                },
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).primaryColor;
    Widget previewImage = Text('Please Select an Image');
    if (_imageFile != null) {
      previewImage = Image.file(
        _imageFile,
        fit: BoxFit.cover,
        height: 512.0,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topCenter,
      );
    } else if (widget.product != null) {
      previewImage = Image.network(
        widget.product.image,
        fit: BoxFit.cover,
        height: 512.0,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topCenter,
      );
    }
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(
            color: buttonColor,
            width: 2.0,
          ),
          onPressed: () {
            _openImagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                color: buttonColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Add Image',
                style: TextStyle(color: buttonColor),
              )
            ],
          ),
        ),
        SizedBox(height: 10.0),
        previewImage,
      ],
    );
  }
}
