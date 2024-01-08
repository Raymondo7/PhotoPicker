import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'creer.dart';
import 'gallery.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: primColor,
          height: 80,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.camera_on_rectangle,
                size: 50,),
              label: 'Créer',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.folder,
                size: 50,),
              label: 'Search',
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          Widget selectedScreen;
          switch (index) {
            case 0:
              selectedScreen = const CreateTab();
              break;
            case 1:
              selectedScreen = const GalleryTab();
              break;
            default:
              selectedScreen = const CreateTab();
          }
          return selectedScreen;
        },
      ),
    );
  }
}


