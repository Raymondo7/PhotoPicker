import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/gallery.dart';
import 'dart:io';

import 'database.dart';

class Vue extends StatefulWidget {
  const Vue({super.key, required this.file});
  final File file;

  @override
  State<Vue> createState() => _VueState();
}

class _VueState extends State<Vue> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: IconButton(
          icon: const Icon(
            CupertinoIcons.check_mark,
            weight: 12.0,
          ),
          onPressed: () async {
            Photo newPhoto = Photo(file: widget.file.path);
            await dbHelper.insertPhoto(newPhoto);
            setState(() {});
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GalleryTab()));
          },
        ),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.clear,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: Center(
        child: IntrinsicWidth(
          child: IntrinsicHeight(
            child: Image.file(widget.file),
          ),
        ),
      ),
    );
  }
}
