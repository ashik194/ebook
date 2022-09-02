import 'package:ebook/pages/home.dart';
import 'package:flutter/material.dart';

void main(){
  return runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Audio Reading App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue
      ),
      home: Material(
        child: HomePage(),
      ),
    );
  }
}
