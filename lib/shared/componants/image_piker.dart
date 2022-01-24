import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImagePiker extends StatefulWidget {
  const ImagePiker({Key? key}) : super(key: key);

  @override
  _ImagePikerState createState() => _ImagePikerState();
}

class _ImagePikerState extends State<ImagePiker> {
  final ImagePicker _imagePicker = ImagePicker();
  String? imageUrl;
  File? imageUI;

 Future getImage(ImageSource src) async {
    final image = await _imagePicker.pickImage(source: src);
    if (image == null)return;
    final file = File(image.path);
    setState(() {
      imageUI = file;
    });
    print(image.path);
    print(file);
    if (file == null)return;

    // String base64=base64Encode(file.readAsBytesSync());
    // print(base64);
    // String imageName=file.path.split("/").last;
    // print("Image name : "+imageName);
    // var url="http://192.168.1.3/api/login";
    // var data={"image":base64};
   // var response = await http.post(Uri.parse(url),body:data);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                    image: imageUI == null ? Image.asset("images/face.gif").image : Image.file(imageUI!, fit: BoxFit.cover,).image)),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            child: IconButton(
              icon: Icon(Icons.camera_alt_outlined),
              onPressed: () {
                getImage(ImageSource.camera);
              },
            ),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
          ),
        )
      ],
    );
  }
}
