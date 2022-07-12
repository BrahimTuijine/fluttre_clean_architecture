import 'package:clean_architecture/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: Scaffold(

        appBar: AppBar(
          title: const Text('Posts App'),
        ),
        body: Container(
          child: TextFormField()
        ),
      ),
    );
  }
}
