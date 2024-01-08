import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryTabState();
}

class _GalleryTabState extends State<Gallery> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late String _file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Add Photo'),
                  content: TextField(
                    decoration: const InputDecoration(labelText: 'file'),
                    onChanged: (value) => _file = value,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          Photo newPhoto = Photo(file: _file);
                          await dbHelper.insertPhoto(newPhoto);
                          setState(() {});
                          Navigator.pop(context);
                        } catch (e) {
                          print('Erreur lors de l\'insertion : $e');
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.add)),
      ),
      body: FutureBuilder<List<Photo>>(
        future: dbHelper.getAllPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('Aucune photo trouvée ou snapshot vide.');
            return const Center(
              child: Text('No Photos found.'),
            );
          }

          print('Données récupérées avec succès : ${snapshot.data}');
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Photo photo = snapshot.data![index];
              return ListTile(
                title: Text(photo.file),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await dbHelper.deletePhoto(photo.id!);
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}