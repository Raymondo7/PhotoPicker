import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constants.dart';

import 'database.dart';

class GalleryTab extends StatefulWidget {
  const GalleryTab({super.key});

  @override
  State<GalleryTab> createState() => _GalleryTabState();
}

class _GalleryTabState extends State<GalleryTab> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Galerie', style: stylish(25, primColor),),
      ),
      body: FutureBuilder<List<Photo>>(
        future: dbHelper.getAllPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Aucune photo.'),
            );
          }

          return GridView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Photo photo = snapshot.data![index];
              final File fichier = File(photo.file.trim());
              return GridTile(
                footer: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await dbHelper.deletePhoto(photo.id!);
                    setState(() {});
                  },
                ),
                child: Image.file(fichier)
                ,
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          );
        },
      ),
    );
  }
}