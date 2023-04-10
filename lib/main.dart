import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:news_maker/page/navigator_page.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key?key}) :super (key:key);

  @override
  Widget build(BuildContext context) {

    SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
          systemOverlayStyle: overlayStyle),
        //primarySwatch: Colors.red,
      ),
      home: const NavigatorPage(),
    );
  }
}
