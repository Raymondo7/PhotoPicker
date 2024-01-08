import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/constants.dart';
import 'dart:io';

import 'package:myapp/vue_image.dart';


class CreateTab extends StatefulWidget {
  const CreateTab({super.key});

  @override
  State<CreateTab> createState() => _CreateTabState();
}

class _CreateTabState extends State<CreateTab> {
  final picker = ImagePicker();
  late File pickedImage ;

  Future<void> _pickImageFromGallery() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      pickedImage = File(pickedFile.path);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Vue(file: pickedImage)));
    }
  }

  Future<void> _pickImageFromCamera() async{
    final pickedFile =  await picker.pickImage(source: ImageSource.camera);


    if(pickedFile != null ){
      pickedImage = File(pickedFile.path);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Vue(file: pickedImage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Créer',
        style: stylish(25, primColor)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: secColor,
                backgroundColor: primColor
              ),
                onPressed: (){
                _pickImageFromGallery();
                },
                child: Text(
                    'Importer de la galerie',
                  style: stylish(18, secColor),
                )
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: secColor,
                    backgroundColor: primColor
                ),
                onPressed: (){
                  _pickImageFromCamera();
                },
                child: Text(
                  'Prendre avec l\'appareil photo',
                  style: stylish(18, secColor),
                )
            )
          ],
        ),
      ),
    );
  }
}