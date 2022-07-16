<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

<img src="https://raw.githubusercontent.com/imayush-chauhan/Animated_Bottom_Bar/master/screenshot/image.gif" alt="">

## Installation

1. Add the latest version of package to pubspec.yaml

```yaml
dependencies:
  animated_bottom_bar: ^0.0.3
```

2. Import the package

```dart
import 'package:animated_bottom_bar/animated_bottom_bar.dart';
```



```dart
import 'package:animated_bottom_bar/animated_bottom_bar.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  int select = 0;

  Color active = Colors.blue;
  Color inactive = Colors.black;

  List name = [
    "Home",
    "Dashboard",
    "Security",
    "Person",
  ];

  @override
  Widget build(BuildContext context) {
    double mediaQH = MediaQuery.of(context).size.height;
    double mediaQW = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: AnimatedBottomBar(

        width: mediaQW - 30,


        height: mediaQH*0.085,

        selectedIndex: select,

        items: [

          AnimatedBarItem(
            icon: Icon(Icons.home),
          ),

          AnimatedBarItem(
            icon: Icon(Icons.dashboard),
          ),

          AnimatedBarItem(
            icon: Icon(Icons.safety_check),
          ),

          AnimatedBarItem(
            icon: Icon(Icons.person),
          ),

        ],
        onItemSelected: (_){
          setState((){
            select = _;
          });
          print(select);
        },
      ),
      body: Container(
        height: mediaQH,
        width: mediaQW,
        color: Colors.white.withOpacity(0.9),
        alignment: Alignment.center,
        child: Text(name[select]),
      ),
    );
  }
}
```

