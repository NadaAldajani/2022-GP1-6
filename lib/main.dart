import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: GetMaterialApp(
        scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(),
        home: SafeArea(child: Login()),
      ),
    );
  }
}
